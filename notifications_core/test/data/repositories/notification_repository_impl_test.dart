import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notifications_core/notifications_core.dart';

class MockNotificationDatasource extends Mock
    implements NotificationDatasource {}

void main() {
  late MockNotificationDatasource mockDatasource;
  late NotificationRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockNotificationDatasource();
    repository = NotificationRepositoryImpl(mockDatasource);
  });

  group('NotificationRepositoryImpl', () {
    group('initialize', () {
      test('should call datasource initialize on success', () async {
        when(() => mockDatasource.initialize()).thenAnswer((_) async {});

        await repository.initialize();

        verify(() => mockDatasource.initialize()).called(1);
      });

      test(
        'should throw NotificationInitializationException on error',
        () async {
          when(
            () => mockDatasource.initialize(),
          ).thenThrow(Exception('Init failed'));

          expect(
            () => repository.initialize(),
            throwsA(isA<NotificationInitializationException>()),
          );
        },
      );
    });

    group('getToken', () {
      test('should return token from datasource', () async {
        when(
          () => mockDatasource.getToken(),
        ).thenAnswer((_) async => 'test-token');

        final token = await repository.getToken();

        expect(token, 'test-token');
      });

      test('should return null when no token available', () async {
        when(() => mockDatasource.getToken()).thenAnswer((_) async => null);

        final token = await repository.getToken();

        expect(token, isNull);
      });

      test('should throw NotificationTokenException on error', () async {
        when(
          () => mockDatasource.getToken(),
        ).thenThrow(Exception('Token error'));

        expect(
          () => repository.getToken(),
          throwsA(isA<NotificationTokenException>()),
        );
      });
    });

    group('notifications', () {
      test('should return stream from datasource', () async {
        final notification = AppNotification(
          title: 'Test',
          body: 'Body',
          data: {},
          receivedAt: DateTime.now(),
        );
        final controller = StreamController<AppNotification>();

        when(
          () => mockDatasource.notifications,
        ).thenAnswer((_) => controller.stream);

        final stream = repository.notifications;
        controller.add(notification);

        await expectLater(stream, emits(notification));

        await controller.close();
      });
    });

    group('subscribeToTopic', () {
      test('should call datasource subscribeToTopic', () async {
        when(
          () => mockDatasource.subscribeToTopic('news'),
        ).thenAnswer((_) async {});

        await repository.subscribeToTopic('news');

        verify(() => mockDatasource.subscribeToTopic('news')).called(1);
      });

      test('should throw NotificationTopicException on error', () async {
        when(
          () => mockDatasource.subscribeToTopic('news'),
        ).thenThrow(Exception('Subscribe error'));

        expect(
          () => repository.subscribeToTopic('news'),
          throwsA(isA<NotificationTopicException>()),
        );
      });
    });

    group('unsubscribeFromTopic', () {
      test('should call datasource unsubscribeFromTopic', () async {
        when(
          () => mockDatasource.unsubscribeFromTopic('news'),
        ).thenAnswer((_) async {});

        await repository.unsubscribeFromTopic('news');

        verify(() => mockDatasource.unsubscribeFromTopic('news')).called(1);
      });

      test('should throw NotificationTopicException on error', () async {
        when(
          () => mockDatasource.unsubscribeFromTopic('news'),
        ).thenThrow(Exception('Unsubscribe error'));

        expect(
          () => repository.unsubscribeFromTopic('news'),
          throwsA(isA<NotificationTopicException>()),
        );
      });
    });
  });
}
