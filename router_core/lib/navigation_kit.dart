/// A decoupled navigation package for Flutter with exit confirmation.
///
/// This package provides:
/// - Exit guard system for protecting pages with unsaved changes
/// - Integration with Flutter's PopScope for back button/gesture interception
/// - Riverpod providers for state management
/// - Customizable confirmation dialog
library navigation_kit;

// Domain - Entities
export 'src/domain/entities/exit_guard_config.dart';
export 'src/domain/entities/exit_guard_state.dart';

// Domain - Interfaces
export 'src/domain/interfaces/exit_guard_controller.dart';
export 'src/domain/interfaces/exit_confirmation_dialog.dart';

// Application - Providers
export 'src/application/providers/exit_guard_providers.dart';
export 'src/application/notifiers/exit_guard_notifier.dart';

// Presentation - Widgets
export 'src/presentation/widgets/exit_guard_shell.dart';
export 'src/presentation/widgets/default_exit_confirmation_dialog.dart';

// Presentation - Mixins
export 'src/presentation/mixins/exit_guard_mixin.dart';
