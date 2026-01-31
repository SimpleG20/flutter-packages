import 'package:flutter_test/flutter_test.dart';
import 'package:router_core/src/domain/entities/exit_guard_config.dart';

void main() {
  group('ExitGuardConfig', () {
    test('should create with default values', () {
      const config = ExitGuardConfig();

      expect(config.title, 'Unsaved Changes');
      expect(
        config.message,
        'You have unsaved changes. Are you sure you want to leave?',
      );
      expect(config.confirmLabel, 'Leave');
      expect(config.cancelLabel, 'Stay');
      expect(config.barrierDismissible, false);
    });

    test('should create with custom values', () {
      const config = ExitGuardConfig(
        title: 'Custom Title',
        message: 'Custom message',
        confirmLabel: 'Yes',
        cancelLabel: 'No',
        barrierDismissible: true,
      );

      expect(config.title, 'Custom Title');
      expect(config.message, 'Custom message');
      expect(config.confirmLabel, 'Yes');
      expect(config.cancelLabel, 'No');
      expect(config.barrierDismissible, true);
    });

    test('copyWith should preserve values when null', () {
      const original = ExitGuardConfig(title: 'Original');
      final copied = original.copyWith();

      expect(copied.title, 'Original');
    });

    test('copyWith should override values when provided', () {
      const original = ExitGuardConfig(title: 'Original');
      final copied = original.copyWith(title: 'New Title');

      expect(copied.title, 'New Title');
      expect(original.title, 'Original');
    });

    test('defaultConfig should match default constructor', () {
      expect(ExitGuardConfig.defaultConfig, const ExitGuardConfig());
    });
  });
}
