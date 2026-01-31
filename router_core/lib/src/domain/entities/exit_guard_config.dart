import 'package:freezed_annotation/freezed_annotation.dart';

part 'exit_guard_config.freezed.dart';

/// Configuration for the exit confirmation dialog.
///
/// Use this to customize the appearance and text of the confirmation popup
/// that appears when a user tries to leave a guarded route with unsaved changes.
@freezed
abstract class ExitGuardConfig with _$ExitGuardConfig {
  const factory ExitGuardConfig({
    /// The title displayed at the top of the dialog.
    @Default('Unsaved Changes') String title,

    /// The message body explaining why confirmation is needed.
    @Default('You have unsaved changes. Are you sure you want to leave?')
    String message,

    /// Label for the "leave" / confirm button.
    @Default('Leave') String confirmLabel,

    /// Label for the "stay" / cancel button.
    @Default('Stay') String cancelLabel,

    /// Whether tapping outside the dialog dismisses it (counts as cancel).
    @Default(false) bool barrierDismissible,
  }) = _ExitGuardConfig;

  /// Default configuration with standard messages.
  static const ExitGuardConfig defaultConfig = ExitGuardConfig();
}
