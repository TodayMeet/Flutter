import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address{
  factory Address({
    required String address_name,
    required String lat,
    required String lon,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}