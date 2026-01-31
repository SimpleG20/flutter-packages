# Navigation Kit

A decoupled navigation package for Flutter with exit confirmation support.

## Features

- **Exit Guard System**: Protect pages with unsaved changes
- **PopScope Integration**: Intercepts back button, swipe gestures (iOS/Android)
- **Riverpod State Management**: Centralized state with override support
- **Customizable Dialog**: Default Material dialog with full customization

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  navigation_kit:
    path: packages/navigation_kit
```

Run code generation:

```bash
cd packages/navigation_kit
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

## Quick Start

### 1. Wrap your app with ProviderScope

```dart
void main() {
  runApp(const ProviderScope(child: MyApp()));
}
```

### 2. Add the mixin to your page

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
            updateExitGuard(); // Sync with guard
          },
        ),
      ),
    );
  }
}
```

## Architecture

```
navigation_kit/
├── lib/
│   ├── navigation_kit.dart           # Barrel file
│   └── src/
│       ├── domain/                   # Entities & Interfaces
│       │   ├── entities/
│       │   │   ├── exit_guard_config.dart
│       │   │   └── exit_guard_state.dart
│       │   └── interfaces/
│       │       ├── exit_guard_controller.dart
│       │       └── exit_confirmation_dialog.dart
│       ├── application/              # Riverpod
│       │   ├── providers/
│       │   │   └── exit_guard_providers.dart
│       │   └── notifiers/
│       │       └── exit_guard_notifier.dart
│       └── presentation/             # Widgets & Mixins
│           ├── widgets/
│           │   ├── exit_guard_shell.dart
│           │   └── default_exit_confirmation_dialog.dart
│           └── mixins/
│               └── exit_guard_mixin.dart
```

## Customization

### Custom Dialog

```dart
class MyCustomDialog implements IExitConfirmationDialog {
  @override
  Future<bool> show(BuildContext context, ExitGuardConfig config) async {
    // Show your custom dialog
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

## Available Providers

| Provider | Type | Description |
|----------|------|-------------|
| `exitGuardStateProvider` | `StateNotifierProvider` | Guard state changes |
| `exitGuardControllerProvider` | `Provider<IExitGuardController>` | Controller for manual ops |
| `exitConfirmationDialogProvider` | `Provider<IExitConfirmationDialog>` | Dialog implementation |

## License

MIT
