import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:go_router/go_router.dart';
import 'package:router_core/router_core.dart';
import 'package:router_core/src/application/services/navigation_service_impl.dart';

class MockGoRouter extends Mock implements GoRouter {}

// Test Implementation of routes
class TestRoute extends AppRoute<NoParams> {
  const TestRoute();
  @override
  String get name => 'test';
  @override
  String get path => '/test';
  @override
  String buildPath([NoParams? params]) => path;
}

void main() {
  late MockGoRouter mockRouter;
  late NavigationServiceImpl service;

  setUp(() {
    mockRouter = MockGoRouter();
    service = NavigationServiceImpl(mockRouter);

    // Default stubs
    when(() => mockRouter.canPop()).thenReturn(true);
    when(
      () => mockRouter.go(any(), extra: any(named: 'extra')),
    ).thenReturn(null);
    when(
      () => mockRouter.push<dynamic>(any(), extra: any(named: 'extra')),
    ).thenAnswer((_) async => null);
    when(
      () => mockRouter.replace(any(), extra: any(named: 'extra')),
    ).thenAnswer((_) async => null);
    when(() => mockRouter.pop(any())).thenReturn(null);
  });

  test('go should call router.go with correct location', () {
    service.go(const TestRoute());
    verify(() => mockRouter.go('/test', extra: null)).called(1);
  });

  test('push should call router.push', () {
    service.push(const TestRoute());
    verify(() => mockRouter.push<dynamic>('/test', extra: null)).called(1);
  });

  test('replace should call router.replace', () {
    service.replace(const TestRoute());
    verify(() => mockRouter.replace('/test', extra: null)).called(1);
  });

  /*
  test('pop should call router.pop if canPop is true', () {
    service.pop();
    verify(() => mockRouter.pop(null)).called(1);
  });

  test('pop should NOT call router.pop if canPop is false', () {
    when(() => mockRouter.canPop()).thenReturn(false);
    service.pop();
    verifyNever(() => mockRouter.pop(any()));
  });
  */
}
