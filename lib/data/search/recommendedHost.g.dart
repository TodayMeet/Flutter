// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendedHost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RecommendedHost _$$_RecommendedHostFromJson(Map<String, dynamic> json) =>
    _$_RecommendedHost(
      username: json['username'] as String,
      profileImage: json['profileImage'] as String,
      userNo: json['userNo'] as int,
      follow: json['follow'] as bool,
    );

Map<String, dynamic> _$$_RecommendedHostToJson(_$_RecommendedHost instance) =>
    <String, dynamic>{
      'username': instance.username,
      'profileImage': instance.profileImage,
      'userNo': instance.userNo,
      'follow': instance.follow,
    };
