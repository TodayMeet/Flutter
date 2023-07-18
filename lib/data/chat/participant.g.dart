// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatParticipant _$$_ChatParticipantFromJson(Map<String, dynamic> json) =>
    _$_ChatParticipant(
      username: json['username'] as String,
      profileImage: json['profileImage'] as String,
      userNo: json['userNo'] as int,
      follow: json['follow'] as bool,
    );

Map<String, dynamic> _$$_ChatParticipantToJson(_$_ChatParticipant instance) =>
    <String, dynamic>{
      'username': instance.username,
      'profileImage': instance.profileImage,
      'userNo': instance.userNo,
      'follow': instance.follow,
    };
