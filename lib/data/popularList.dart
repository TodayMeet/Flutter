import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'popularList.freezed.dart';
part 'popularList.g.dart';

@freezed
class PopularList with _$PopularList {
  factory PopularList({
    required String name,
    required int count,
  }) = _PopularList;

  factory PopularList.fromJson(Map<String, dynamic> json) => _$PopularListFromJson(json);
}