/// A decoupled navigation package for Flutter with exit confirmation.
///
/// This package provides:
/// - **Typed Routes**: Type-safe route definitions with compile-time verification
/// - **Route Builder**: Fluent API for GoRouter integration
/// - **Exit Guard System**: Protecting pages with unsaved changes
/// - **PopScope Integration**: Back button/gesture interception
/// - **Riverpod State Management**: Centralized state with override support
/// - **Customizable Dialog**: Default Material dialog with full customization
library router_core;

// Domain - Entities (Typed Routes)
export 'src/domain/entities/route_params.dart';
export 'src/domain/entities/typed_route.dart';

// Domain - Entities (Guards)
export 'src/domain/entities/guard_context.dart';
export 'src/domain/entities/guard_result.dart';
export 'src/domain/entities/route_guard.dart';

// Domain - Entities (Exit Guard)
export 'src/domain/entities/exit_guard_config.dart';
export 'src/domain/entities/exit_guard_state.dart';

// Domain - Interfaces
export 'src/domain/interfaces/exit_guard_controller.dart';
export 'src/domain/interfaces/exit_confirmation_dialog.dart';

// Application - Services
export 'src/application/services/guard_service.dart';

// Application - Observers
export 'src/application/observers/navigation_observer.dart';

// Application - Providers
export 'src/application/providers/exit_guard_providers.dart';
export 'src/application/providers/guard_providers.dart';
export 'src/application/providers/navigation_providers.dart';
export 'src/application/notifiers/exit_guard_notifier.dart';

// Application - Builders (Typed Routes)
export 'src/application/builders/route_builder.dart';

// Application - Services
export 'src/application/services/navigation_service_impl.dart';

// Domain - Interfaces
export 'src/domain/interfaces/navigation_service.dart';

// Presentation - Widgets
export 'src/presentation/widgets/exit_guard_shell.dart';
export 'src/presentation/widgets/default_exit_confirmation_dialog.dart';

// Presentation - Extensions
export 'src/presentation/extensions/navigation_extensions.dart';

// Presentation - Mixins
export 'src/presentation/mixins/exit_guard_mixin.dart';
