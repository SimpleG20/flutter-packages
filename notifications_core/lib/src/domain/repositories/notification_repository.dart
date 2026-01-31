import '../entities/app_notification.dart';

/// Abstract interface for notification repository.
///
/// This defines the contract that all notification providers must implement.
/// Use dependency injection to provide the concrete implementation.
abstract interface class NotificationRepository {
  /// Initializes the notification service.
  ///
  /// This should request permissions and set up background handlers.
  /// Throws [NotificationInitializationException] on failure.
  Future<void> initialize();

  /// Gets the device token for push notifications.
  ///
  /// Returns `null` if the token is not available.
  /// Throws [NotificationTokenException] on failure.
  Future<String?> getToken();

  /// Stream of incoming notifications.
  ///
  /// Emits notifications received while the app is in foreground.
  Stream<AppNotification> get notifications;

  /// Subscribes to a notification topic.
  ///
  /// Topics are used for broadcasting notifications to groups of devices.
  Future<void> subscribeToTopic(String topic);

  /// Unsubscribes from a notification topic.
  Future<void> unsubscribeFromTopic(String topic);
}
