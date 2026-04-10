// Runtime flags used for testing and special runtime modes.
// Tests can set these flags to alter app behavior (e.g., disable animations).

/// When this flag is true, widgets should avoid starting repeating or long-running
/// animations. Tests set this to `true` to make widget tests deterministic and
/// avoid pumpAndSettle timeouts caused by infinite animations.
bool disableAnimations = false;

/// When running widget tests we sometimes need to avoid interacting with
/// platform services (Supabase, Hive, platform notifications etc). Tests set
/// `isRunningTests = true` inside helpers to enable guarded behavior.
bool isRunningTests = false;
