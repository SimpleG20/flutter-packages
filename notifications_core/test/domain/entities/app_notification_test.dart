import 'package:flutter_test/flutter_test.dart';
import 'package:notifications_core/notifications_core.dart';

void main() {
  group('AppNotification', () {
    test('should create with required fields', () {
      final now = DateTime.now();
      final notification = AppNotification(
        title: 'Test Title',
        body: 'Test Body',
        data: {'key': 'value'},
        receivedAt: now,
      );

      expect(notification.title, 'Test Title');
      expect(notification.body, 'Test Body');
      expect(notification.data, {'key': 'value'});
      expect(notification.receivedAt, now);
    });

    test('should create with null title and body', () {
      final now = DateTime.now();
      final notification = AppNotification(data: {}, receivedAt: now);

      expect(notification.title, isNull);
      expect(notification.body, isNull);
    });

    test('copyWith should return new instance with updated fields', () {
      final now = DateTime.now();
      final original = AppNotification(
        title: 'Original',
        body: 'Body',
        data: {'a': 1},
        receivedAt: now,
      );

      final copied = original.copyWith(title: 'Updated');

      expect(copied.title, 'Updated');
      expect(copied.body, 'Body');
      expect(copied.data, {'a': 1});
      expect(copied.receivedAt, now);
    });

    test('equality should work correctly', () {
      final now = DateTime.now();
      final a = AppNotification(
        title: 'Title',
        body: 'Body',
        data: {},
        receivedAt: now,
      );
      final b = AppNotification(
        title: 'Title',
        body: 'Body',
        data: {},
        receivedAt: now,
      );

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
    });

    test('toString should return formatted string', () {
      final now = DateTime(2026, 1, 30);
      final notification = AppNotification(
        title: 'Test',
        body: 'Body',
        data: {},
        receivedAt: now,
      );

      expect(
        notification.toString(),
        'AppNotification(title: Test, body: Body, receivedAt: 2026-01-30 00:00:00.000)',
      );
    });
  });
}
