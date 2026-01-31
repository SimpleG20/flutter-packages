import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/exit_guard_providers.dart';

/// Shell widget that wraps route content and handles exit guard logic.
///
/// This widget uses Flutter's [PopScope] to intercept back button presses
/// and swipe gestures (iOS/Android). When the exit guard is active and dirty,
/// it shows the confirmation dialog before allowing navigation.
///
/// Usage:
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   return ExitGuardShell(
///     child: Scaffold(
///       // your content
///     ),
///   );
/// }
/// ```
class ExitGuardShell extends ConsumerWidget {
  /// The child widget to wrap with exit guard protection.
  final Widget child;

  const ExitGuardShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(exitGuardStateProvider);

    return PopScope(
      // Block pop when guard is active and dirty
      canPop: !state.shouldBlock,
      onPopInvokedWithResult: (didPop, result) async {
        // If already popped, nothing to do
        if (didPop) return;

        // Ask the controller if we should allow the pop
        final controller = ref.read(exitGuardControllerProvider);
        final shouldPop = await controller.shouldAllowPop(context);

        if (shouldPop && context.mounted) {
          // User confirmed, perform the navigation
          Navigator.of(context).pop(result);
        }
      },
      child: child,
    );
  }
}
