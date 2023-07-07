// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Pin _$$_PinFromJson(Map<String, dynamic> json) => _$_Pin(
      meetNo: json['meetNo'] as int,
      categoryname: json['categoryname'] as String,
      lat: json['lat'] as String,
      lon: json['lon'] as String,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$$_PinToJson(_$_Pin instance) => <String, dynamic>{
      'meetNo': instance.meetNo,
      'categoryname': instance.categoryname,
      'lat': instance.lat,
      'lon': instance.lon,
      'time': instance.time.toIso8601String(),
    };
