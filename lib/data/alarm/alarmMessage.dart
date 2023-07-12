import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'alarmMessage.freezed.dart';
part 'alarmMessage.g.dart';

@freezed
class Alarm with _$Alarm{
  factory Alarm({
    required String time,
    required int? userNumber,
    required int? meetNumber,
    required String name,
    required String imageLink,
    required int notiType,
  }) = _Alarm;

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);
}