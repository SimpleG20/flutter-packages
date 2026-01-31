import 'package:flutter_test/flutter_test.dart';
import 'package:notifications_core/notifications_core.dart';

void main() {
  group('NotificationException', () {
    test('NotificationInitializationException should have message', () {
      const exception = NotificationInitializationException('Failed to init');

      expect(exception.message, 'Failed to init');
      expect(exception.cause, isNull);
      expect(
        exception.toString(),
        'NotificationInitializationException: Failed to init',
      );
    });

    test('NotificationInitializationException should include cause', () {
      final cause = Exception('Root cause');
      final exception = NotificationInitializationException('Failed', cause);

      expect(exception.message, 'Failed');
      expect(exception.cause, cause);
    });

    test(
      'NotificationPermissionDeniedException should have default message',
      () {
        const exception = NotificationPermissionDeniedException();

        expect(exception.message, 'Notification permission denied');
      },
    );

    test('NotificationTokenException should have message and cause', () {
      final exception = NotificationTokenException('Token error', 'cause');

      expect(exception.message, 'Token error');
      expect(exception.cause, 'cause');
    });

    test('NotificationTopicException should include topic in toString', () {
      const exception = NotificationTopicException(
        'news',
        'Subscribe failed',
        null,
      );

      expect(exception.topic, 'news');
      expect(exception.message, 'Subscribe failed');
      expect(
        exception.toString(),
        'NotificationTopicException: Subscribe failed (topic: news)',
      );
    });
  });
}
