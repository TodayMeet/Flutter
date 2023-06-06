import 'package:freezed_annotation/freezed_annotation.dart';

part 'meet.freezed.dart';
part 'meet.g.dart';

@freezed
class meet with _$meet{

  factory meet({
    required int meetNo,
    required String categoryName, //모임 카테고리
    required DateTime time, //모집 일자, 시간
    required String title, //모임 제목
    required int userNo,
    required dynamic userProfileImage, //유저 아이콘
    required String username, //유저 이름
    required String address, //주소
    required dynamic meetImage, //모임 이미지
    required int commentNum, //댓글 수
    required int peopleLimit, //모집 인원 수
    required int peopleNum, //현재 인원 수
    required dynamic lat, //위도
    required dynamic lon, //경도
    required bool personClosed, //모집 완료 여부
    required int fee, //참가비
    required String content, //모임 내용
    required bool approval, // 자동 승인 여부
    required bool timeClosed, //마감 시간
    required Map hostUser, //주최자 정보
    required List<Map> comments, //댓글 정보
    required List<Map> userList, //참가자 리스트
    required bool isInsert, //유저 참가 여부
    required String age, //나이 제한

  }) = _meet;

  factory meet.fromJson(Map<String, dynamic> json) => _$meetFromJson(json);
}