# Router Core

A decoupled navigation package for Flutter with type-safe routing and exit confirmation support.

## Features

- **Typed Routes**: Type-safe route definitions with compile-time verification
- **Route Builder**: Fluent API for GoRouter integration
- **Exit Guard System**: Protect pages with unsaved changes
- **PopScope Integration**: Intercepts back button, swipe gestures (iOS/Android)
- **Riverpod State Management**: Centralized state with override support
- **Customizable Dialog**: Default Material dialog with full customization

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  router_core:
    git:
      url: https://github.com/your-org/flutter-packages.git
      path: router_core
      ref: main
```

Run code generation:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

## Quick Start

### 1. Define Typed Routes

```dart
import 'package:router_core/router_core.dart';

// Define route parameters
class UserParams extends RouteParams {
  final String userId;
  final String? tab;

  const UserParams({required this.userId, this.tab});

  @override
  Map<String, String> toPathParams() => {'userId': userId};

  @override
  Map<String, dynamic> toQueryParams() => tab != null ? {'tab': tab} : {};
}

// Define typed routes
class HomeRoute extends AppRoute<NoParams> {
  const HomeRoute();
  
  @override String get name => 'home';
  @override String get path => '/';
  @override String buildPath([NoParams? params]) => path;
}

class UserRoute extends AppRoute<UserParams> {
  const UserRoute();
  
  @override String get name => 'user';
  @override String get path => '/user/:userId';
  
  @override
  String buildPath([UserParams? params]) {
    if (params == null) return path;
    return '/user/${params.userId}';
  }

  @override
  UserParams? extractParams(Map<String, String> pathParams) {
    final userId = pathParams['userId'];
    if (userId == null) return null;
    return UserParams(userId: userId);
  }
}

// Route registry
abstract class AppRoutes with RouteRegistry {
  static const home = HomeRoute();
  static const user = UserRoute();
}
```

### 2. Configure GoRouter

```dart
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home.path,
    routes: [
      AppRoutes.home.toGoRoute(
        builder: (ctx, state, params) => const HomePage(),
      ),
      AppRoutes.user.toGoRoute(
        builder: (ctx, state, params) => UserPage(userId: params!.userId),
      ),
    ],
  );
});
```

### 3. Navigate with Type Safety

```dart
// Using GoRouter extension
context.go(AppRoutes.user.buildPath(UserParams(userId: '123')));

// Or with named routes
context.goNamed(
  AppRoutes.user.name,
  pathParameters: {'userId': '123'},
);
```

### 4. Exit Guard (Optional)

```dart
class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage>
    with ExitGuardMixin<EditProfilePage> {
  bool _hasChanges = false;

  @override
  bool get isDirty => _hasChanges;

  @override
  ExitGuardConfig? get exitGuardConfig => const ExitGuardConfig(
    title: 'Unsaved Changes',
    message: 'You have unsaved changes. Are you sure you want to leave?',
  );

  @override
  Widget build(BuildContext context) {
    return ExitGuardShell(
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Profile')),
        body: TextField(
          onChanged: (value) {
            setState(() => _hasChanges = value.isNotEmpty);
            updateExitGuard();
          },
        ),
      ),
    );
  }
}
```

### 5. Route Guards

Protect routes using centralized guards (e.g. Authentication).

1. **Create a Guard**:
```dart
class AuthGuard extends RouteGuard {
  final Ref ref;
  const AuthGuard(this.ref);

  @override
  String get name => 'auth';

  @override
  FutureOr<GuardResult> check(GuardContext context) {
    // Example: Check if user is authenticated
    final isLoggedIn = ref.read(authProvider).isLoggedIn;
    
    if (!isLoggedIn && context.location != '/login') {
      return const GuardResult.redirect('/login');
    }
    return const GuardResult.allowed();
  }
}
```

2. **Register & Connect**:
```dart
// Register the guard
final guardService = ref.read(guardServiceProvider);
guardService.register(AuthGuard(ref));

// Connect to GoRouter
final router = GoRouter(
  redirect: ref.read(guardRedirectProvider),
  routes: [/*...*/],
);
```


## Architecture

```
router_core/
├── lib/
│   ├── router_core.dart              # Barrel file
│   └── src/
│       ├── domain/                   # Entities & Interfaces
│       │   ├── entities/
│       │   │   ├── route_params.dart        # RouteParams, NoParams
│       │   │   ├── typed_route.dart         # AppRoute, RouteRegistry, RouteMetadata
│       │   │   ├── exit_guard_config.dart
│       │   │   └── exit_guard_state.dart
│       │   └── interfaces/
│       │       ├── exit_guard_controller.dart
│       │       └── exit_confirmation_dialog.dart
│       ├── application/              # Riverpod & Builders
│       │   ├── builders/
│       │   │   └── route_builder.dart       # AppRouteConfig, AppRouteExtension
│       │   ├── services/
│       │   │   └── guard_service.dart
│       │   ├── providers/
│       │   │   ├── exit_guard_providers.dart
│       │   │   └── guard_providers.dart
│       │   └── notifiers/
│       │       └── exit_guard_notifier.dart
│       └── presentation/             # Widgets & Mixins
│           ├── widgets/
│           │   ├── exit_guard_shell.dart
│           │   └── default_exit_confirmation_dialog.dart
│           └── mixins/
│               └── exit_guard_mixin.dart
```

## API Reference

### Typed Routes

| Class | Description |
|-------|-------------|
| `RouteParams` | Base class for route parameters |
| `NoParams` | For routes without parameters |
| `AppRoute<T>` | Base class for typed route definitions |
| `RouteRegistry` | Mixin for route registry classes |
| `RouteMetadata` | Mixin for route metadata (title, icon) |

### Route Builder

| Class/Extension | Description |
|-----------------|-------------|
| `AppRouteConfig` | Configuration wrapper for typed routes |
| `AppRouteExtension` | Extension methods on `AppRoute` |
| `AppPageBuilder` | Typedef for page builder functions |

### Exit Guard

| Provider | Type | Description |
|----------|------|-------------|
| `exitGuardStateProvider` | `StateNotifierProvider` | Guard state changes |
| `exitGuardControllerProvider` | `Provider<IExitGuardController>` | Controller for manual ops |
| `exitConfirmationDialogProvider` | `Provider<IExitConfirmationDialog>` | Dialog implementation |

### Route Guards

| Class | Description |
|-------|-------------|
| `RouteGuard` | Base class for implementing guards |
| `FunctionalGuard` | Simple closure-based guard |
| `GuardResult` | Sealed class for check result (allowed, blocked, redirect) |
| `GuardContext` | Context passed to guards (location, params) |
| `GuardService` | Service that executes guards |

## Customization

### Custom Exit Dialog

```dart
class MyCustomDialog implements IExitConfirmationDialog {
  @override
  Future<bool> show(BuildContext context, ExitGuardConfig config) async {
    return await showCupertinoDialog<bool>(...) ?? false;
  }
}

// Override the provider
final container = ProviderContainer(
  overrides: [
    exitConfirmationDialogProvider.overrideWithValue(MyCustomDialog()),
  ],
);
```

### Route Metadata

```dart
class SettingsRoute extends AppRoute<NoParams> with RouteMetadata<NoParams> {
  const SettingsRoute();

  @override String get name => 'settings';
  @override String get path => '/settings';
  @override String buildPath([NoParams? p]) => path;

  @override String? get title => 'Settings';
  @override dynamic get icon => Icons.settings;
  @override bool get showInNavigation => true;
  @override int get navigationOrder => 3;
}
```

## License

MIT
