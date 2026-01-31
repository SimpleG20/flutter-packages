// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exit_guard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ExitGuardState {
  /// Whether the exit guard is currently active for any route.
  bool get isEnabled => throw _privateConstructorUsedError;

  /// Whether the current route has unsaved changes.
  /// When true, navigation will trigger the confirmation dialog.
  bool get isDirty => throw _privateConstructorUsedError;

  /// The route path currently being guarded.
  /// Null when no route is registered.
  String? get routePath => throw _privateConstructorUsedError;

  /// Custom configuration for the exit dialog.
  /// Falls back to [ExitGuardConfig.defaultConfig] when null.
  ExitGuardConfig? get config => throw _privateConstructorUsedError;

  /// Create a copy of ExitGuardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExitGuardStateCopyWith<ExitGuardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExitGuardStateCopyWith<$Res> {
  factory $ExitGuardStateCopyWith(
    ExitGuardState value,
    $Res Function(ExitGuardState) then,
  ) = _$ExitGuardStateCopyWithImpl<$Res, ExitGuardState>;
  @useResult
  $Res call({
    bool isEnabled,
    bool isDirty,
    String? routePath,
    ExitGuardConfig? config,
  });

  $ExitGuardConfigCopyWith<$Res>? get config;
}

/// @nodoc
class _$ExitGuardStateCopyWithImpl<$Res, $Val extends ExitGuardState>
    implements $ExitGuardStateCopyWith<$Res> {
  _$ExitGuardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExitGuardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
    Object? isDirty = null,
    Object? routePath = freezed,
    Object? config = freezed,
  }) {
    return _then(
      _value.copyWith(
            isEnabled: null == isEnabled
                ? _value.isEnabled
                : isEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            isDirty: null == isDirty
                ? _value.isDirty
                : isDirty // ignore: cast_nullable_to_non_nullable
                      as bool,
            routePath: freezed == routePath
                ? _value.routePath
                : routePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            config: freezed == config
                ? _value.config
                : config // ignore: cast_nullable_to_non_nullable
                      as ExitGuardConfig?,
          )
          as $Val,
    );
  }

  /// Create a copy of ExitGuardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExitGuardConfigCopyWith<$Res>? get config {
    if (_value.config == null) {
      return null;
    }

    return $ExitGuardConfigCopyWith<$Res>(_value.config!, (value) {
      return _then(_value.copyWith(config: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExitGuardStateImplCopyWith<$Res>
    implements $ExitGuardStateCopyWith<$Res> {
  factory _$$ExitGuardStateImplCopyWith(
    _$ExitGuardStateImpl value,
    $Res Function(_$ExitGuardStateImpl) then,
  ) = __$$ExitGuardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isEnabled,
    bool isDirty,
    String? routePath,
    ExitGuardConfig? config,
  });

  @override
  $ExitGuardConfigCopyWith<$Res>? get config;
}

/// @nodoc
class __$$ExitGuardStateImplCopyWithImpl<$Res>
    extends _$ExitGuardStateCopyWithImpl<$Res, _$ExitGuardStateImpl>
    implements _$$ExitGuardStateImplCopyWith<$Res> {
  __$$ExitGuardStateImplCopyWithImpl(
    _$ExitGuardStateImpl _value,
    $Res Function(_$ExitGuardStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExitGuardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
    Object? isDirty = null,
    Object? routePath = freezed,
    Object? config = freezed,
  }) {
    return _then(
      _$ExitGuardStateImpl(
        isEnabled: null == isEnabled
            ? _value.isEnabled
            : isEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        isDirty: null == isDirty
            ? _value.isDirty
            : isDirty // ignore: cast_nullable_to_non_nullable
                  as bool,
        routePath: freezed == routePath
            ? _value.routePath
            : routePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        config: freezed == config
            ? _value.config
            : config // ignore: cast_nullable_to_non_nullable
                  as ExitGuardConfig?,
      ),
    );
  }
}

/// @nodoc

class _$ExitGuardStateImpl extends _ExitGuardState {
  const _$ExitGuardStateImpl({
    this.isEnabled = false,
    this.isDirty = false,
    this.routePath,
    this.config,
  }) : super._();

  /// Whether the exit guard is currently active for any route.
  @override
  @JsonKey()
  final bool isEnabled;

  /// Whether the current route has unsaved changes.
  /// When true, navigation will trigger the confirmation dialog.
  @override
  @JsonKey()
  final bool isDirty;

  /// The route path currently being guarded.
  /// Null when no route is registered.
  @override
  final String? routePath;

  /// Custom configuration for the exit dialog.
  /// Falls back to [ExitGuardConfig.defaultConfig] when null.
  @override
  final ExitGuardConfig? config;

  @override
  String toString() {
    return 'ExitGuardState(isEnabled: $isEnabled, isDirty: $isDirty, routePath: $routePath, config: $config)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExitGuardStateImpl &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.isDirty, isDirty) || other.isDirty == isDirty) &&
            (identical(other.routePath, routePath) ||
                other.routePath == routePath) &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isEnabled, isDirty, routePath, config);

  /// Create a copy of ExitGuardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExitGuardStateImplCopyWith<_$ExitGuardStateImpl> get copyWith =>
      __$$ExitGuardStateImplCopyWithImpl<_$ExitGuardStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ExitGuardState extends ExitGuardState {
  const factory _ExitGuardState({
    final bool isEnabled,
    final bool isDirty,
    final String? routePath,
    final ExitGuardConfig? config,
  }) = _$ExitGuardStateImpl;
  const _ExitGuardState._() : super._();

  /// Whether the exit guard is currently active for any route.
  @override
  bool get isEnabled;

  /// Whether the current route has unsaved changes.
  /// When true, navigation will trigger the confirmation dialog.
  @override
  bool get isDirty;

  /// The route path currently being guarded.
  /// Null when no route is registered.
  @override
  String? get routePath;

  /// Custom configuration for the exit dialog.
  /// Falls back to [ExitGuardConfig.defaultConfig] when null.
  @override
  ExitGuardConfig? get config;

  /// Create a copy of ExitGuardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExitGuardStateImplCopyWith<_$ExitGuardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
