import 'package:freezed_annotation/freezed_annotation.dart';

part 'Comment.freezed.dart';
part 'Comment.g.dart';

@freezed
class Comment with _$Comment{

  factory Comment({
    required int meetCommentNo,
    required int meetNo,
    required dynamic parentNo,
    required String content,
    required int userNo,
    required dynamic userProfileImage,
    required String username,
    required DateTime createDate
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}

//flutter pub run build_runner build