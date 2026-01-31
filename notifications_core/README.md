# notifications_core

A Flutter package for cross-platform push notifications with multi-provider support and Riverpod integration.

## Features

- **Multi-provider architecture** - Easily switch between Firebase, OneSignal, or custom providers
- **Riverpod integration** - Built-in providers for reactive state management
- **Clean Architecture** - Separation of concerns with domain, data, and presentation layers
- **Type-safe exceptions** - Sealed exception hierarchy for exhaustive error handling
- **Topic support** - Subscribe/unsubscribe to notification topics

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  notifications_core:
    path: packages/notifications_core
  firebase_messaging: ^16.0.0  # If using Firebase
```

## Usage

### 1. Setup with Firebase

```dart
import 'package:notifications_core/notifications_core.dart';
import 'package:notifications_core/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Register background handler (must be top-level function)
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessageHandler);

  runApp(
    ProviderScope(
      overrides: [
        notificationRepositoryProvider.overrideWithValue(
          NotificationRepositoryImpl(
            FirebaseNotificationDatasource.instance(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}
```

### 2. Initialize notifications

```dart
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize on app start
    ref.watch(notificationInitProvider);
    
    return MaterialApp(...);
  }
}
```

### 3. Listen for notifications

```dart
class NotificationListener extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notification = ref.watch(notificationStreamProvider);
    
    return notification.when(
      data: (notif) => Text('Received: ${notif.title}'),
      loading: () => CircularProgressIndicator(),
      error: (e, _) => Text('Error: $e'),
    );
  }
}
```

### 4. Get device token

```dart
final token = await ref.read(notificationTokenProvider.future);
```

### 5. Subscribe to topics

```dart
final repository = ref.read(notificationRepositoryProvider);
await repository.subscribeToTopic('news');
await repository.unsubscribeFromTopic('promotions');
```

## Custom Provider

Implement `NotificationDatasource` to add support for other providers:

```dart
class OneSignalDatasource implements NotificationDatasource {
  @override
  Future<void> initialize() async {
    // OneSignal initialization
  }
  
  // ... implement other methods
}
```

## Exception Handling

```dart
try {
  await repository.initialize();
} on NotificationPermissionDeniedException {
  // Handle permission denied
} on NotificationInitializationException catch (e) {
  // Handle initialization failure
}
```

## Architecture

```
lib/
├── notifications_core.dart  # Core exports
├── firebase.dart            # Firebase implementation
└── src/
    ├── domain/              # Entities, repositories, exceptions
    ├── data/                # Datasources, repository impl
    └── presentation/        # Riverpod providers
```

## License

MIT
