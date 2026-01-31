import 'package:firebase_messaging/firebase_messaging.dart';

import '../../domain/entities/app_notification.dart';
import '../../domain/exceptions/notification_exception.dart';
import 'notification_datasource.dart';

/// Firebase Cloud Messaging implementation of [NotificationDatasource].
///
/// Requires `firebase_messaging` package to be added to the consuming app.
/// Make sure Firebase is initialized before using this datasource.
class FirebaseNotificationDatasource implements NotificationDatasource {
  final FirebaseMessaging _fcm;

  FirebaseNotificationDatasource(this._fcm);

  /// Creates an instance using [FirebaseMessaging.instance].
  factory FirebaseNotificationDatasource.instance() {
    return FirebaseNotificationDatasource(FirebaseMessaging.instance);
  }

  @override
  Future<void> initialize() async {
    try {
      final settings = await _fcm.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        throw const NotificationPermissionDeniedException();
      }
    } catch (e) {
      if (e is NotificationException) rethrow;
      throw NotificationInitializationException(
        'Failed to initialize Firebase Messaging',
        e,
      );
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await _fcm.getToken();
    } catch (e) {
      throw NotificationTokenException('Failed to get FCM token', e);
    }
  }

  @override
  Stream<AppNotification> get notifications {
    return FirebaseMessaging.onMessage.map(_mapRemoteMessage);
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _fcm.subscribeToTopic(topic);
    } catch (e) {
      throw NotificationTopicException(topic, 'Failed to subscribe', e);
    }
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _fcm.unsubscribeFromTopic(topic);
    } catch (e) {
      throw NotificationTopicException(topic, 'Failed to unsubscribe', e);
    }
  }

  AppNotification _mapRemoteMessage(RemoteMessage message) {
    return AppNotification(
      title: message.notification?.title,
      body: message.notification?.body,
      data: message.data,
      receivedAt: DateTime.now(),
    );
  }
}

/// Background message handler for Firebase.
///
/// Must be a top-level function (not a class method).
/// Register this with [FirebaseMessaging.onBackgroundMessage].
@pragma('vm:entry-point')
Future<void> firebaseBackgroundMessageHandler(RemoteMessage message) async {
  // Background messages are handled by the OS notification system.
  // Override this function if you need custom background processing.
}
