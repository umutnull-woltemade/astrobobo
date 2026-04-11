/**
 * /universe scene — the three.js particle field.
 *
 * A single InstancedMesh holds every particle. Each RAF the universe-runtime
 * steps the simulation and we copy positions into a Matrix4 per instance.
 *
 * The scene is purely visual — it reads cursor + emotion from the Pro store
 * but never writes to it. All mutations live in hooks/useUserBehavior.
 */

"use client";

import { Canvas, useFrame, useThree } from "@react-three/fiber";
import { useEffect, useMemo, useRef } from "react";
import * as THREE from "three";
import { Universe } from "@/lib/pro/universe-runtime";
import { useProStore } from "@/lib/pro/pro-store";

/**
 * Starfield — a slow-drifting deep background of ~1400 tiny stars rendered
 * as a single Points mesh. Lives behind the interactive particle field so it
 * adds depth without competing for attention. Opacity breathes subtly with
 * engagement; everything else stays constant.
 */
const STAR_COUNT = 1400;

function Starfield() {
  const pointsRef = useRef<THREE.Points>(null);
  const { viewport } = useThree();

  const { positions, sizes, phases } = useMemo(() => {
    const positions = new Float32Array(STAR_COUNT * 3);
    const sizes = new Float32Array(STAR_COUNT);
    const phases = new Float32Array(STAR_COUNT);
    for (let i = 0; i < STAR_COUNT; i++) {
      positions[i * 3 + 0] = (Math.random() - 0.5) * 40;
      positions[i * 3 + 1] = (Math.random() - 0.5) * 28;
      positions[i * 3 + 2] = -6 - Math.random() * 8;
      sizes[i] = 0.6 + Math.random() * 1.8;
      phases[i] = Math.random() * Math.PI * 2;
    }
    return { positions, sizes, phases };
  }, []);

  const geometry = useMemo(() => {
    const g = new THREE.BufferGeometry();
    g.setAttribute("position", new THREE.BufferAttribute(positions, 3));
    g.setAttribute("aSize", new THREE.BufferAttribute(sizes, 1));
    g.setAttribute("aPhase", new THREE.BufferAttribute(phases, 1));
    return g;
  }, [positions, sizes, phases]);

  const material = useMemo(() => {
    return new THREE.ShaderMaterial({
      uniforms: {
        uTime: { value: 0 },
        uIntensity: { value: 0.6 },
        uPixelRatio: { value: typeof window !== "undefined" ? window.devicePixelRatio : 1 },
      },
      vertexShader: /* glsl */ `
        attribute float aSize;
        attribute float aPhase;
        uniform float uTime;
        uniform float uPixelRatio;
        varying float vFlicker;
        void main() {
          vec4 mv = modelViewMatrix * vec4(position, 1.0);
          float twinkle = 0.5 + 0.5 * sin(uTime * 0.7 + aPhase);
          vFlicker = twinkle;
          gl_Position = projectionMatrix * mv;
          gl_PointSize = aSize * uPixelRatio * (1.0 + twinkle * 0.5);
        }
      `,
      fragmentShader: /* glsl */ `
        uniform float uIntensity;
        varying float vFlicker;
        void main() {
          vec2 uv = gl_PointCoord - 0.5;
          float d = length(uv);
          float a = smoothstep(0.5, 0.0, d) * (0.35 + 0.55 * vFlicker) * uIntensity;
          vec3 col = mix(vec3(0.78, 0.82, 1.0), vec3(0.95, 0.88, 1.0), vFlicker);
          gl_FragColor = vec4(col, a);
        }
      `,
      transparent: true,
      depthWrite: false,
      blending: THREE.AdditiveBlending,
    });
  }, []);

  useEffect(() => {
    return () => {
      geometry.dispose();
      material.dispose();
    };
  }, [geometry, material]);

  useFrame((_, dt) => {
    const pts = pointsRef.current;
    if (!pts) return;
    material.uniforms.uTime.value += dt;

    const { emotion } = useProStore.getState();
    const target = 0.45 + emotion.engagement * 0.35 - emotion.confusion * 0.2;
    const prev = material.uniforms.uIntensity.value as number;
    material.uniforms.uIntensity.value = prev + (target - prev) * Math.min(1, dt * 2);

    // Gentle rotation so the field feels alive even when idle.
    pts.rotation.z += dt * 0.01;
  });

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  const _touchViewport = viewport.width;

  return (
    <points
      ref={pointsRef}
      geometry={geometry}
      material={material}
      frustumCulled={false}
    />
  );
}

function ParticleField() {
  const universeRef = useRef<Universe>(null);
  const meshRef = useRef<THREE.InstancedMesh>(null);
  const tmpMatrix = useMemo(() => new THREE.Matrix4(), []);
  const tmpColor = useMemo(() => new THREE.Color(), []);
  const { viewport, size } = useThree();

  if (!universeRef.current) {
    universeRef.current = new Universe({ count: 260 });
  }

  useEffect(() => {
    universeRef.current?.resize(size.width, size.height);
  }, [size.width, size.height]);

  useFrame((_, dt) => {
    const universe = universeRef.current;
    const mesh = meshRef.current;
    if (!universe || !mesh) return;

    const { cursor, emotion } = useProStore.getState();
    universe.setCursor(cursor.x, cursor.y);
    universe.setEmotion(emotion);
    universe.step(dt * 1000);

    const w = viewport.width;
    const h = viewport.height;

    for (let i = 0; i < universe.particles.length; i++) {
      const p = universe.particles[i];
      const x = (p.x - 0.5) * w;
      const y = -(p.y - 0.5) * h;
      const z = Math.sin(p.life * Math.PI * 2 + p.seed) * 0.5;
      const scale =
        0.02 + (0.025 + emotion.excitement * 0.04) * (0.6 + Math.sin(p.life * 6.28) * 0.4);
      tmpMatrix.makeTranslation(x, y, z);
      tmpMatrix.scale(new THREE.Vector3(scale, scale, scale));
      mesh.setMatrixAt(i, tmpMatrix);

      const hue =
        0.72 - emotion.curiosity * 0.12 + emotion.excitement * 0.18 - emotion.confusion * 0.1;
      tmpColor.setHSL((hue + p.seed * 0.0003) % 1, 0.75, 0.6 + emotion.engagement * 0.15);
      mesh.setColorAt(i, tmpColor);
    }
    mesh.instanceMatrix.needsUpdate = true;
    if (mesh.instanceColor) mesh.instanceColor.needsUpdate = true;
  });

  return (
    <instancedMesh
      ref={meshRef}
      args={[undefined, undefined, 260]}
      frustumCulled={false}
    >
      <sphereGeometry args={[1, 10, 10]} />
      <meshBasicMaterial
        transparent
        opacity={0.85}
        blending={THREE.AdditiveBlending}
        toneMapped={false}
      />
    </instancedMesh>
  );
}

export function UniverseScene() {
  return (
    <Canvas
      orthographic
      camera={{ zoom: 55, position: [0, 0, 10] }}
      gl={{ antialias: true, alpha: true }}
      className="pointer-events-none"
    >
      <Starfield />
      <ParticleField />
    </Canvas>
  );
}
