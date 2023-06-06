// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_meetList _$$_meetListFromJson(Map<String, dynamic> json) => _$_meetList(
      categoryName: json['categoryName'] as String,
      time: DateTime.parse(json['time'] as String),
      title: json['title'] as String,
      meetNo: json['meetNo'] as int,
      userNo: json['userNo'] as int,
      userProfileImage: json['userProfileImage'] as String,
      username: json['username'] as String,
      lat: (json['lat'] as num).toDouble(),
      meetImage: json['meetImage'] as String,
      commentNum: json['commentNum'] as int,
      peopleLimit: json['peopleLimit'] as int,
      peopleNum: json['peopleNum'] as int,
      address: json['address'] as String,
      personClosed: json['personClosed'] as bool,
    );

Map<String, dynamic> _$$_meetListToJson(_$_meetList instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'time': instance.time.toIso8601String(),
      'title': instance.title,
      'meetNo': instance.meetNo,
      'userNo': instance.userNo,
      'userProfileImage': instance.userProfileImage,
      'username': instance.username,
      'lat': instance.lat,
      'meetImage': instance.meetImage,
      'commentNum': instance.commentNum,
      'peopleLimit': instance.peopleLimit,
      'peopleNum': instance.peopleNum,
      'address': instance.address,
      'personClosed': instance.personClosed,
    };
