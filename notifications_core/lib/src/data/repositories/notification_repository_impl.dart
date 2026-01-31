import '../../domain/entities/app_notification.dart';
import '../../domain/exceptions/notification_exception.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_datasource.dart';

/// Default implementation of [NotificationRepository].
///
/// Delegates all operations to the provided [NotificationDatasource].
/// Handles error wrapping and provides logging hooks.
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDatasource _datasource;

  NotificationRepositoryImpl(this._datasource);

  @override
  Future<void> initialize() async {
    try {
      await _datasource.initialize();
    } catch (e) {
      throw NotificationInitializationException(
        'Failed to initialize notifications',
        e,
      );
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await _datasource.getToken();
    } catch (e) {
      throw NotificationTokenException('Failed to get token', e);
    }
  }

  @override
  Stream<AppNotification> get notifications => _datasource.notifications;

  @override
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _datasource.subscribeToTopic(topic);
    } catch (e) {
      throw NotificationTopicException(
        topic,
        'Failed to subscribe to topic',
        e,
      );
    }
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _datasource.unsubscribeFromTopic(topic);
    } catch (e) {
      throw NotificationTopicException(
        topic,
        'Failed to unsubscribe from topic',
        e,
      );
    }
  }
}
