// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'guard_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GuardResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() allowed,
    required TResult Function(String? reason) blocked,
    required TResult Function(String location, Object? extra) redirect,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? allowed,
    TResult? Function(String? reason)? blocked,
    TResult? Function(String location, Object? extra)? redirect,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? allowed,
    TResult Function(String? reason)? blocked,
    TResult Function(String location, Object? extra)? redirect,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GuardAllowed value) allowed,
    required TResult Function(GuardBlocked value) blocked,
    required TResult Function(GuardRedirect value) redirect,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GuardAllowed value)? allowed,
    TResult? Function(GuardBlocked value)? blocked,
    TResult? Function(GuardRedirect value)? redirect,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GuardAllowed value)? allowed,
    TResult Function(GuardBlocked value)? blocked,
    TResult Function(GuardRedirect value)? redirect,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuardResultCopyWith<$Res> {
  factory $GuardResultCopyWith(
    GuardResult value,
    $Res Function(GuardResult) then,
  ) = _$GuardResultCopyWithImpl<$Res, GuardResult>;
}

/// @nodoc
class _$GuardResultCopyWithImpl<$Res, $Val extends GuardResult>
    implements $GuardResultCopyWith<$Res> {
  _$GuardResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GuardResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$GuardAllowedImplCopyWith<$Res> {
  factory _$$GuardAllowedImplCopyWith(
    _$GuardAllowedImpl value,
    $Res Function(_$GuardAllowedImpl) then,
  ) = __$$GuardAllowedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GuardAllowedImplCopyWithImpl<$Res>
    extends _$GuardResultCopyWithImpl<$Res, _$GuardAllowedImpl>
    implements _$$GuardAllowedImplCopyWith<$Res> {
  __$$GuardAllowedImplCopyWithImpl(
    _$GuardAllowedImpl _value,
    $Res Function(_$GuardAllowedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GuardResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GuardAllowedImpl implements GuardAllowed {
  const _$GuardAllowedImpl();

  @override
  String toString() {
    return 'GuardResult.allowed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GuardAllowedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() allowed,
    required TResult Function(String? reason) blocked,
    required TResult Function(String location, Object? extra) redirect,
  }) {
    return allowed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? allowed,
    TResult? Function(String? reason)? blocked,
    TResult? Function(String location, Object? extra)? redirect,
  }) {
    return allowed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? allowed,
    TResult Function(String? reason)? blocked,
    TResult Function(String location, Object? extra)? redirect,
    required TResult orElse(),
  }) {
    if (allowed != null) {
      return allowed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GuardAllowed value) allowed,
    required TResult Function(GuardBlocked value) blocked,
    required TResult Function(GuardRedirect value) redirect,
  }) {
    return allowed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GuardAllowed value)? allowed,
    TResult? Function(GuardBlocked value)? blocked,
    TResult? Function(GuardRedirect value)? redirect,
  }) {
    return allowed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GuardAllowed value)? allowed,
    TResult Function(GuardBlocked value)? blocked,
    TResult Function(GuardRedirect value)? redirect,
    required TResult orElse(),
  }) {
    if (allowed != null) {
      return allowed(this);
    }
    return orElse();
  }
}

abstract class GuardAllowed implements GuardResult {
  const factory GuardAllowed() = _$GuardAllowedImpl;
}

/// @nodoc
abstract class _$$GuardBlockedImplCopyWith<$Res> {
  factory _$$GuardBlockedImplCopyWith(
    _$GuardBlockedImpl value,
    $Res Function(_$GuardBlockedImpl) then,
  ) = __$$GuardBlockedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? reason});
}

/// @nodoc
class __$$GuardBlockedImplCopyWithImpl<$Res>
    extends _$GuardResultCopyWithImpl<$Res, _$GuardBlockedImpl>
    implements _$$GuardBlockedImplCopyWith<$Res> {
  __$$GuardBlockedImplCopyWithImpl(
    _$GuardBlockedImpl _value,
    $Res Function(_$GuardBlockedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GuardResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? reason = freezed}) {
    return _then(
      _$GuardBlockedImpl(
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$GuardBlockedImpl implements GuardBlocked {
  const _$GuardBlockedImpl({this.reason});

  @override
  final String? reason;

  @override
  String toString() {
    return 'GuardResult.blocked(reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuardBlockedImpl &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason);

  /// Create a copy of GuardResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GuardBlockedImplCopyWith<_$GuardBlockedImpl> get copyWith =>
      __$$GuardBlockedImplCopyWithImpl<_$GuardBlockedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() allowed,
    required TResult Function(String? reason) blocked,
    required TResult Function(String location, Object? extra) redirect,
  }) {
    return blocked(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? allowed,
    TResult? Function(String? reason)? blocked,
    TResult? Function(String location, Object? extra)? redirect,
  }) {
    return blocked?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? allowed,
    TResult Function(String? reason)? blocked,
    TResult Function(String location, Object? extra)? redirect,
    required TResult orElse(),
  }) {
    if (blocked != null) {
      return blocked(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GuardAllowed value) allowed,
    required TResult Function(GuardBlocked value) blocked,
    required TResult Function(GuardRedirect value) redirect,
  }) {
    return blocked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GuardAllowed value)? allowed,
    TResult? Function(GuardBlocked value)? blocked,
    TResult? Function(GuardRedirect value)? redirect,
  }) {
    return blocked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GuardAllowed value)? allowed,
    TResult Function(GuardBlocked value)? blocked,
    TResult Function(GuardRedirect value)? redirect,
    required TResult orElse(),
  }) {
    if (blocked != null) {
      return blocked(this);
    }
    return orElse();
  }
}

abstract class GuardBlocked implements GuardResult {
  const factory GuardBlocked({final String? reason}) = _$GuardBlockedImpl;

  String? get reason;

  /// Create a copy of GuardResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GuardBlockedImplCopyWith<_$GuardBlockedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GuardRedirectImplCopyWith<$Res> {
  factory _$$GuardRedirectImplCopyWith(
    _$GuardRedirectImpl value,
    $Res Function(_$GuardRedirectImpl) then,
  ) = __$$GuardRedirectImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String location, Object? extra});
}

/// @nodoc
class __$$GuardRedirectImplCopyWithImpl<$Res>
    extends _$GuardResultCopyWithImpl<$Res, _$GuardRedirectImpl>
    implements _$$GuardRedirectImplCopyWith<$Res> {
  __$$GuardRedirectImplCopyWithImpl(
    _$GuardRedirectImpl _value,
    $Res Function(_$GuardRedirectImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GuardResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? location = null, Object? extra = freezed}) {
    return _then(
      _$GuardRedirectImpl(
        null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
        extra: freezed == extra ? _value.extra : extra,
      ),
    );
  }
}

/// @nodoc

class _$GuardRedirectImpl implements GuardRedirect {
  const _$GuardRedirectImpl(this.location, {this.extra});

  @override
  final String location;
  @override
  final Object? extra;

  @override
  String toString() {
    return 'GuardResult.redirect(location: $location, extra: $extra)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuardRedirectImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other.extra, extra));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    location,
    const DeepCollectionEquality().hash(extra),
  );

  /// Create a copy of GuardResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GuardRedirectImplCopyWith<_$GuardRedirectImpl> get copyWith =>
      __$$GuardRedirectImplCopyWithImpl<_$GuardRedirectImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() allowed,
    required TResult Function(String? reason) blocked,
    required TResult Function(String location, Object? extra) redirect,
  }) {
    return redirect(location, extra);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? allowed,
    TResult? Function(String? reason)? blocked,
    TResult? Function(String location, Object? extra)? redirect,
  }) {
    return redirect?.call(location, extra);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? allowed,
    TResult Function(String? reason)? blocked,
    TResult Function(String location, Object? extra)? redirect,
    required TResult orElse(),
  }) {
    if (redirect != null) {
      return redirect(location, extra);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GuardAllowed value) allowed,
    required TResult Function(GuardBlocked value) blocked,
    required TResult Function(GuardRedirect value) redirect,
  }) {
    return redirect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GuardAllowed value)? allowed,
    TResult? Function(GuardBlocked value)? blocked,
    TResult? Function(GuardRedirect value)? redirect,
  }) {
    return redirect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GuardAllowed value)? allowed,
    TResult Function(GuardBlocked value)? blocked,
    TResult Function(GuardRedirect value)? redirect,
    required TResult orElse(),
  }) {
    if (redirect != null) {
      return redirect(this);
    }
    return orElse();
  }
}

abstract class GuardRedirect implements GuardResult {
  const factory GuardRedirect(final String location, {final Object? extra}) =
      _$GuardRedirectImpl;

  String get location;
  Object? get extra;

  /// Create a copy of GuardResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GuardRedirectImplCopyWith<_$GuardRedirectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
