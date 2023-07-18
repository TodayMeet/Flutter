// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommendedHost.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RecommendedHost _$RecommendedHostFromJson(Map<String, dynamic> json) {
  return _RecommendedHost.fromJson(json);
}

/// @nodoc
mixin _$RecommendedHost {
  String get username => throw _privateConstructorUsedError;
  String get profileImage => throw _privateConstructorUsedError;
  int get userNo => throw _privateConstructorUsedError;
  bool get follow => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecommendedHostCopyWith<RecommendedHost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendedHostCopyWith<$Res> {
  factory $RecommendedHostCopyWith(
          RecommendedHost value, $Res Function(RecommendedHost) then) =
      _$RecommendedHostCopyWithImpl<$Res, RecommendedHost>;
  @useResult
  $Res call({String username, String profileImage, int userNo, bool follow});
}

/// @nodoc
class _$RecommendedHostCopyWithImpl<$Res, $Val extends RecommendedHost>
    implements $RecommendedHostCopyWith<$Res> {
  _$RecommendedHostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? profileImage = null,
    Object? userNo = null,
    Object? follow = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String,
      userNo: null == userNo
          ? _value.userNo
          : userNo // ignore: cast_nullable_to_non_nullable
              as int,
      follow: null == follow
          ? _value.follow
          : follow // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecommendedHostCopyWith<$Res>
    implements $RecommendedHostCopyWith<$Res> {
  factory _$$_RecommendedHostCopyWith(
          _$_RecommendedHost value, $Res Function(_$_RecommendedHost) then) =
      __$$_RecommendedHostCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String username, String profileImage, int userNo, bool follow});
}

/// @nodoc
class __$$_RecommendedHostCopyWithImpl<$Res>
    extends _$RecommendedHostCopyWithImpl<$Res, _$_RecommendedHost>
    implements _$$_RecommendedHostCopyWith<$Res> {
  __$$_RecommendedHostCopyWithImpl(
      _$_RecommendedHost _value, $Res Function(_$_RecommendedHost) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? profileImage = null,
    Object? userNo = null,
    Object? follow = null,
  }) {
    return _then(_$_RecommendedHost(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String,
      userNo: null == userNo
          ? _value.userNo
          : userNo // ignore: cast_nullable_to_non_nullable
              as int,
      follow: null == follow
          ? _value.follow
          : follow // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RecommendedHost
    with DiagnosticableTreeMixin
    implements _RecommendedHost {
  _$_RecommendedHost(
      {required this.username,
      required this.profileImage,
      required this.userNo,
      required this.follow});

  factory _$_RecommendedHost.fromJson(Map<String, dynamic> json) =>
      _$$_RecommendedHostFromJson(json);

  @override
  final String username;
  @override
  final String profileImage;
  @override
  final int userNo;
  @override
  final bool follow;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RecommendedHost(username: $username, profileImage: $profileImage, userNo: $userNo, follow: $follow)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RecommendedHost'))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('profileImage', profileImage))
      ..add(DiagnosticsProperty('userNo', userNo))
      ..add(DiagnosticsProperty('follow', follow));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecommendedHost &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.userNo, userNo) || other.userNo == userNo) &&
            (identical(other.follow, follow) || other.follow == follow));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, username, profileImage, userNo, follow);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecommendedHostCopyWith<_$_RecommendedHost> get copyWith =>
      __$$_RecommendedHostCopyWithImpl<_$_RecommendedHost>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecommendedHostToJson(
      this,
    );
  }
}

abstract class _RecommendedHost implements RecommendedHost {
  factory _RecommendedHost(
      {required final String username,
      required final String profileImage,
      required final int userNo,
      required final bool follow}) = _$_RecommendedHost;

  factory _RecommendedHost.fromJson(Map<String, dynamic> json) =
      _$_RecommendedHost.fromJson;

  @override
  String get username;
  @override
  String get profileImage;
  @override
  int get userNo;
  @override
  bool get follow;
  @override
  @JsonKey(ignore: true)
  _$$_RecommendedHostCopyWith<_$_RecommendedHost> get copyWith =>
      throw _privateConstructorUsedError;
}
