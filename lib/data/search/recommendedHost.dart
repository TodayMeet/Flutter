import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'recommendedHost.freezed.dart';
part 'recommendedHost.g.dart';

@freezed
class RecommendedHost with _$RecommendedHost{
  factory RecommendedHost({
    required String username,
    required String profileImage,
    required int userNo,
    required bool follow,
  }) = _RecommendedHost;

  factory RecommendedHost.fromJson(Map<String, dynamic> json) => _$RecommendedHostFromJson(json);
}