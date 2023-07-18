// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chatMessage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  String get userProfileImage => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  int get userNo => throw _privateConstructorUsedError;
  int get chatNo => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  int get meetNo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
          ChatMessage value, $Res Function(ChatMessage) then) =
      _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call(
      {String userProfileImage,
      String username,
      int userNo,
      int chatNo,
      String content,
      DateTime time,
      int meetNo});
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userProfileImage = null,
    Object? username = null,
    Object? userNo = null,
    Object? chatNo = null,
    Object? content = null,
    Object? time = null,
    Object? meetNo = null,
  }) {
    return _then(_value.copyWith(
      userProfileImage: null == userProfileImage
          ? _value.userProfileImage
          : userProfileImage // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      userNo: null == userNo
          ? _value.userNo
          : userNo // ignore: cast_nullable_to_non_nullable
              as int,
      chatNo: null == chatNo
          ? _value.chatNo
          : chatNo // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      meetNo: null == meetNo
          ? _value.meetNo
          : meetNo // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatMessageCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$_ChatMessageCopyWith(
          _$_ChatMessage value, $Res Function(_$_ChatMessage) then) =
      __$$_ChatMessageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userProfileImage,
      String username,
      int userNo,
      int chatNo,
      String content,
      DateTime time,
      int meetNo});
}

/// @nodoc
class __$$_ChatMessageCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$_ChatMessage>
    implements _$$_ChatMessageCopyWith<$Res> {
  __$$_ChatMessageCopyWithImpl(
      _$_ChatMessage _value, $Res Function(_$_ChatMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userProfileImage = null,
    Object? username = null,
    Object? userNo = null,
    Object? chatNo = null,
    Object? content = null,
    Object? time = null,
    Object? meetNo = null,
  }) {
    return _then(_$_ChatMessage(
      userProfileImage: null == userProfileImage
          ? _value.userProfileImage
          : userProfileImage // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      userNo: null == userNo
          ? _value.userNo
          : userNo // ignore: cast_nullable_to_non_nullable
              as int,
      chatNo: null == chatNo
          ? _value.chatNo
          : chatNo // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      meetNo: null == meetNo
          ? _value.meetNo
          : meetNo // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatMessage with DiagnosticableTreeMixin implements _ChatMessage {
  _$_ChatMessage(
      {required this.userProfileImage,
      required this.username,
      required this.userNo,
      required this.chatNo,
      required this.content,
      required this.time,
      required this.meetNo});

  factory _$_ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$$_ChatMessageFromJson(json);

  @override
  final String userProfileImage;
  @override
  final String username;
  @override
  final int userNo;
  @override
  final int chatNo;
  @override
  final String content;
  @override
  final DateTime time;
  @override
  final int meetNo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatMessage(userProfileImage: $userProfileImage, username: $username, userNo: $userNo, chatNo: $chatNo, content: $content, time: $time, meetNo: $meetNo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatMessage'))
      ..add(DiagnosticsProperty('userProfileImage', userProfileImage))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('userNo', userNo))
      ..add(DiagnosticsProperty('chatNo', chatNo))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('time', time))
      ..add(DiagnosticsProperty('meetNo', meetNo));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatMessage &&
            (identical(other.userProfileImage, userProfileImage) ||
                other.userProfileImage == userProfileImage) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.userNo, userNo) || other.userNo == userNo) &&
            (identical(other.chatNo, chatNo) || other.chatNo == chatNo) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.meetNo, meetNo) || other.meetNo == meetNo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userProfileImage, username,
      userNo, chatNo, content, time, meetNo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatMessageCopyWith<_$_ChatMessage> get copyWith =>
      __$$_ChatMessageCopyWithImpl<_$_ChatMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatMessageToJson(
      this,
    );
  }
}

abstract class _ChatMessage implements ChatMessage {
  factory _ChatMessage(
      {required final String userProfileImage,
      required final String username,
      required final int userNo,
      required final int chatNo,
      required final String content,
      required final DateTime time,
      required final int meetNo}) = _$_ChatMessage;

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$_ChatMessage.fromJson;

  @override
  String get userProfileImage;
  @override
  String get username;
  @override
  int get userNo;
  @override
  int get chatNo;
  @override
  String get content;
  @override
  DateTime get time;
  @override
  int get meetNo;
  @override
  @JsonKey(ignore: true)
  _$$_ChatMessageCopyWith<_$_ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
