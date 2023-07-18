// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatMessage _$$_ChatMessageFromJson(Map<String, dynamic> json) =>
    _$_ChatMessage(
      userProfileImage: json['userProfileImage'] as String,
      username: json['username'] as String,
      userNo: json['userNo'] as int,
      chatNo: json['chatNo'] as int,
      content: json['content'] as String,
      time: DateTime.parse(json['time'] as String),
      meetNo: json['meetNo'] as int,
    );

Map<String, dynamic> _$$_ChatMessageToJson(_$_ChatMessage instance) =>
    <String, dynamic>{
      'userProfileImage': instance.userProfileImage,
      'username': instance.username,
      'userNo': instance.userNo,
      'chatNo': instance.chatNo,
      'content': instance.content,
      'time': instance.time.toIso8601String(),
      'meetNo': instance.meetNo,
    };
