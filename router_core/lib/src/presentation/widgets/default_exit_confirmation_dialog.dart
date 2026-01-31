import 'package:flutter/material.dart';

import '../../domain/entities/exit_guard_config.dart';
import '../../domain/interfaces/exit_confirmation_dialog.dart';

/// Default Material Design implementation of exit confirmation dialog.
///
/// Displays an AlertDialog with the configured title, message, and buttons.
/// Returns true when user confirms leaving, false when canceled.
class DefaultExitConfirmationDialog implements IExitConfirmationDialog {
  const DefaultExitConfirmationDialog();

  @override
  Future<bool> show(BuildContext context, ExitGuardConfig config) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: config.barrierDismissible,
      builder: (context) => AlertDialog(
        title: Text(config.title),
        content: Text(config.message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(config.cancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(config.confirmLabel),
          ),
        ],
      ),
    );

    // Barrier dismiss or back button returns null, treat as cancel
    return result ?? false;
  }
}
