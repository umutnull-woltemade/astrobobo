"use client";

export default function Error({
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  return (
    <div className="min-h-[60vh] flex flex-col items-center justify-center px-4 text-center">
      <div className="text-6xl mb-6">&#x2726;</div>
      <h1 className="text-3xl font-display text-cosmic-accent mb-4">
        Something went wrong
      </h1>
      <p className="text-cosmic-muted max-w-md mb-8">
        The stars seem misaligned at the moment. Please try again.
      </p>
      <button
        onClick={reset}
        className="px-6 py-3 bg-cosmic-accent text-cosmic-bg font-semibold rounded-lg hover:bg-cosmic-accent-soft transition-colors"
      >
        Try again
      </button>
    </div>
  );
}
