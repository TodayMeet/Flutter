// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

meet _$meetFromJson(Map<String, dynamic> json) {
  return _meet.fromJson(json);
}

/// @nodoc
mixin _$meet {
  int get meetNo => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError; //모임 카테고리
  DateTime get time => throw _privateConstructorUsedError; //모집 일자, 시간
  String get title => throw _privateConstructorUsedError; //모임 제목
  int get userNo => throw _privateConstructorUsedError;
  dynamic get userProfileImage => throw _privateConstructorUsedError; //유저 아이콘
  String get username => throw _privateConstructorUsedError; //유저 이름
  String get address => throw _privateConstructorUsedError; //주소
  dynamic get meetImage => throw _privateConstructorUsedError; //모임 이미지
  int get commentNum => throw _privateConstructorUsedError; //댓글 수
  int get peopleLimit => throw _privateConstructorUsedError; //모집 인원 수
  int get peopleNum => throw _privateConstructorUsedError; //현재 인원 수
  dynamic get lat => throw _privateConstructorUsedError; //위도
  dynamic get lon => throw _privateConstructorUsedError; //경도
  bool get personClosed => throw _privateConstructorUsedError; //모집 완료 여부
  int get fee => throw _privateConstructorUsedError; //참가비
  String get content => throw _privateConstructorUsedError; //모임 내용
  bool get approval => throw _privateConstructorUsedError; // 자동 승인 여부
  bool get timeClosed => throw _privateConstructorUsedError; //마감 시간
  Map<dynamic, dynamic> get hostUser =>
      throw _privateConstructorUsedError; //주최자 정보
  List<Map> get comments => throw _privateConstructorUsedError; //댓글 정보
  List<Map> get userList => throw _privateConstructorUsedError; //참가자 리스트
  String get age => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $meetCopyWith<meet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $meetCopyWith<$Res> {
  factory $meetCopyWith(meet value, $Res Function(meet) then) =
      _$meetCopyWithImpl<$Res, meet>;
  @useResult
  $Res call(
      {int meetNo,
      String categoryName,
      DateTime time,
      String title,
      int userNo,
      dynamic userProfileImage,
      String username,
      String address,
      dynamic meetImage,
      int commentNum,
      int peopleLimit,
      int peopleNum,
      dynamic lat,
      dynamic lon,
      bool personClosed,
      int fee,
      String content,
      bool approval,
      bool timeClosed,
      Map<dynamic, dynamic> hostUser,
      List<Map> comments,
      List<Map> userList,
      String age});
}

/// @nodoc
class _$meetCopyWithImpl<$Res, $Val extends meet>
    implements $meetCopyWith<$Res> {
  _$meetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetNo = null,
    Object? categoryName = null,
    Object? time = null,
    Object? title = null,
    Object? userNo = null,
    Object? userProfileImage = freezed,
    Object? username = null,
    Object? address = null,
    Object? meetImage = freezed,
    Object? commentNum = null,
    Object? peopleLimit = null,
    Object? peopleNum = null,
    Object? lat = freezed,
    Object? lon = freezed,
    Object? personClosed = null,
    Object? fee = null,
    Object? content = null,
    Object? approval = null,
    Object? timeClosed = null,
    Object? hostUser = null,
    Object? comments = null,
    Object? userList = null,
    Object? age = null,
  }) {
    return _then(_value.copyWith(
      meetNo: null == meetNo
          ? _value.meetNo
          : meetNo // ignore: cast_nullable_to_non_nullable
              as int,
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
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      meetImage: freezed == meetImage
          ? _value.meetImage
          : meetImage // ignore: cast_nullable_to_non_nullable
              as dynamic,
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
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as dynamic,
      lon: freezed == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as dynamic,
      personClosed: null == personClosed
          ? _value.personClosed
          : personClosed // ignore: cast_nullable_to_non_nullable
              as bool,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      approval: null == approval
          ? _value.approval
          : approval // ignore: cast_nullable_to_non_nullable
              as bool,
      timeClosed: null == timeClosed
          ? _value.timeClosed
          : timeClosed // ignore: cast_nullable_to_non_nullable
              as bool,
      hostUser: null == hostUser
          ? _value.hostUser
          : hostUser // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Map>,
      userList: null == userList
          ? _value.userList
          : userList // ignore: cast_nullable_to_non_nullable
              as List<Map>,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_meetCopyWith<$Res> implements $meetCopyWith<$Res> {
  factory _$$_meetCopyWith(_$_meet value, $Res Function(_$_meet) then) =
      __$$_meetCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int meetNo,
      String categoryName,
      DateTime time,
      String title,
      int userNo,
      dynamic userProfileImage,
      String username,
      String address,
      dynamic meetImage,
      int commentNum,
      int peopleLimit,
      int peopleNum,
      dynamic lat,
      dynamic lon,
      bool personClosed,
      int fee,
      String content,
      bool approval,
      bool timeClosed,
      Map<dynamic, dynamic> hostUser,
      List<Map> comments,
      List<Map> userList,
      String age});
}

/// @nodoc
class __$$_meetCopyWithImpl<$Res> extends _$meetCopyWithImpl<$Res, _$_meet>
    implements _$$_meetCopyWith<$Res> {
  __$$_meetCopyWithImpl(_$_meet _value, $Res Function(_$_meet) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetNo = null,
    Object? categoryName = null,
    Object? time = null,
    Object? title = null,
    Object? userNo = null,
    Object? userProfileImage = freezed,
    Object? username = null,
    Object? address = null,
    Object? meetImage = freezed,
    Object? commentNum = null,
    Object? peopleLimit = null,
    Object? peopleNum = null,
    Object? lat = freezed,
    Object? lon = freezed,
    Object? personClosed = null,
    Object? fee = null,
    Object? content = null,
    Object? approval = null,
    Object? timeClosed = null,
    Object? hostUser = null,
    Object? comments = null,
    Object? userList = null,
    Object? age = null,
  }) {
    return _then(_$_meet(
      meetNo: null == meetNo
          ? _value.meetNo
          : meetNo // ignore: cast_nullable_to_non_nullable
              as int,
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
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      meetImage: freezed == meetImage
          ? _value.meetImage
          : meetImage // ignore: cast_nullable_to_non_nullable
              as dynamic,
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
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as dynamic,
      lon: freezed == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as dynamic,
      personClosed: null == personClosed
          ? _value.personClosed
          : personClosed // ignore: cast_nullable_to_non_nullable
              as bool,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      approval: null == approval
          ? _value.approval
          : approval // ignore: cast_nullable_to_non_nullable
              as bool,
      timeClosed: null == timeClosed
          ? _value.timeClosed
          : timeClosed // ignore: cast_nullable_to_non_nullable
              as bool,
      hostUser: null == hostUser
          ? _value._hostUser
          : hostUser // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
      comments: null == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Map>,
      userList: null == userList
          ? _value._userList
          : userList // ignore: cast_nullable_to_non_nullable
              as List<Map>,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_meet implements _meet {
  _$_meet(
      {required this.meetNo,
      required this.categoryName,
      required this.time,
      required this.title,
      required this.userNo,
      required this.userProfileImage,
      required this.username,
      required this.address,
      required this.meetImage,
      required this.commentNum,
      required this.peopleLimit,
      required this.peopleNum,
      required this.lat,
      required this.lon,
      required this.personClosed,
      required this.fee,
      required this.content,
      required this.approval,
      required this.timeClosed,
      required final Map<dynamic, dynamic> hostUser,
      required final List<Map> comments,
      required final List<Map> userList,
      required this.age})
      : _hostUser = hostUser,
        _comments = comments,
        _userList = userList;

  factory _$_meet.fromJson(Map<String, dynamic> json) => _$$_meetFromJson(json);

  @override
  final int meetNo;
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
  final int userNo;
  @override
  final dynamic userProfileImage;
//유저 아이콘
  @override
  final String username;
//유저 이름
  @override
  final String address;
//주소
  @override
  final dynamic meetImage;
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
  final dynamic lat;
//위도
  @override
  final dynamic lon;
//경도
  @override
  final bool personClosed;
//모집 완료 여부
  @override
  final int fee;
//참가비
  @override
  final String content;
//모임 내용
  @override
  final bool approval;
// 자동 승인 여부
  @override
  final bool timeClosed;
//마감 시간
  final Map<dynamic, dynamic> _hostUser;
//마감 시간
  @override
  Map<dynamic, dynamic> get hostUser {
    if (_hostUser is EqualUnmodifiableMapView) return _hostUser;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_hostUser);
  }

//주최자 정보
  final List<Map> _comments;
//주최자 정보
  @override
  List<Map> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

//댓글 정보
  final List<Map> _userList;
//댓글 정보
  @override
  List<Map> get userList {
    if (_userList is EqualUnmodifiableListView) return _userList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userList);
  }

//참가자 리스트
  @override
  final String age;

  @override
  String toString() {
    return 'meet(meetNo: $meetNo, categoryName: $categoryName, time: $time, title: $title, userNo: $userNo, userProfileImage: $userProfileImage, username: $username, address: $address, meetImage: $meetImage, commentNum: $commentNum, peopleLimit: $peopleLimit, peopleNum: $peopleNum, lat: $lat, lon: $lon, personClosed: $personClosed, fee: $fee, content: $content, approval: $approval, timeClosed: $timeClosed, hostUser: $hostUser, comments: $comments, userList: $userList, age: $age)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_meet &&
            (identical(other.meetNo, meetNo) || other.meetNo == meetNo) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.userNo, userNo) || other.userNo == userNo) &&
            const DeepCollectionEquality()
                .equals(other.userProfileImage, userProfileImage) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality().equals(other.meetImage, meetImage) &&
            (identical(other.commentNum, commentNum) ||
                other.commentNum == commentNum) &&
            (identical(other.peopleLimit, peopleLimit) ||
                other.peopleLimit == peopleLimit) &&
            (identical(other.peopleNum, peopleNum) ||
                other.peopleNum == peopleNum) &&
            const DeepCollectionEquality().equals(other.lat, lat) &&
            const DeepCollectionEquality().equals(other.lon, lon) &&
            (identical(other.personClosed, personClosed) ||
                other.personClosed == personClosed) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.approval, approval) ||
                other.approval == approval) &&
            (identical(other.timeClosed, timeClosed) ||
                other.timeClosed == timeClosed) &&
            const DeepCollectionEquality().equals(other._hostUser, _hostUser) &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            const DeepCollectionEquality().equals(other._userList, _userList) &&
            (identical(other.age, age) || other.age == age));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        meetNo,
        categoryName,
        time,
        title,
        userNo,
        const DeepCollectionEquality().hash(userProfileImage),
        username,
        address,
        const DeepCollectionEquality().hash(meetImage),
        commentNum,
        peopleLimit,
        peopleNum,
        const DeepCollectionEquality().hash(lat),
        const DeepCollectionEquality().hash(lon),
        personClosed,
        fee,
        content,
        approval,
        timeClosed,
        const DeepCollectionEquality().hash(_hostUser),
        const DeepCollectionEquality().hash(_comments),
        const DeepCollectionEquality().hash(_userList),
        age
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_meetCopyWith<_$_meet> get copyWith =>
      __$$_meetCopyWithImpl<_$_meet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_meetToJson(
      this,
    );
  }
}

abstract class _meet implements meet {
  factory _meet(
      {required final int meetNo,
      required final String categoryName,
      required final DateTime time,
      required final String title,
      required final int userNo,
      required final dynamic userProfileImage,
      required final String username,
      required final String address,
      required final dynamic meetImage,
      required final int commentNum,
      required final int peopleLimit,
      required final int peopleNum,
      required final dynamic lat,
      required final dynamic lon,
      required final bool personClosed,
      required final int fee,
      required final String content,
      required final bool approval,
      required final bool timeClosed,
      required final Map<dynamic, dynamic> hostUser,
      required final List<Map> comments,
      required final List<Map> userList,
      required final String age}) = _$_meet;

  factory _meet.fromJson(Map<String, dynamic> json) = _$_meet.fromJson;

  @override
  int get meetNo;
  @override
  String get categoryName;
  @override //모임 카테고리
  DateTime get time;
  @override //모집 일자, 시간
  String get title;
  @override //모임 제목
  int get userNo;
  @override
  dynamic get userProfileImage;
  @override //유저 아이콘
  String get username;
  @override //유저 이름
  String get address;
  @override //주소
  dynamic get meetImage;
  @override //모임 이미지
  int get commentNum;
  @override //댓글 수
  int get peopleLimit;
  @override //모집 인원 수
  int get peopleNum;
  @override //현재 인원 수
  dynamic get lat;
  @override //위도
  dynamic get lon;
  @override //경도
  bool get personClosed;
  @override //모집 완료 여부
  int get fee;
  @override //참가비
  String get content;
  @override //모임 내용
  bool get approval;
  @override // 자동 승인 여부
  bool get timeClosed;
  @override //마감 시간
  Map<dynamic, dynamic> get hostUser;
  @override //주최자 정보
  List<Map> get comments;
  @override //댓글 정보
  List<Map> get userList;
  @override //참가자 리스트
  String get age;
  @override
  @JsonKey(ignore: true)
  _$$_meetCopyWith<_$_meet> get copyWith => throw _privateConstructorUsedError;
}
