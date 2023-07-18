import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'chatMessage.freezed.dart';
part 'chatMessage.g.dart';

@freezed
class ChatMessage with _$ChatMessage{
  factory ChatMessage({
    required String userProfileImage,
    required String username,
    required int userNo,
    required int chatNo,
    required String content,
    required DateTime time,
    required int meetNo,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);
}