/**
 * LazyScene — dynamic-imported wrapper around UniverseScene.
 *
 * Three.js + R3F is the biggest contributor to first-load JS. Splitting
 * it into a client-only chunk lets the initial HTML paint before the
 * WebGL layer is even downloaded. While the chunk is loading we render
 * a pure-CSS fallback (gradient + blurred nebula) so the hero never
 * flashes empty.
 *
 * `ssr: false` is required — Three.js touches `window` at module load.
 */

"use client";

import dynamic from "next/dynamic";

const UniverseSceneDynamic = dynamic(
  () => import("./scene").then((m) => m.UniverseScene),
  {
    ssr: false,
    loading: () => <SceneFallback />,
  }
);

export function LazyScene() {
  return <UniverseSceneDynamic />;
}

function SceneFallback() {
  // Pure-CSS stand-in: radial gradient + slow drifting nebula. Cheap, no
  // JS, and visually aligned with the final scene so there's no jolt
  // when the WebGL chunk hydrates.
  return (
    <div aria-hidden className="absolute inset-0 overflow-hidden">
      <div
        className="absolute inset-0 animate-pro-drift"
        style={{
          background:
            "radial-gradient(ellipse at 30% 20%, rgba(124,58,237,0.28), transparent 60%), radial-gradient(ellipse at 70% 80%, rgba(34,211,238,0.22), transparent 60%)",
          filter: "blur(60px)",
        }}
      />
      <div
        className="absolute inset-0 opacity-[0.35]"
        style={{
          backgroundImage:
            "radial-gradient(1px 1px at 20% 30%, #fff, transparent), radial-gradient(1px 1px at 70% 50%, #fff, transparent), radial-gradient(1px 1px at 40% 80%, #fff, transparent), radial-gradient(1px 1px at 85% 20%, #fff, transparent), radial-gradient(1px 1px at 15% 60%, #fff, transparent)",
          backgroundSize: "300px 300px",
        }}
      />
    </div>
  );
}
