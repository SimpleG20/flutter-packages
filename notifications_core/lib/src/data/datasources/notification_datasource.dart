import '../../domain/entities/app_notification.dart';

/// Abstract interface for notification data sources.
///
/// Implement this interface for each notification provider
/// (Firebase, OneSignal, Local, etc.).
abstract interface class NotificationDatasource {
  /// Initializes the notification datasource.
  Future<void> initialize();

  /// Gets the device push notification token.
  Future<String?> getToken();

  /// Stream of incoming notifications.
  Stream<AppNotification> get notifications;

  /// Subscribes to a notification topic.
  Future<void> subscribeToTopic(String topic);

  /// Unsubscribes from a notification topic.
  Future<void> unsubscribeFromTopic(String topic);
}
