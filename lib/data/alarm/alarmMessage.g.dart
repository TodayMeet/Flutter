// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarmMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Alarm _$$_AlarmFromJson(Map<String, dynamic> json) => _$_Alarm(
      time: json['time'] as String,
      userNumber: json['userNumber'] as int?,
      meetNumber: json['meetNumber'] as int?,
      name: json['name'] as String,
      imageLink: json['imageLink'] as String,
      notiType: json['notiType'] as int,
      processed: json['processed'] as bool,
    );

Map<String, dynamic> _$$_AlarmToJson(_$_Alarm instance) => <String, dynamic>{
      'time': instance.time,
      'userNumber': instance.userNumber,
      'meetNumber': instance.meetNumber,
      'name': instance.name,
      'imageLink': instance.imageLink,
      'notiType': instance.notiType,
      'processed': instance.processed,
    };
