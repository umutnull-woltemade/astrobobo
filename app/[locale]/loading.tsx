export default function Loading() {
  return (
    <div className="min-h-[60vh] flex flex-col items-center justify-center">
      <div className="relative">
        <div className="w-16 h-16 rounded-full border-4 border-cosmic-border border-t-cosmic-accent animate-spin" />
      </div>
      <p className="mt-6 text-cosmic-muted text-sm animate-pulse">
        Aligning the stars&hellip;
      </p>
    </div>
  );
}
