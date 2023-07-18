import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'participant.freezed.dart';
part 'participant.g.dart';

@freezed
class ChatParticipant with _$ChatParticipant{
  factory ChatParticipant({
    required String username,
    required String profileImage,
    required int userNo,
    required bool follow,
  }) = _ChatParticipant;

  factory ChatParticipant.fromJson(Map<String, dynamic> json) => _$ChatParticipantFromJson(json);
}