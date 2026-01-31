// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exit_guard_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ExitGuardConfig {
  /// The title displayed at the top of the dialog.
  String get title => throw _privateConstructorUsedError;

  /// The message body explaining why confirmation is needed.
  String get message => throw _privateConstructorUsedError;

  /// Label for the "leave" / confirm button.
  String get confirmLabel => throw _privateConstructorUsedError;

  /// Label for the "stay" / cancel button.
  String get cancelLabel => throw _privateConstructorUsedError;

  /// Whether tapping outside the dialog dismisses it (counts as cancel).
  bool get barrierDismissible => throw _privateConstructorUsedError;

  /// Create a copy of ExitGuardConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExitGuardConfigCopyWith<ExitGuardConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExitGuardConfigCopyWith<$Res> {
  factory $ExitGuardConfigCopyWith(
    ExitGuardConfig value,
    $Res Function(ExitGuardConfig) then,
  ) = _$ExitGuardConfigCopyWithImpl<$Res, ExitGuardConfig>;
  @useResult
  $Res call({
    String title,
    String message,
    String confirmLabel,
    String cancelLabel,
    bool barrierDismissible,
  });
}

/// @nodoc
class _$ExitGuardConfigCopyWithImpl<$Res, $Val extends ExitGuardConfig>
    implements $ExitGuardConfigCopyWith<$Res> {
  _$ExitGuardConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExitGuardConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
    Object? confirmLabel = null,
    Object? cancelLabel = null,
    Object? barrierDismissible = null,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            confirmLabel: null == confirmLabel
                ? _value.confirmLabel
                : confirmLabel // ignore: cast_nullable_to_non_nullable
                      as String,
            cancelLabel: null == cancelLabel
                ? _value.cancelLabel
                : cancelLabel // ignore: cast_nullable_to_non_nullable
                      as String,
            barrierDismissible: null == barrierDismissible
                ? _value.barrierDismissible
                : barrierDismissible // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExitGuardConfigImplCopyWith<$Res>
    implements $ExitGuardConfigCopyWith<$Res> {
  factory _$$ExitGuardConfigImplCopyWith(
    _$ExitGuardConfigImpl value,
    $Res Function(_$ExitGuardConfigImpl) then,
  ) = __$$ExitGuardConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String message,
    String confirmLabel,
    String cancelLabel,
    bool barrierDismissible,
  });
}

/// @nodoc
class __$$ExitGuardConfigImplCopyWithImpl<$Res>
    extends _$ExitGuardConfigCopyWithImpl<$Res, _$ExitGuardConfigImpl>
    implements _$$ExitGuardConfigImplCopyWith<$Res> {
  __$$ExitGuardConfigImplCopyWithImpl(
    _$ExitGuardConfigImpl _value,
    $Res Function(_$ExitGuardConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExitGuardConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
    Object? confirmLabel = null,
    Object? cancelLabel = null,
    Object? barrierDismissible = null,
  }) {
    return _then(
      _$ExitGuardConfigImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        confirmLabel: null == confirmLabel
            ? _value.confirmLabel
            : confirmLabel // ignore: cast_nullable_to_non_nullable
                  as String,
        cancelLabel: null == cancelLabel
            ? _value.cancelLabel
            : cancelLabel // ignore: cast_nullable_to_non_nullable
                  as String,
        barrierDismissible: null == barrierDismissible
            ? _value.barrierDismissible
            : barrierDismissible // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ExitGuardConfigImpl implements _ExitGuardConfig {
  const _$ExitGuardConfigImpl({
    this.title = 'Unsaved Changes',
    this.message = 'You have unsaved changes. Are you sure you want to leave?',
    this.confirmLabel = 'Leave',
    this.cancelLabel = 'Stay',
    this.barrierDismissible = false,
  });

  /// The title displayed at the top of the dialog.
  @override
  @JsonKey()
  final String title;

  /// The message body explaining why confirmation is needed.
  @override
  @JsonKey()
  final String message;

  /// Label for the "leave" / confirm button.
  @override
  @JsonKey()
  final String confirmLabel;

  /// Label for the "stay" / cancel button.
  @override
  @JsonKey()
  final String cancelLabel;

  /// Whether tapping outside the dialog dismisses it (counts as cancel).
  @override
  @JsonKey()
  final bool barrierDismissible;

  @override
  String toString() {
    return 'ExitGuardConfig(title: $title, message: $message, confirmLabel: $confirmLabel, cancelLabel: $cancelLabel, barrierDismissible: $barrierDismissible)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExitGuardConfigImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.confirmLabel, confirmLabel) ||
                other.confirmLabel == confirmLabel) &&
            (identical(other.cancelLabel, cancelLabel) ||
                other.cancelLabel == cancelLabel) &&
            (identical(other.barrierDismissible, barrierDismissible) ||
                other.barrierDismissible == barrierDismissible));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    message,
    confirmLabel,
    cancelLabel,
    barrierDismissible,
  );

  /// Create a copy of ExitGuardConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExitGuardConfigImplCopyWith<_$ExitGuardConfigImpl> get copyWith =>
      __$$ExitGuardConfigImplCopyWithImpl<_$ExitGuardConfigImpl>(
        this,
        _$identity,
      );
}

abstract class _ExitGuardConfig implements ExitGuardConfig {
  const factory _ExitGuardConfig({
    final String title,
    final String message,
    final String confirmLabel,
    final String cancelLabel,
    final bool barrierDismissible,
  }) = _$ExitGuardConfigImpl;

  /// The title displayed at the top of the dialog.
  @override
  String get title;

  /// The message body explaining why confirmation is needed.
  @override
  String get message;

  /// Label for the "leave" / confirm button.
  @override
  String get confirmLabel;

  /// Label for the "stay" / cancel button.
  @override
  String get cancelLabel;

  /// Whether tapping outside the dialog dismisses it (counts as cancel).
  @override
  bool get barrierDismissible;

  /// Create a copy of ExitGuardConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExitGuardConfigImplCopyWith<_$ExitGuardConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
