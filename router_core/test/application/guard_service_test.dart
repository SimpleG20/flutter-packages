import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:router_core/router_core.dart';

// Helper classes
class SimpleGuard extends RouteGuard {
  @override
  final String name;
  final GuardResult result;

  SimpleGuard(this.name, this.result);

  @override
  FutureOr<GuardResult> check(GuardContext context) => result;
}

class PathGuard extends RouteGuard {
  final String targetPath;

  PathGuard(this.targetPath);

  @override
  String get name => 'PathGuard';

  @override
  bool appliesTo(String location) => location.startsWith(targetPath);

  @override
  FutureOr<GuardResult> check(GuardContext context) =>
      const GuardResult.blocked(reason: 'Blocked path');
}

class ExceptionGuard extends RouteGuard {
  @override
  String get name => 'ExceptionGuard';

  @override
  FutureOr<GuardResult> check(GuardContext context) {
    throw Exception('Test Error');
  }
}

void main() {
  group('GuardService', () {
    late GuardService service;

    setUp(() {
      service = GuardService();
    });

    test('should register and unregister guards', () {
      final guard = SimpleGuard('test', const GuardResult.allowed());
      service.register(guard);
      expect(service.guards.length, 1);
      expect(service.guards.first, guard);

      service.unregister(guard);
      expect(service.guards, isEmpty);
    });

    test('evaluate should return allowed when no guards registered', () async {
      const context = GuardContext(location: '/');
      final result = await service.evaluate(context);

      expect(
        result.maybeWhen(allowed: () => true, orElse: () => false),
        isTrue,
        reason: 'Should be allowed by default',
      );
    });

    test('evaluate should return allowed when all guards allow', () async {
      service.register(SimpleGuard('g1', const GuardResult.allowed()));
      service.register(SimpleGuard('g2', const GuardResult.allowed()));

      const context = GuardContext(location: '/');
      final result = await service.evaluate(context);

      expect(
        result.maybeWhen(allowed: () => true, orElse: () => false),
        isTrue,
      );
    });

    test('evaluate should stop at first blocked/redirect guard', () async {
      service.register(SimpleGuard('g1', const GuardResult.allowed()));
      service.register(
        SimpleGuard('g2', const GuardResult.blocked(reason: 'Stop')),
      );
      service.register(SimpleGuard('g3', const GuardResult.allowed()));

      const context = GuardContext(location: '/');
      final result = await service.evaluate(context);

      result.maybeWhen(
        blocked: (reason) => expect(reason, 'Stop'),
        orElse: () => fail('Should be blocked'),
      );
    });

    test('evaluate should only check applicable guards', () async {
      service.register(PathGuard('/protected'));

      // Should pass because guard doesn't apply
      var context = const GuardContext(location: '/public');
      var result = await service.evaluate(context);
      expect(
        result.maybeWhen(allowed: () => true, orElse: () => false),
        isTrue,
        reason: 'Should ignore non-applicable guard',
      );

      // Should block because guard applies
      context = const GuardContext(location: '/protected/123');
      result = await service.evaluate(context);
      result.maybeWhen(
        blocked: (_) => null, // Success
        orElse: () => fail('Should be blocked'),
      );
    });

    test('evaluate should fail closed (blocked) on exception', () async {
      service.register(ExceptionGuard());

      const context = GuardContext(location: '/');
      final result = await service.evaluate(context);

      result.maybeWhen(
        blocked: (reason) => expect(reason, contains('Internal error')),
        orElse: () => fail('Should block on exception'),
      );
    });
  });
}
