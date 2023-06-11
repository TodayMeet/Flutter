// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
mixin _$Comment {
  int get meetCommentNo => throw _privateConstructorUsedError;
  int get meetNo => throw _privateConstructorUsedError;
  dynamic get parentNo => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get userNo => throw _privateConstructorUsedError;
  dynamic get userProfileImage => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  DateTime get createDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res, Comment>;
  @useResult
  $Res call(
      {int meetCommentNo,
      int meetNo,
      dynamic parentNo,
      String content,
      int userNo,
      dynamic userProfileImage,
      String username,
      DateTime createDate});
}

/// @nodoc
class _$CommentCopyWithImpl<$Res, $Val extends Comment>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetCommentNo = null,
    Object? meetNo = null,
    Object? parentNo = freezed,
    Object? content = null,
    Object? userNo = null,
    Object? userProfileImage = freezed,
    Object? username = null,
    Object? createDate = null,
  }) {
    return _then(_value.copyWith(
      meetCommentNo: null == meetCommentNo
          ? _value.meetCommentNo
          : meetCommentNo // ignore: cast_nullable_to_non_nullable
              as int,
      meetNo: null == meetNo
          ? _value.meetNo
          : meetNo // ignore: cast_nullable_to_non_nullable
              as int,
      parentNo: freezed == parentNo
          ? _value.parentNo
          : parentNo // ignore: cast_nullable_to_non_nullable
              as dynamic,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
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
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CommentCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$_CommentCopyWith(
          _$_Comment value, $Res Function(_$_Comment) then) =
      __$$_CommentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int meetCommentNo,
      int meetNo,
      dynamic parentNo,
      String content,
      int userNo,
      dynamic userProfileImage,
      String username,
      DateTime createDate});
}

/// @nodoc
class __$$_CommentCopyWithImpl<$Res>
    extends _$CommentCopyWithImpl<$Res, _$_Comment>
    implements _$$_CommentCopyWith<$Res> {
  __$$_CommentCopyWithImpl(_$_Comment _value, $Res Function(_$_Comment) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetCommentNo = null,
    Object? meetNo = null,
    Object? parentNo = freezed,
    Object? content = null,
    Object? userNo = null,
    Object? userProfileImage = freezed,
    Object? username = null,
    Object? createDate = null,
  }) {
    return _then(_$_Comment(
      meetCommentNo: null == meetCommentNo
          ? _value.meetCommentNo
          : meetCommentNo // ignore: cast_nullable_to_non_nullable
              as int,
      meetNo: null == meetNo
          ? _value.meetNo
          : meetNo // ignore: cast_nullable_to_non_nullable
              as int,
      parentNo: freezed == parentNo
          ? _value.parentNo
          : parentNo // ignore: cast_nullable_to_non_nullable
              as dynamic,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
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
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Comment implements _Comment {
  _$_Comment(
      {required this.meetCommentNo,
      required this.meetNo,
      required this.parentNo,
      required this.content,
      required this.userNo,
      required this.userProfileImage,
      required this.username,
      required this.createDate});

  factory _$_Comment.fromJson(Map<String, dynamic> json) =>
      _$$_CommentFromJson(json);

  @override
  final int meetCommentNo;
  @override
  final int meetNo;
  @override
  final dynamic parentNo;
  @override
  final String content;
  @override
  final int userNo;
  @override
  final dynamic userProfileImage;
  @override
  final String username;
  @override
  final DateTime createDate;

  @override
  String toString() {
    return 'Comment(meetCommentNo: $meetCommentNo, meetNo: $meetNo, parentNo: $parentNo, content: $content, userNo: $userNo, userProfileImage: $userProfileImage, username: $username, createDate: $createDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Comment &&
            (identical(other.meetCommentNo, meetCommentNo) ||
                other.meetCommentNo == meetCommentNo) &&
            (identical(other.meetNo, meetNo) || other.meetNo == meetNo) &&
            const DeepCollectionEquality().equals(other.parentNo, parentNo) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.userNo, userNo) || other.userNo == userNo) &&
            const DeepCollectionEquality()
                .equals(other.userProfileImage, userProfileImage) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      meetCommentNo,
      meetNo,
      const DeepCollectionEquality().hash(parentNo),
      content,
      userNo,
      const DeepCollectionEquality().hash(userProfileImage),
      username,
      createDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CommentCopyWith<_$_Comment> get copyWith =>
      __$$_CommentCopyWithImpl<_$_Comment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommentToJson(
      this,
    );
  }
}

abstract class _Comment implements Comment {
  factory _Comment(
      {required final int meetCommentNo,
      required final int meetNo,
      required final dynamic parentNo,
      required final String content,
      required final int userNo,
      required final dynamic userProfileImage,
      required final String username,
      required final DateTime createDate}) = _$_Comment;

  factory _Comment.fromJson(Map<String, dynamic> json) = _$_Comment.fromJson;

  @override
  int get meetCommentNo;
  @override
  int get meetNo;
  @override
  dynamic get parentNo;
  @override
  String get content;
  @override
  int get userNo;
  @override
  dynamic get userProfileImage;
  @override
  String get username;
  @override
  DateTime get createDate;
  @override
  @JsonKey(ignore: true)
  _$$_CommentCopyWith<_$_Comment> get copyWith =>
      throw _privateConstructorUsedError;
}
