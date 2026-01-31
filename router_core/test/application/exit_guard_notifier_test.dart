import 'package:flutter_test/flutter_test.dart';
import 'package:navigation_kit/src/application/notifiers/exit_guard_notifier.dart';
import 'package:navigation_kit/src/domain/entities/exit_guard_config.dart';
import 'package:navigation_kit/src/domain/entities/exit_guard_state.dart';

void main() {
  group('ExitGuardNotifier', () {
    late ExitGuardNotifier notifier;

    setUp(() {
      notifier = ExitGuardNotifier();
    });

    test('initial state is empty', () {
      expect(notifier.state, const ExitGuardState());
      expect(notifier.state.isEnabled, false);
      expect(notifier.state.isDirty, false);
    });

    test('registerRoute enables guard and sets path', () {
      notifier.registerRoute('/test');

      expect(notifier.state.isEnabled, true);
      expect(notifier.state.routePath, '/test');
      expect(notifier.state.isDirty, false);
    });

    test('registerRoute with config stores config', () {
      const config = ExitGuardConfig(title: 'Custom');
      notifier.registerRoute('/test', config: config);

      expect(notifier.state.config?.title, 'Custom');
    });

    test('unregisterRoute clears state for matching path', () {
      notifier.registerRoute('/test');
      notifier.unregisterRoute('/test');

      expect(notifier.state.isEnabled, false);
      expect(notifier.state.routePath, isNull);
    });

    test('unregisterRoute ignores non-matching path', () {
      notifier.registerRoute('/test');
      notifier.unregisterRoute('/other');

      expect(notifier.state.isEnabled, true);
      expect(notifier.state.routePath, '/test');
    });

    test('setDirty updates dirty state when enabled', () {
      notifier.registerRoute('/test');
      notifier.setDirty(true);

      expect(notifier.state.isDirty, true);
    });

    test('setDirty does nothing when not enabled', () {
      notifier.setDirty(true);

      expect(notifier.state.isDirty, false);
    });

    test('isRouteRegistered returns true for registered path', () {
      notifier.registerRoute('/test');

      expect(notifier.isRouteRegistered('/test'), true);
      expect(notifier.isRouteRegistered('/other'), false);
    });

    test('clearDirty resets dirty without unregistering', () {
      notifier.registerRoute('/test');
      notifier.setDirty(true);
      notifier.clearDirty();

      expect(notifier.state.isDirty, false);
      expect(notifier.state.isEnabled, true);
    });
  });
}
