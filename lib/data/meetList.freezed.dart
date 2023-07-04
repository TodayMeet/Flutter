// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meetList.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

meetList _$meetListFromJson(Map<String, dynamic> json) {
  return _meetList.fromJson(json);
}

/// @nodoc
mixin _$meetList {
  String get categoryName => throw _privateConstructorUsedError; //모임 카테고리
  DateTime get time => throw _privateConstructorUsedError; //모집 일자, 시간
  String get title => throw _privateConstructorUsedError; //모임 제목
  int get meetNo => throw _privateConstructorUsedError;
  int get userNo => throw _privateConstructorUsedError;
  dynamic get userProfileImage => throw _privateConstructorUsedError; //유저 아이콘
  String get username => throw _privateConstructorUsedError; //유저 이름
  dynamic get lat => throw _privateConstructorUsedError; //위도
  dynamic get lon => throw _privateConstructorUsedError; //경도
  List<String> get meetImage => throw _privateConstructorUsedError; //모임 이미지
  int get commentNum => throw _privateConstructorUsedError; //댓글 수
  int get peopleLimit => throw _privateConstructorUsedError; //모집 인원 수
  int get peopleNum => throw _privateConstructorUsedError; //현재 인원 수
  String get address => throw _privateConstructorUsedError; //주소
  bool get peopleClosed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $meetListCopyWith<meetList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $meetListCopyWith<$Res> {
  factory $meetListCopyWith(meetList value, $Res Function(meetList) then) =
      _$meetListCopyWithImpl<$Res, meetList>;
  @useResult
  $Res call(
      {String categoryName,
      DateTime time,
      String title,
      int meetNo,
      int userNo,
      dynamic userProfileImage,
      String username,
      dynamic lat,
      dynamic lon,
      List<String> meetImage,
      int commentNum,
      int peopleLimit,
      int peopleNum,
      String address,
      bool peopleClosed});
}

/// @nodoc
class _$meetListCopyWithImpl<$Res, $Val extends meetList>
    implements $meetListCopyWith<$Res> {
  _$meetListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryName = null,
    Object? time = null,
    Object? title = null,
    Object? meetNo = null,
    Object? userNo = null,
    Object? userProfileImage = freezed,
    Object? username = null,
    Object? lat = freezed,
    Object? lon = freezed,
    Object? meetImage = null,
    Object? commentNum = null,
    Object? peopleLimit = null,
    Object? peopleNum = null,
    Object? address = null,
    Object? peopleClosed = null,
  }) {
    return _then(_value.copyWith(
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      meetNo: null == meetNo
          ? _value.meetNo
          : meetNo // ignore: cast_nullable_to_non_nullable
              as int,
      userNo: null == userNo
          ? _value.userNo
          : userNo // ignore: cast_nullable_to_non_nullable
              as int,
      userProfileImage: freezed == userProfileImage
          ? _value.userProfileImage
          : userProfileImage // ignore: cast_nullable_to_non_nullable
              as dynamic,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as dynamic,
      lon: freezed == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as dynamic,
      meetImage: null == meetImage
          ? _value.meetImage
          : meetImage // ignore: cast_nullable_to_non_nullable
              as List<String>,
      commentNum: null == commentNum
          ? _value.commentNum
          : commentNum // ignore: cast_nullable_to_non_nullable
              as int,
      peopleLimit: null == peopleLimit
          ? _value.peopleLimit
          : peopleLimit // ignore: cast_nullable_to_non_nullable
              as int,
      peopleNum: null == peopleNum
          ? _value.peopleNum
          : peopleNum // ignore: cast_nullable_to_non_nullable
              as int,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      peopleClosed: null == peopleClosed
          ? _value.peopleClosed
          : peopleClosed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_meetListCopyWith<$Res> implements $meetListCopyWith<$Res> {
  factory _$$_meetListCopyWith(
          _$_meetList value, $Res Function(_$_meetList) then) =
      __$$_meetListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String categoryName,
      DateTime time,
      String title,
      int meetNo,
      int userNo,
      dynamic userProfileImage,
      String username,
      dynamic lat,
      dynamic lon,
      List<String> meetImage,
      int commentNum,
      int peopleLimit,
      int peopleNum,
      String address,
      bool peopleClosed});
}

/// @nodoc
class __$$_meetListCopyWithImpl<$Res>
    extends _$meetListCopyWithImpl<$Res, _$_meetList>
    implements _$$_meetListCopyWith<$Res> {
  __$$_meetListCopyWithImpl(
      _$_meetList _value, $Res Function(_$_meetList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryName = null,
    Object? time = null,
    Object? title = null,
    Object? meetNo = null,
    Object? userNo = null,
    Object? userProfileImage = freezed,
    Object? username = null,
    Object? lat = freezed,
    Object? lon = freezed,
    Object? meetImage = null,
    Object? commentNum = null,
    Object? peopleLimit = null,
    Object? peopleNum = null,
    Object? address = null,
    Object? peopleClosed = null,
  }) {
    return _then(_$_meetList(
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      meetNo: null == meetNo
          ? _value.meetNo
          : meetNo // ignore: cast_nullable_to_non_nullable
              as int,
      userNo: null == userNo
          ? _value.userNo
          : userNo // ignore: cast_nullable_to_non_nullable
              as int,
      userProfileImage: freezed == userProfileImage
          ? _value.userProfileImage
          : userProfileImage // ignore: cast_nullable_to_non_nullable
              as dynamic,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as dynamic,
      lon: freezed == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as dynamic,
      meetImage: null == meetImage
          ? _value._meetImage
          : meetImage // ignore: cast_nullable_to_non_nullable
              as List<String>,
      commentNum: null == commentNum
          ? _value.commentNum
          : commentNum // ignore: cast_nullable_to_non_nullable
              as int,
      peopleLimit: null == peopleLimit
          ? _value.peopleLimit
          : peopleLimit // ignore: cast_nullable_to_non_nullable
              as int,
      peopleNum: null == peopleNum
          ? _value.peopleNum
          : peopleNum // ignore: cast_nullable_to_non_nullable
              as int,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      peopleClosed: null == peopleClosed
          ? _value.peopleClosed
          : peopleClosed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_meetList implements _meetList {
  _$_meetList(
      {required this.categoryName,
      required this.time,
      required this.title,
      required this.meetNo,
      required this.userNo,
      required this.userProfileImage,
      required this.username,
      required this.lat,
      required this.lon,
      required final List<String> meetImage,
      required this.commentNum,
      required this.peopleLimit,
      required this.peopleNum,
      required this.address,
      required this.peopleClosed})
      : _meetImage = meetImage;

  factory _$_meetList.fromJson(Map<String, dynamic> json) =>
      _$$_meetListFromJson(json);

  @override
  final String categoryName;
//모임 카테고리
  @override
  final DateTime time;
//모집 일자, 시간
  @override
  final String title;
//모임 제목
  @override
  final int meetNo;
  @override
  final int userNo;
  @override
  final dynamic userProfileImage;
//유저 아이콘
  @override
  final String username;
//유저 이름
  @override
  final dynamic lat;
//위도
  @override
  final dynamic lon;
//경도
  final List<String> _meetImage;
//경도
  @override
  List<String> get meetImage {
    if (_meetImage is EqualUnmodifiableListView) return _meetImage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_meetImage);
  }

//모임 이미지
  @override
  final int commentNum;
//댓글 수
  @override
  final int peopleLimit;
//모집 인원 수
  @override
  final int peopleNum;
//현재 인원 수
  @override
  final String address;
//주소
  @override
  final bool peopleClosed;

  @override
  String toString() {
    return 'meetList(categoryName: $categoryName, time: $time, title: $title, meetNo: $meetNo, userNo: $userNo, userProfileImage: $userProfileImage, username: $username, lat: $lat, lon: $lon, meetImage: $meetImage, commentNum: $commentNum, peopleLimit: $peopleLimit, peopleNum: $peopleNum, address: $address, peopleClosed: $peopleClosed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_meetList &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.meetNo, meetNo) || other.meetNo == meetNo) &&
            (identical(other.userNo, userNo) || other.userNo == userNo) &&
            const DeepCollectionEquality()
                .equals(other.userProfileImage, userProfileImage) &&
            (identical(other.username, username) ||
                other.username == username) &&
            const DeepCollectionEquality().equals(other.lat, lat) &&
            const DeepCollectionEquality().equals(other.lon, lon) &&
            const DeepCollectionEquality()
                .equals(other._meetImage, _meetImage) &&
            (identical(other.commentNum, commentNum) ||
                other.commentNum == commentNum) &&
            (identical(other.peopleLimit, peopleLimit) ||
                other.peopleLimit == peopleLimit) &&
            (identical(other.peopleNum, peopleNum) ||
                other.peopleNum == peopleNum) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.peopleClosed, peopleClosed) ||
                other.peopleClosed == peopleClosed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      categoryName,
      time,
      title,
      meetNo,
      userNo,
      const DeepCollectionEquality().hash(userProfileImage),
      username,
      const DeepCollectionEquality().hash(lat),
      const DeepCollectionEquality().hash(lon),
      const DeepCollectionEquality().hash(_meetImage),
      commentNum,
      peopleLimit,
      peopleNum,
      address,
      peopleClosed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_meetListCopyWith<_$_meetList> get copyWith =>
      __$$_meetListCopyWithImpl<_$_meetList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_meetListToJson(
      this,
    );
  }
}

abstract class _meetList implements meetList {
  factory _meetList(
      {required final String categoryName,
      required final DateTime time,
      required final String title,
      required final int meetNo,
      required final int userNo,
      required final dynamic userProfileImage,
      required final String username,
      required final dynamic lat,
      required final dynamic lon,
      required final List<String> meetImage,
      required final int commentNum,
      required final int peopleLimit,
      required final int peopleNum,
      required final String address,
      required final bool peopleClosed}) = _$_meetList;

  factory _meetList.fromJson(Map<String, dynamic> json) = _$_meetList.fromJson;

  @override
  String get categoryName;
  @override //모임 카테고리
  DateTime get time;
  @override //모집 일자, 시간
  String get title;
  @override //모임 제목
  int get meetNo;
  @override
  int get userNo;
  @override
  dynamic get userProfileImage;
  @override //유저 아이콘
  String get username;
  @override //유저 이름
  dynamic get lat;
  @override //위도
  dynamic get lon;
  @override //경도
  List<String> get meetImage;
  @override //모임 이미지
  int get commentNum;
  @override //댓글 수
  int get peopleLimit;
  @override //모집 인원 수
  int get peopleNum;
  @override //현재 인원 수
  String get address;
  @override //주소
  bool get peopleClosed;
  @override
  @JsonKey(ignore: true)
  _$$_meetListCopyWith<_$_meetList> get copyWith =>
      throw _privateConstructorUsedError;
}
