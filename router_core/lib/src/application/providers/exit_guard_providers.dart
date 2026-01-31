import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/exit_guard_state.dart';
import '../../domain/interfaces/exit_confirmation_dialog.dart';
import '../../domain/interfaces/exit_guard_controller.dart';
import '../../domain/entities/exit_guard_config.dart';
import '../../presentation/widgets/default_exit_confirmation_dialog.dart';
import '../notifiers/exit_guard_notifier.dart';

/// Provider for the exit guard state notifier.
///
/// Use `ref.watch(exitGuardStateProvider)` to observe state changes.
/// Use `ref.read(exitGuardStateProvider.notifier)` to access the notifier.
final exitGuardStateProvider =
    StateNotifierProvider<ExitGuardNotifier, ExitGuardState>(
      (ref) => ExitGuardNotifier(),
    );

/// Provider for the exit confirmation dialog implementation.
///
/// Override this provider to customize the dialog appearance:
/// ```dart
/// final container = ProviderContainer(
///   overrides: [
///     exitConfirmationDialogProvider.overrideWithValue(MyCustomDialog()),
///   ],
/// );
/// ```
final exitConfirmationDialogProvider = Provider<IExitConfirmationDialog>(
  (ref) => const DefaultExitConfirmationDialog(),
);

/// Provider for the exit guard controller.
///
/// This controller coordinates between pages and the navigation system.
final exitGuardControllerProvider = Provider<IExitGuardController>(
  (ref) => _ExitGuardControllerImpl(ref),
);

/// Internal implementation of [IExitGuardController].
class _ExitGuardControllerImpl implements IExitGuardController {
  final Ref _ref;

  _ExitGuardControllerImpl(this._ref);

  @override
  void registerRoute(String path, {ExitGuardConfig? config}) {
    _ref
        .read(exitGuardStateProvider.notifier)
        .registerRoute(path, config: config);
  }

  @override
  void unregisterRoute(String path) {
    _ref.read(exitGuardStateProvider.notifier).unregisterRoute(path);
  }

  @override
  void setDirty(String path, bool isDirty) {
    final notifier = _ref.read(exitGuardStateProvider.notifier);
    if (notifier.isRouteRegistered(path)) {
      notifier.setDirty(isDirty);
    }
  }

  @override
  Future<bool> shouldAllowPop(BuildContext context) async {
    final state = _ref.read(exitGuardStateProvider);

    // Allow navigation if guard is not active or not dirty
    if (!state.shouldBlock) {
      return true;
    }

    // Show confirmation dialog
    final dialog = _ref.read(exitConfirmationDialogProvider);
    final confirmed = await dialog.show(context, state.effectiveConfig);

    // If user confirmed, clear the guard state
    if (confirmed) {
      _ref.read(exitGuardStateProvider.notifier).clearDirty();
    }

    return confirmed;
  }
}
