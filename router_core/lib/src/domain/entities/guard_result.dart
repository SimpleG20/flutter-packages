import 'package:freezed_annotation/freezed_annotation.dart';

part 'guard_result.freezed.dart';

/// Result of a route guard check.
@freezed
sealed class GuardResult with _$GuardResult {
  /// Allow navigation to proceed.
  const factory GuardResult.allowed() = GuardAllowed;

  /// Block navigation.
  const factory GuardResult.blocked({String? reason}) = GuardBlocked;

  /// Redirect to a new location.
  const factory GuardResult.redirect(String location, {Object? extra}) =
      GuardRedirect;
}
