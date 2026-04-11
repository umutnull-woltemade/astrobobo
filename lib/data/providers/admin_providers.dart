import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/admin_auth_service.dart';
import '../services/admin_analytics_service.dart';

// ═══════════════════════════════════════════════════════════════════
// Auth Provider
// ═══════════════════════════════════════════════════════════════════

final adminAuthProvider = StateProvider<bool>((ref) {
  return AdminAuthService.isAuthenticated;
});

// ═══════════════════════════════════════════════════════════════════
// Metrics Provider - KPIs & Analytics Data
// ═══════════════════════════════════════════════════════════════════

final adminMetricsProvider = StateProvider<AdminMetrics>((ref) {
  // In production, this would fetch from backend/Firebase
  // For now, return sample data
  return AdminMetrics(
    d1Return: 42.5,
    d1Change: 3.2,
    d7Return: 28.3,
    d7Change: -1.5,
    avgSessionDepth: 4.7,
    sessionChange: 0.8,
    recoCtr: 15.2,
    ctrChange: 2.1,
    shareReturn: 8.4,
    toolUsage: {
      'Rüya İzi': 35.0,
      'Kozmik': 28.0,
      'Tarot': 18.0,
      'Numeroloji': 12.0,
      'Tantra': 7.0,
    },
    retentionHistory: [
      RetentionPoint(
        date: DateTime.now().subtract(const Duration(days: 6)),
        d1: 38.0,
        d7: 24.0,
      ),
      RetentionPoint(
        date: DateTime.now().subtract(const Duration(days: 5)),
        d1: 40.2,
        d7: 25.5,
      ),
      RetentionPoint(
        date: DateTime.now().subtract(const Duration(days: 4)),
        d1: 39.8,
        d7: 26.2,
      ),
      RetentionPoint(
        date: DateTime.now().subtract(const Duration(days: 3)),
        d1: 41.5,
        d7: 27.0,
      ),
      RetentionPoint(
        date: DateTime.now().subtract(const Duration(days: 2)),
        d1: 43.0,
        d7: 27.8,
      ),
      RetentionPoint(
        date: DateTime.now().subtract(const Duration(days: 1)),
        d1: 42.0,
        d7: 28.0,
      ),
      RetentionPoint(date: DateTime.now(), d1: 42.5, d7: 28.3),
    ],
  );
});

class AdminMetrics {
  final double d1Return;
  final double d1Change;
  final double d7Return;
  final double d7Change;
  final double avgSessionDepth;
  final double sessionChange;
  final double recoCtr;
  final double ctrChange;
  final double shareReturn;
  final Map<String, double> toolUsage;
  final List<RetentionPoint> retentionHistory;

  AdminMetrics({
    required this.d1Return,
    required this.d1Change,
    required this.d7Return,
    required this.d7Change,
    required this.avgSessionDepth,
    required this.sessionChange,
    required this.recoCtr,
    required this.ctrChange,
    required this.shareReturn,
    required this.toolUsage,
    required this.retentionHistory,
  });
}

class RetentionPoint {
  final DateTime date;
  final double d1;
  final double d7;

  RetentionPoint({required this.date, required this.d1, required this.d7});
}

// ═══════════════════════════════════════════════════════════════════
// Growth Tasks Provider
// ═══════════════════════════════════════════════════════════════════

class GrowthTasksNotifier extends StateNotifier<List<GrowthTask>> {
  GrowthTasksNotifier() : super(_initialTasks);

  static final _initialTasks = [
    GrowthTask(
      id: '1',
      title: 'Implement share-to-return tracking',
      category: 'Analytics',
      priority: 'high',
      isCompleted: false,
    ),
    GrowthTask(
      id: '2',
      title: 'Add push notification for D1 users',
      category: 'Retention',
      priority: 'high',
      isCompleted: false,
    ),
    GrowthTask(
      id: '3',
      title: 'Optimize recommendation algorithm',
      category: 'Growth',
      priority: 'medium',
      isCompleted: true,
    ),
    GrowthTask(
      id: '4',
      title: 'Add social proof widgets',
      category: 'Conversion',
      priority: 'medium',
      isCompleted: false,
    ),
    GrowthTask(
      id: '5',
      title: 'Implement A/B test for onboarding',
      category: 'Experimentation',
      priority: 'low',
      isCompleted: false,
    ),
  ];

  void toggleTask(String id) {
    state = state.map((task) {
      if (task.id == id) {
        return task.copyWith(isCompleted: !task.isCompleted);
      }
      return task;
    }).toList();
  }

  void addTask(GrowthTask task) {
    state = [...state, task];
  }

  void removeTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }
}

final growthTasksProvider =
    StateNotifierProvider<GrowthTasksNotifier, List<GrowthTask>>((ref) {
      return GrowthTasksNotifier();
    });

class GrowthTask {
  final String id;
  final String title;
  final String category;
  final String priority;
  final bool isCompleted;

  GrowthTask({
    required this.id,
    required this.title,
    required this.category,
    required this.priority,
    required this.isCompleted,
  });

  GrowthTask copyWith({
    String? id,
    String? title,
    String? category,
    String? priority,
    bool? isCompleted,
  }) {
    return GrowthTask(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// Event Log Provider
// ═══════════════════════════════════════════════════════════════════

final eventLogProvider = StateProvider<List<EventLogEntry>>((ref) {
  // Try to load from real analytics first
  final realEvents = AdminAnalyticsService.getAllEvents();

  if (realEvents.isNotEmpty) {
    return realEvents
        .map(
          (e) => EventLogEntry(
            name: e.name,
            count: e.count,
            lastFired: e.lastFired,
          ),
        )
        .toList();
  }

  // Fallback to sample data if no real events yet
  return [
    EventLogEntry(
      name: 'page_view',
      count: 1247,
      lastFired: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    EventLogEntry(
      name: 'recommendation_view',
      count: 845,
      lastFired: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    EventLogEntry(
      name: 'recommendation_click',
      count: 312,
      lastFired: DateTime.now().subtract(const Duration(minutes: 8)),
    ),
    EventLogEntry(
      name: 'ritual_click',
      count: 156,
      lastFired: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    EventLogEntry(
      name: 'share_view',
      count: 423,
      lastFired: DateTime.now().subtract(const Duration(minutes: 12)),
    ),
    EventLogEntry(
      name: 'share_return',
      count: 89,
      lastFired: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    EventLogEntry(
      name: 'admin_login_success',
      count: 24,
      lastFired: DateTime.now(),
    ),
    EventLogEntry(
      name: 'admin_login_fail',
      count: 3,
      lastFired: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    EventLogEntry(
      name: 'dream_interpreted',
      count: 567,
      lastFired: DateTime.now().subtract(const Duration(minutes: 3)),
    ),
    EventLogEntry(
      name: 'tarot_spread',
      count: 234,
      lastFired: DateTime.now().subtract(const Duration(minutes: 7)),
    ),
  ];
});

class EventLogEntry {
  final String name;
  final int count;
  final DateTime lastFired;

  EventLogEntry({
    required this.name,
    required this.count,
    required this.lastFired,
  });
}

// ═══════════════════════════════════════════════════════════════════
// Snapshots Provider
// ═══════════════════════════════════════════════════════════════════

class SnapshotsNotifier extends StateNotifier<List<AdminSnapshot>> {
  SnapshotsNotifier() : super(_initialSnapshots);

  static final _initialSnapshots = [
    AdminSnapshot(
      id: '1',
      title: 'Weekly Growth Review',
      content: '''
- D1 Return: 42.5% (+3.2%)
- D7 Return: 28.3% (-1.5%)
- Top tool: Rüya Izi (35%)
- Focus: Improve D7 retention
- Next: Push notification test
''',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    AdminSnapshot(
      id: '2',
      title: 'Feature Launch Snapshot',
      content: '''
- Tantra feature launched
- Initial CTR: 7%
- User feedback: Positive
- Bugs: 2 minor UI issues
- Next: Iterate based on feedback
''',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  void addSnapshot(AdminSnapshot snapshot) {
    state = [snapshot, ...state];
  }

  void removeSnapshot(String id) {
    state = state.where((s) => s.id != id).toList();
  }
}

final snapshotsProvider =
    StateNotifierProvider<SnapshotsNotifier, List<AdminSnapshot>>((ref) {
      return SnapshotsNotifier();
    });

class AdminSnapshot {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;

  AdminSnapshot({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });
}
