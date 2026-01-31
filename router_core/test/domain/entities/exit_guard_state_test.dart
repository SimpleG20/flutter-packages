import 'package:flutter_test/flutter_test.dart';
import 'package:router_core/src/domain/entities/exit_guard_config.dart';
import 'package:router_core/src/domain/entities/exit_guard_state.dart';

void main() {
  group('ExitGuardState', () {
    test('should create with default values', () {
      const state = ExitGuardState();

      expect(state.isEnabled, false);
      expect(state.isDirty, false);
      expect(state.routePath, isNull);
      expect(state.config, isNull);
    });

    test('shouldBlock returns false when not enabled', () {
      const state = ExitGuardState(isEnabled: false, isDirty: true);

      expect(state.shouldBlock, false);
    });

    test('shouldBlock returns false when not dirty', () {
      const state = ExitGuardState(isEnabled: true, isDirty: false);

      expect(state.shouldBlock, false);
    });

    test('shouldBlock returns true when enabled and dirty', () {
      const state = ExitGuardState(isEnabled: true, isDirty: true);

      expect(state.shouldBlock, true);
    });

    test('effectiveConfig returns default when config is null', () {
      const state = ExitGuardState();

      expect(state.effectiveConfig, ExitGuardConfig.defaultConfig);
    });

    test('effectiveConfig returns custom config when provided', () {
      const customConfig = ExitGuardConfig(title: 'Custom');
      const state = ExitGuardState(config: customConfig);

      expect(state.effectiveConfig.title, 'Custom');
    });

    test('copyWith preserves values when null', () {
      const state = ExitGuardState(
        isEnabled: true,
        isDirty: true,
        routePath: '/test',
      );
      final copied = state.copyWith();

      expect(copied.isEnabled, true);
      expect(copied.isDirty, true);
      expect(copied.routePath, '/test');
    });

    test('copyWith overrides values when provided', () {
      const state = ExitGuardState(isEnabled: true, isDirty: true);
      final copied = state.copyWith(isDirty: false);

      expect(copied.isDirty, false);
      expect(copied.isEnabled, true);
    });
  });
}
