import 'package:freezed_annotation/freezed_annotation.dart';

part 'meetList.freezed.dart';
part 'meetList.g.dart';

@freezed
class meetList with _$meetList{

  factory meetList({
    required String categoryName, //모임 카테고리
    required DateTime time, //모집 일자, 시간
    required String title, //모임 제목
    required int meetNo,
    required int userNo,
    required dynamic userProfileImage, //유저 아이콘
    required String username, //유저 이름
    required dynamic lat, //위도
    required dynamic lon, //경도
    required List<String> meetImage, //모임 이미지
    required int commentNum, //댓글 수
    required int peopleLimit, //모집 인원 수
    required int peopleNum, //현재 인원 수
    required String address, //주소
    required List<Map> participantUserImage, //참가자 리스트
    required bool peopleClosed, //모집 완료 여부
  }) = _meetList;

  factory meetList.fromJson(Map<String, dynamic> json) => _$meetListFromJson(json);
}