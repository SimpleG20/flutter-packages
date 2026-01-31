import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers/exit_guard_providers.dart';
import '../../domain/entities/exit_guard_config.dart';

/// Mixin that automatically registers exit guard protection for a page.
///
/// Use this mixin on [ConsumerStatefulWidget] pages that need exit confirmation.
/// Override [isDirty] to return whether there are unsaved changes.
/// Optionally override [exitGuardConfig] to customize the dialog.
///
/// Usage:
/// ```dart
/// class _EditPageState extends ConsumerState<EditPage>
///     with ExitGuardMixin<EditPage> {
///   bool _hasChanges = false;
///
///   @override
///   bool get isDirty => _hasChanges;
///
///   @override
///   ExitGuardConfig? get exitGuardConfig => const ExitGuardConfig(
///     title: 'Discard Changes?',
///     message: 'Your edits will be lost.',
///   );
///
///   @override
///   Widget build(BuildContext context) {
///     return ExitGuardShell(
///       child: Scaffold(/* ... */),
///     );
///   }
/// }
/// ```
mixin ExitGuardMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  String? _registeredPath;

  /// Whether the page has unsaved changes.
  ///
  /// Override this getter to return your dirty state.
  /// When this returns true, navigation will trigger the confirmation dialog.
  bool get isDirty;

  /// Optional custom configuration for the exit confirmation dialog.
  ///
  /// Override to customize title, message, button labels, etc.
  /// Returns null to use default configuration.
  ExitGuardConfig? get exitGuardConfig => null;

  @override
  void initState() {
    super.initState();
    // Schedule registration after the first frame to ensure context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _registerExitGuard();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update dirty state whenever dependencies change
    _updateDirtyState();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update dirty state when widget updates
    _updateDirtyState();
  }

  @override
  void dispose() {
    _unregisterExitGuard();
    super.dispose();
  }

  /// Manually update the dirty state.
  ///
  /// Call this when your form state changes to keep the guard in sync.
  void updateExitGuard() {
    _updateDirtyState();
  }

  void _registerExitGuard() {
    if (!mounted) return;

    // Get the current route path from GoRouter
    final routerState = GoRouterState.of(context);
    _registeredPath = routerState.uri.path;

    final controller = ref.read(exitGuardControllerProvider);
    controller.registerRoute(_registeredPath!, config: exitGuardConfig);

    // Set initial dirty state
    _updateDirtyState();
  }

  void _unregisterExitGuard() {
    if (_registeredPath != null) {
      // Use read since we're in dispose and can't watch
      ref.read(exitGuardControllerProvider).unregisterRoute(_registeredPath!);
      _registeredPath = null;
    }
  }

  void _updateDirtyState() {
    if (_registeredPath != null && mounted) {
      ref.read(exitGuardControllerProvider).setDirty(_registeredPath!, isDirty);
    }
  }
}
