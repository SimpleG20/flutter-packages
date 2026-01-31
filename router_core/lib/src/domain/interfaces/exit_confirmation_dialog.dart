import 'package:flutter/widgets.dart';

import '../entities/exit_guard_config.dart';

/// Interface for displaying exit confirmation dialogs.
///
/// Implement this to provide a custom dialog appearance.
/// The default implementation uses Material Design AlertDialog.
abstract interface class IExitConfirmationDialog {
  /// Shows the exit confirmation dialog and returns the user's decision.
  ///
  /// Returns `true` if the user confirms they want to leave (navigate away).
  /// Returns `false` if the user cancels (stay on current page).
  Future<bool> show(BuildContext context, ExitGuardConfig config);
}
