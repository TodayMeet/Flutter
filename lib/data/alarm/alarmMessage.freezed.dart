// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarmMessage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Alarm _$AlarmFromJson(Map<String, dynamic> json) {
  return _Alarm.fromJson(json);
}

/// @nodoc
mixin _$Alarm {
  String get time => throw _privateConstructorUsedError; // 알림 시간
  int? get userNumber => throw _privateConstructorUsedError; // 사용자 번호
  int? get meetNumber => throw _privateConstructorUsedError; // 건수 번호
  String get name => throw _privateConstructorUsedError; // 출력되는 텍스트 값
  String get imageLink => throw _privateConstructorUsedError; // 알림에 뜨는 이미지
  int get notiType => throw _privateConstructorUsedError; // 알림 유형
  bool get processed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlarmCopyWith<Alarm> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmCopyWith<$Res> {
  factory $AlarmCopyWith(Alarm value, $Res Function(Alarm) then) =
      _$AlarmCopyWithImpl<$Res, Alarm>;
  @useResult
  $Res call(
      {String time,
      int? userNumber,
      int? meetNumber,
      String name,
      String imageLink,
      int notiType,
      bool processed});
}

/// @nodoc
class _$AlarmCopyWithImpl<$Res, $Val extends Alarm>
    implements $AlarmCopyWith<$Res> {
  _$AlarmCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? userNumber = freezed,
    Object? meetNumber = freezed,
    Object? name = null,
    Object? imageLink = null,
    Object? notiType = null,
    Object? processed = null,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      userNumber: freezed == userNumber
          ? _value.userNumber
          : userNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      meetNumber: freezed == meetNumber
          ? _value.meetNumber
          : meetNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageLink: null == imageLink
          ? _value.imageLink
          : imageLink // ignore: cast_nullable_to_non_nullable
              as String,
      notiType: null == notiType
          ? _value.notiType
          : notiType // ignore: cast_nullable_to_non_nullable
              as int,
      processed: null == processed
          ? _value.processed
          : processed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AlarmCopyWith<$Res> implements $AlarmCopyWith<$Res> {
  factory _$$_AlarmCopyWith(_$_Alarm value, $Res Function(_$_Alarm) then) =
      __$$_AlarmCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String time,
      int? userNumber,
      int? meetNumber,
      String name,
      String imageLink,
      int notiType,
      bool processed});
}

/// @nodoc
class __$$_AlarmCopyWithImpl<$Res> extends _$AlarmCopyWithImpl<$Res, _$_Alarm>
    implements _$$_AlarmCopyWith<$Res> {
  __$$_AlarmCopyWithImpl(_$_Alarm _value, $Res Function(_$_Alarm) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? userNumber = freezed,
    Object? meetNumber = freezed,
    Object? name = null,
    Object? imageLink = null,
    Object? notiType = null,
    Object? processed = null,
  }) {
    return _then(_$_Alarm(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      userNumber: freezed == userNumber
          ? _value.userNumber
          : userNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      meetNumber: freezed == meetNumber
          ? _value.meetNumber
          : meetNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageLink: null == imageLink
          ? _value.imageLink
          : imageLink // ignore: cast_nullable_to_non_nullable
              as String,
      notiType: null == notiType
          ? _value.notiType
          : notiType // ignore: cast_nullable_to_non_nullable
              as int,
      processed: null == processed
          ? _value.processed
          : processed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Alarm with DiagnosticableTreeMixin implements _Alarm {
  _$_Alarm(
      {required this.time,
      required this.userNumber,
      required this.meetNumber,
      required this.name,
      required this.imageLink,
      required this.notiType,
      required this.processed});

  factory _$_Alarm.fromJson(Map<String, dynamic> json) =>
      _$$_AlarmFromJson(json);

  @override
  final String time;
// 알림 시간
  @override
  final int? userNumber;
// 사용자 번호
  @override
  final int? meetNumber;
// 건수 번호
  @override
  final String name;
// 출력되는 텍스트 값
  @override
  final String imageLink;
// 알림에 뜨는 이미지
  @override
  final int notiType;
// 알림 유형
  @override
  final bool processed;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Alarm(time: $time, userNumber: $userNumber, meetNumber: $meetNumber, name: $name, imageLink: $imageLink, notiType: $notiType, processed: $processed)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Alarm'))
      ..add(DiagnosticsProperty('time', time))
      ..add(DiagnosticsProperty('userNumber', userNumber))
      ..add(DiagnosticsProperty('meetNumber', meetNumber))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('imageLink', imageLink))
      ..add(DiagnosticsProperty('notiType', notiType))
      ..add(DiagnosticsProperty('processed', processed));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Alarm &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.userNumber, userNumber) ||
                other.userNumber == userNumber) &&
            (identical(other.meetNumber, meetNumber) ||
                other.meetNumber == meetNumber) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageLink, imageLink) ||
                other.imageLink == imageLink) &&
            (identical(other.notiType, notiType) ||
                other.notiType == notiType) &&
            (identical(other.processed, processed) ||
                other.processed == processed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, time, userNumber, meetNumber,
      name, imageLink, notiType, processed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AlarmCopyWith<_$_Alarm> get copyWith =>
      __$$_AlarmCopyWithImpl<_$_Alarm>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AlarmToJson(
      this,
    );
  }
}

abstract class _Alarm implements Alarm {
  factory _Alarm(
      {required final String time,
      required final int? userNumber,
      required final int? meetNumber,
      required final String name,
      required final String imageLink,
      required final int notiType,
      required final bool processed}) = _$_Alarm;

  factory _Alarm.fromJson(Map<String, dynamic> json) = _$_Alarm.fromJson;

  @override
  String get time;
  @override // 알림 시간
  int? get userNumber;
  @override // 사용자 번호
  int? get meetNumber;
  @override // 건수 번호
  String get name;
  @override // 출력되는 텍스트 값
  String get imageLink;
  @override // 알림에 뜨는 이미지
  int get notiType;
  @override // 알림 유형
  bool get processed;
  @override
  @JsonKey(ignore: true)
  _$$_AlarmCopyWith<_$_Alarm> get copyWith =>
      throw _privateConstructorUsedError;
}
