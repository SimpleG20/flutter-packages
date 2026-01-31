import 'package:flutter/widgets.dart';

/// Navigation observer for logging and analytics.
///
/// Use this observer to track screen views and navigation events.
class AppNavigationObserver extends NavigatorObserver {
  /// Callback triggered when a route is pushed.
  final void Function(Route<dynamic> route, Route<dynamic>? previousRoute)?
  onPush;

  /// Callback triggered when a route is popped.
  final void Function(Route<dynamic> route, Route<dynamic>? previousRoute)?
  onPop;

  /// Callback triggered when a route is replaced.
  final void Function(Route<dynamic> newRoute, Route<dynamic>? oldRoute)?
  onReplace;

  /// Callback triggered when a route is removed.
  final void Function(Route<dynamic> route, Route<dynamic>? previousRoute)?
  onRemove;

  /// Optional analytics tracker.
  ///
  /// Function dealing with `screenName` and `parameters`.
  final void Function(String screenName, Map<String, dynamic>? params)?
  onAnalytics;

  AppNavigationObserver({
    this.onPush,
    this.onPop,
    this.onReplace,
    this.onRemove,
    this.onAnalytics,
  });

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onPush?.call(route, previousRoute);
    _logAnalytics(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onPop?.call(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      onReplace?.call(newRoute, oldRoute);
      _logAnalytics(newRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onRemove?.call(route, previousRoute);
  }

  void _logAnalytics(Route<dynamic> route) {
    if (onAnalytics == null) return;

    final name = route.settings.name;
    if (name != null) {
      final args = route.settings.arguments is Map<String, dynamic>
          ? route.settings.arguments as Map<String, dynamic>
          : null;
      onAnalytics!(name, args);
    }
  }
}
