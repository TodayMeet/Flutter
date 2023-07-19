import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'alarmMessage.freezed.dart';
part 'alarmMessage.g.dart';

@freezed
class Alarm with _$Alarm{
  factory Alarm({
    required String time, // 알림 시간
    required int? userNumber, // 사용자 번호
    required int? meetNumber, // 건수 번호
    required String name, // 출력되는 텍스트 값
    required String imageLink,// 알림에 뜨는 이미지
    required int notiType,  // 알림 유형
    required bool processed,// 처리된 알림인지
  }) = _Alarm;

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);
}