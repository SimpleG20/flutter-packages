import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/notification_repository.dart';

/// Provider for [NotificationRepository].
///
/// This provider must be overridden with a concrete implementation.
/// Use [ProviderScope.overrides] to provide the implementation.
///
/// Example:
/// ```dart
/// ProviderScope(
///   overrides: [
///     notificationRepositoryProvider.overrideWithValue(
///       NotificationRepositoryImpl(
///         FirebaseNotificationDatasource.instance(),
///       ),
///     ),
///   ],
///   child: MyApp(),
/// )
/// ```
final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  throw UnimplementedError(
    'notificationRepositoryProvider must be overridden. '
    'See package documentation for usage.',
  );
});

/// Stream of incoming notifications.
///
/// Listens to [NotificationRepository.notifications] and emits
/// each notification as it arrives.
final notificationStreamProvider = StreamProvider<AppNotification>((ref) {
  final repository = ref.watch(notificationRepositoryProvider);
  return repository.notifications;
});

/// Provider for the device push notification token.
///
/// Returns `null` if the token is not available.
final notificationTokenProvider = FutureProvider<String?>((ref) {
  final repository = ref.watch(notificationRepositoryProvider);
  return repository.getToken();
});

/// Provider to initialize the notification service.
///
/// Call this during app startup to request permissions and set up handlers.
final notificationInitProvider = FutureProvider<void>((ref) async {
  final repository = ref.watch(notificationRepositoryProvider);
  await repository.initialize();
});
