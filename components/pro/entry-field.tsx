/**
 * Astrobobo Web Pro — EntryField.
 *
 * Full-screen WebGL cosmic void. Uses the shared `Universe` runtime for
 * physics (cursor gravity, ripples, emotion-modulated drift) and renders
 * the particles as an instanced Points mesh. Three parallax layers —
 * background stars / mid nebula / foreground motes — each with their own
 * depth, size, and drift speed. The cursor position and emotion read
 * straight from the global interaction store so we stay single-sourced.
 */

"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import { Canvas, useFrame, useThree } from "@react-three/fiber";
import * as THREE from "three";
import { Universe } from "@/lib/pro/universe-runtime";
import { useInteraction } from "@/lib/store/interaction-store";

const BG_COLOR = new THREE.Color("#05010A");

/**
 * Decide a performance tier once on the client based on memory,
 * logical cores, and pixel ratio. Tier controls particle counts and
 * whether the shader nebula runs at all.
 */
function usePerformanceTier() {
  const [tier, setTier] = useState<"low" | "mid" | "high">("mid");
  useEffect(() => {
    const nav = navigator as Navigator & { deviceMemory?: number };
    const memory = nav.deviceMemory ?? 4;
    const cores = navigator.hardwareConcurrency ?? 4;
    const dpr = window.devicePixelRatio || 1;
    const isMobile = /Android|iPhone|iPad|iPod/i.test(navigator.userAgent);
    if (memory <= 2 || cores <= 2 || (isMobile && dpr >= 3)) {
      setTier("low");
    } else if (memory >= 8 && cores >= 8) {
      setTier("high");
    } else {
      setTier("mid");
    }
  }, []);
  return tier;
}

const TIER_CONFIG = {
  low: { bg: 40, mid: 60, fg: 25, nebula: false, dpr: [1, 1] as [number, number] },
  mid: { bg: 80, mid: 140, fg: 60, nebula: true, dpr: [1, 1.5] as [number, number] },
  high: { bg: 120, mid: 200, fg: 80, nebula: true, dpr: [1, 2] as [number, number] },
} as const;

function Nebula() {
  const meshRef = useRef<THREE.Mesh>(null);
  const matRef = useRef<THREE.ShaderMaterial>(null);
  const { viewport } = useThree();

  useFrame((state) => {
    if (!matRef.current) return;
    const t = state.clock.elapsedTime;
    const { cursor, emotion } = useInteraction.getState();
    matRef.current.uniforms.uTime.value = t;
    matRef.current.uniforms.uCursor.value.set(cursor.x, 1 - cursor.y);
    matRef.current.uniforms.uExcite.value = emotion.excitement;
    matRef.current.uniforms.uCuriosity.value = emotion.curiosity;
  });

  return (
    <mesh ref={meshRef} position={[0, 0, -4]}>
      <planeGeometry args={[viewport.width * 2.5, viewport.height * 2.5]} />
      <shaderMaterial
        ref={matRef}
        transparent
        depthWrite={false}
        uniforms={{
          uTime: { value: 0 },
          uCursor: { value: new THREE.Vector2(0.5, 0.5) },
          uExcite: { value: 0 },
          uCuriosity: { value: 0 },
        }}
        vertexShader={`
          varying vec2 vUv;
          void main() {
            vUv = uv;
            gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
          }
        `}
        fragmentShader={`
          precision highp float;
          varying vec2 vUv;
          uniform float uTime;
          uniform vec2  uCursor;
          uniform float uExcite;
          uniform float uCuriosity;

          // Hash / noise helpers — cheap 2D value noise.
          float hash(vec2 p) { return fract(sin(dot(p, vec2(41.3, 289.1))) * 45758.5453); }
          float noise(vec2 p) {
            vec2 i = floor(p); vec2 f = fract(p);
            vec2 u = f*f*(3.0-2.0*f);
            return mix(mix(hash(i+vec2(0.0,0.0)), hash(i+vec2(1.0,0.0)), u.x),
                       mix(hash(i+vec2(0.0,1.0)), hash(i+vec2(1.0,1.0)), u.x), u.y);
          }
          float fbm(vec2 p) {
            float v = 0.0; float a = 0.5;
            for (int i = 0; i < 5; i++) {
              v += a * noise(p);
              p *= 2.02;
              a *= 0.5;
            }
            return v;
          }

          void main() {
            vec2 uv = vUv - 0.5;
            uv.x *= 1.6;

            float drift = uTime * 0.03;
            vec2 q = uv * 1.4 + vec2(drift, -drift * 0.7);
            float n = fbm(q + fbm(q + uTime * 0.05));

            float dist = distance(vUv, uCursor);
            float lens = exp(-dist * dist * 16.0) * (0.35 + uExcite * 0.5);

            vec3 violet = vec3(0.486, 0.227, 0.929);
            vec3 cyan   = vec3(0.133, 0.827, 0.933);
            vec3 deep   = vec3(0.027, 0.004, 0.039);

            vec3 col = mix(deep, violet, smoothstep(0.2, 0.85, n));
            col = mix(col, cyan, smoothstep(0.55, 0.95, n) * (0.3 + uCuriosity * 0.5));
            col += lens * mix(violet, cyan, 0.4);

            float alpha = smoothstep(0.1, 0.9, n) * 0.55;
            gl_FragColor = vec4(col, alpha);
          }
        `}
      />
    </mesh>
  );
}

function ParticleLayer({
  count,
  depth,
  size,
  color,
  speed,
}: {
  count: number;
  depth: number;
  size: number;
  color: string;
  speed: number;
}) {
  const pointsRef = useRef<THREE.Points>(null);
  const geomRef = useRef<THREE.BufferGeometry>(null);
  const universe = useMemo(() => new Universe({ count }), [count]);
  const positions = useMemo(() => new Float32Array(count * 3), [count]);
  const { viewport } = useThree();

  // Seed once the viewport is known.
  useEffect(() => {
    universe.resize(viewport.width, viewport.height);
  }, [universe, viewport.width, viewport.height]);

  useFrame((_, dt) => {
    const { cursor, emotion } = useInteraction.getState();
    universe.setCursor(cursor.x, 1 - cursor.y);
    universe.setEmotion(emotion);
    universe.step(dt * 1000 * speed);

    for (let i = 0; i < count; i++) {
      const p = universe.particles[i];
      const x = (p.x - 0.5) * viewport.width;
      const y = (p.y - 0.5) * viewport.height;
      positions[i * 3 + 0] = x;
      positions[i * 3 + 1] = y;
      positions[i * 3 + 2] = depth;
    }
    if (geomRef.current) {
      geomRef.current.attributes.position.needsUpdate = true;
    }
  });

  return (
    <points ref={pointsRef}>
      <bufferGeometry ref={geomRef}>
        <bufferAttribute
          attach="attributes-position"
          args={[positions, 3]}
          count={count}
        />
      </bufferGeometry>
      <pointsMaterial
        color={color}
        size={size}
        sizeAttenuation
        transparent
        opacity={0.85}
        depthWrite={false}
        blending={THREE.AdditiveBlending}
      />
    </points>
  );
}

function ReadyFlag() {
  const setReady = useInteraction((s) => s.setUniverseReady);
  useEffect(() => {
    setReady(true);
    return () => setReady(false);
  }, [setReady]);
  return null;
}

export default function EntryField() {
  const tier = usePerformanceTier();
  const cfg = TIER_CONFIG[tier];
  return (
    <div
      aria-hidden
      className="pointer-events-none fixed inset-0 z-0"
      style={{ background: "radial-gradient(ellipse at top, #0b0618 0%, #05010a 60%, #000 100%)" }}
    >
      <Canvas
        dpr={cfg.dpr}
        camera={{ position: [0, 0, 6], fov: 60 }}
        gl={{ antialias: tier !== "low", alpha: true, powerPreference: "high-performance" }}
        onCreated={({ scene }) => {
          scene.background = null;
          scene.fog = new THREE.Fog(BG_COLOR, 5, 18);
        }}
      >
        <ReadyFlag />
        {cfg.nebula && <Nebula />}
        <ParticleLayer count={cfg.bg} depth={-2.5} size={0.06} color="#a78bfa" speed={0.6} />
        <ParticleLayer count={cfg.mid} depth={-1} size={0.04} color="#67e8f9" speed={1} />
        <ParticleLayer count={cfg.fg} depth={0.5} size={0.09} color="#f5f3ff" speed={1.4} />
      </Canvas>
    </div>
  );
}
