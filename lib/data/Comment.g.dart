// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      meetCommentNo: json['meetCommentNo'] as int,
      meetNo: json['meetNo'] as int,
      parentNo: json['parentNo'],
      content: json['content'] as String,
      userNo: json['userNo'] as int,
      userProfileImage: json['userProfileImage'],
      username: json['username'] as String,
      createDate: DateTime.parse(json['createDate'] as String),
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'meetCommentNo': instance.meetCommentNo,
      'meetNo': instance.meetNo,
      'parentNo': instance.parentNo,
      'content': instance.content,
      'userNo': instance.userNo,
      'userProfileImage': instance.userProfileImage,
      'username': instance.username,
      'createDate': instance.createDate.toIso8601String(),
    };
