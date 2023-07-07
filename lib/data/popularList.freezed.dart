// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'popularList.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PopularList _$PopularListFromJson(Map<String, dynamic> json) {
  return _PopularList.fromJson(json);
}

/// @nodoc
mixin _$PopularList {
  String get name => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PopularListCopyWith<PopularList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PopularListCopyWith<$Res> {
  factory $PopularListCopyWith(
          PopularList value, $Res Function(PopularList) then) =
      _$PopularListCopyWithImpl<$Res, PopularList>;
  @useResult
  $Res call({String name, int count});
}

/// @nodoc
class _$PopularListCopyWithImpl<$Res, $Val extends PopularList>
    implements $PopularListCopyWith<$Res> {
  _$PopularListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PopularListCopyWith<$Res>
    implements $PopularListCopyWith<$Res> {
  factory _$$_PopularListCopyWith(
          _$_PopularList value, $Res Function(_$_PopularList) then) =
      __$$_PopularListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int count});
}

/// @nodoc
class __$$_PopularListCopyWithImpl<$Res>
    extends _$PopularListCopyWithImpl<$Res, _$_PopularList>
    implements _$$_PopularListCopyWith<$Res> {
  __$$_PopularListCopyWithImpl(
      _$_PopularList _value, $Res Function(_$_PopularList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? count = null,
  }) {
    return _then(_$_PopularList(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PopularList with DiagnosticableTreeMixin implements _PopularList {
  _$_PopularList({required this.name, required this.count});

  factory _$_PopularList.fromJson(Map<String, dynamic> json) =>
      _$$_PopularListFromJson(json);

  @override
  final String name;
  @override
  final int count;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PopularList(name: $name, count: $count)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PopularList'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('count', count));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PopularList &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PopularListCopyWith<_$_PopularList> get copyWith =>
      __$$_PopularListCopyWithImpl<_$_PopularList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PopularListToJson(
      this,
    );
  }
}

abstract class _PopularList implements PopularList {
  factory _PopularList({required final String name, required final int count}) =
      _$_PopularList;

  factory _PopularList.fromJson(Map<String, dynamic> json) =
      _$_PopularList.fromJson;

  @override
  String get name;
  @override
  int get count;
  @override
  @JsonKey(ignore: true)
  _$$_PopularListCopyWith<_$_PopularList> get copyWith =>
      throw _privateConstructorUsedError;
}
