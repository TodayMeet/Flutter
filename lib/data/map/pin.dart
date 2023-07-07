import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'pin.freezed.dart';
part 'pin.g.dart';

@freezed
class Pin with _$Pin{
  factory Pin({
    required int meetNo,
    required String categoryname,
    required String lat,
    required String lon,
    required DateTime time,
  }) = _Pin;

  factory Pin.fromJson(Map<String, dynamic> json) => _$PinFromJson(json);
}