import 'package:meta/meta.dart';

/// Represents a notification received from any provider.
///
/// This is the core entity used across the package.
/// It is provider-agnostic and contains the common notification data.
@immutable
class AppNotification {
  /// The notification title.
  final String? title;

  /// The notification body text.
  final String? body;

  /// Additional data payload from the notification.
  final Map<String, dynamic> data;

  /// Timestamp when the notification was received.
  final DateTime receivedAt;

  const AppNotification({
    this.title,
    this.body,
    required this.data,
    required this.receivedAt,
  });

  /// Creates a copy of this notification with the given fields replaced.
  AppNotification copyWith({
    String? title,
    String? body,
    Map<String, dynamic>? data,
    DateTime? receivedAt,
  }) {
    return AppNotification(
      title: title ?? this.title,
      body: body ?? this.body,
      data: data ?? this.data,
      receivedAt: receivedAt ?? this.receivedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppNotification &&
        other.title == title &&
        other.body == body &&
        other.receivedAt == receivedAt;
  }

  @override
  int get hashCode => Object.hash(title, body, receivedAt);

  @override
  String toString() =>
      'AppNotification(title: $title, body: $body, receivedAt: $receivedAt)';
}
