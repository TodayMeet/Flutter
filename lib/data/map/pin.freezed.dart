// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pin.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Pin _$PinFromJson(Map<String, dynamic> json) {
  return _Pin.fromJson(json);
}

/// @nodoc
mixin _$Pin {
  int get meetNo => throw _privateConstructorUsedError;
  String get categoryname => throw _privateConstructorUsedError;
  String get lat => throw _privateConstructorUsedError;
  String get lon => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PinCopyWith<Pin> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PinCopyWith<$Res> {
  factory $PinCopyWith(Pin value, $Res Function(Pin) then) =
      _$PinCopyWithImpl<$Res, Pin>;
  @useResult
  $Res call(
      {int meetNo, String categoryname, String lat, String lon, DateTime time});
}

/// @nodoc
class _$PinCopyWithImpl<$Res, $Val extends Pin> implements $PinCopyWith<$Res> {
  _$PinCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetNo = null,
    Object? categoryname = null,
    Object? lat = null,
    Object? lon = null,
    Object? time = null,
  }) {
    return _then(_value.copyWith(
      meetNo: null == meetNo
          ? _value.meetNo
          : meetNo // ignore: cast_nullable_to_non_nullable
              as int,
      categoryname: null == categoryname
          ? _value.categoryname
          : categoryname // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PinCopyWith<$Res> implements $PinCopyWith<$Res> {
  factory _$$_PinCopyWith(_$_Pin value, $Res Function(_$_Pin) then) =
      __$$_PinCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int meetNo, String categoryname, String lat, String lon, DateTime time});
}

/// @nodoc
class __$$_PinCopyWithImpl<$Res> extends _$PinCopyWithImpl<$Res, _$_Pin>
    implements _$$_PinCopyWith<$Res> {
  __$$_PinCopyWithImpl(_$_Pin _value, $Res Function(_$_Pin) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetNo = null,
    Object? categoryname = null,
    Object? lat = null,
    Object? lon = null,
    Object? time = null,
  }) {
    return _then(_$_Pin(
      meetNo: null == meetNo
          ? _value.meetNo
          : meetNo // ignore: cast_nullable_to_non_nullable
              as int,
      categoryname: null == categoryname
          ? _value.categoryname
          : categoryname // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Pin with DiagnosticableTreeMixin implements _Pin {
  _$_Pin(
      {required this.meetNo,
      required this.categoryname,
      required this.lat,
      required this.lon,
      required this.time});

  factory _$_Pin.fromJson(Map<String, dynamic> json) => _$$_PinFromJson(json);

  @override
  final int meetNo;
  @override
  final String categoryname;
  @override
  final String lat;
  @override
  final String lon;
  @override
  final DateTime time;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Pin(meetNo: $meetNo, categoryname: $categoryname, lat: $lat, lon: $lon, time: $time)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Pin'))
      ..add(DiagnosticsProperty('meetNo', meetNo))
      ..add(DiagnosticsProperty('categoryname', categoryname))
      ..add(DiagnosticsProperty('lat', lat))
      ..add(DiagnosticsProperty('lon', lon))
      ..add(DiagnosticsProperty('time', time));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Pin &&
            (identical(other.meetNo, meetNo) || other.meetNo == meetNo) &&
            (identical(other.categoryname, categoryname) ||
                other.categoryname == categoryname) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, meetNo, categoryname, lat, lon, time);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PinCopyWith<_$_Pin> get copyWith =>
      __$$_PinCopyWithImpl<_$_Pin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PinToJson(
      this,
    );
  }
}

abstract class _Pin implements Pin {
  factory _Pin(
      {required final int meetNo,
      required final String categoryname,
      required final String lat,
      required final String lon,
      required final DateTime time}) = _$_Pin;

  factory _Pin.fromJson(Map<String, dynamic> json) = _$_Pin.fromJson;

  @override
  int get meetNo;
  @override
  String get categoryname;
  @override
  String get lat;
  @override
  String get lon;
  @override
  DateTime get time;
  @override
  @JsonKey(ignore: true)
  _$$_PinCopyWith<_$_Pin> get copyWith => throw _privateConstructorUsedError;
}
