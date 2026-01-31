/// Base exception for all notification-related errors.
sealed class NotificationException implements Exception {
  final String message;
  final Object? cause;

  const NotificationException(this.message, [this.cause]);

  @override
  String toString() => '$runtimeType: $message';
}

/// Thrown when notification service initialization fails.
final class NotificationInitializationException extends NotificationException {
  const NotificationInitializationException(super.message, [super.cause]);
}

/// Thrown when notification permission is denied by the user.
final class NotificationPermissionDeniedException
    extends NotificationException {
  const NotificationPermissionDeniedException([
    super.message = 'Notification permission denied',
  ]);
}

/// Thrown when unable to retrieve the device token.
final class NotificationTokenException extends NotificationException {
  const NotificationTokenException(super.message, [super.cause]);
}

/// Thrown when topic subscription/unsubscription fails.
final class NotificationTopicException extends NotificationException {
  final String topic;

  const NotificationTopicException(this.topic, String message, [Object? cause])
    : super(message, cause);

  @override
  String toString() => '$runtimeType: $message (topic: $topic)';
}
