// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_meet _$$_meetFromJson(Map<String, dynamic> json) => _$_meet(
      meetNo: json['meetNo'] as int,
      categoryName: json['categoryName'] as String,
      time: DateTime.parse(json['time'] as String),
      title: json['title'] as String,
      userNo: json['userNo'] as int,
      userProfileImage: json['userProfileImage'],
      username: json['username'] as String,
      address: json['address'] as String,
      meetImage:
          (json['meetImage'] as List<dynamic>).map((e) => e as String).toList(),
      commentNum: json['commentNum'] as int,
      peopleLimit: json['peopleLimit'] as int,
      peopleNum: json['peopleNum'] as int,
      lat: json['lat'] as String,
      lon: json['lon'] as String,
      personClosed: json['personClosed'] as bool,
      fee: json['fee'] as int,
      content: json['content'] as String,
      approval: json['approval'] as bool,
      timeClosed: json['timeClosed'] as bool,
      hostUser: json['hostUser'] as Map<String, dynamic>,
      comments: (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      userList: (json['userList'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      isInsert: json['isInsert'] as bool,
      age: json['age'] as String,
    );

Map<String, dynamic> _$$_meetToJson(_$_meet instance) => <String, dynamic>{
      'meetNo': instance.meetNo,
      'categoryName': instance.categoryName,
      'time': instance.time.toIso8601String(),
      'title': instance.title,
      'userNo': instance.userNo,
      'userProfileImage': instance.userProfileImage,
      'username': instance.username,
      'address': instance.address,
      'meetImage': instance.meetImage,
      'commentNum': instance.commentNum,
      'peopleLimit': instance.peopleLimit,
      'peopleNum': instance.peopleNum,
      'lat': instance.lat,
      'lon': instance.lon,
      'personClosed': instance.personClosed,
      'fee': instance.fee,
      'content': instance.content,
      'approval': instance.approval,
      'timeClosed': instance.timeClosed,
      'hostUser': instance.hostUser,
      'comments': instance.comments,
      'userList': instance.userList,
      'isInsert': instance.isInsert,
      'age': instance.age,
    };
