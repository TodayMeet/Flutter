// 건수 상세 정보 클래스

// 최종 수정: 2023.5.9
// 작업자: 정해수

//추가 작업 예정 사항:
//db 연결 고려

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meetList.freezed.dart';

@freezed
class meetList with _$meetList{

  factory meetList({
    //키 값
    required int userNo,
    required int meetNo,

    // 호스트 정보 (사용자 프로필 클래스 필요)
    required String hostName, //호스트 이름
    //호스트 사진
    required int hostAge, //호스트 나이

    //모임 등록 정보
    required String category, //모임 카테고리
    required String location, //모임 장소
    required String address, //모임 장소 주소
    required int year, //모집 년
    required int month, // 모집 달
    required int date, //모집 일
    required int hour, // 마감 시
    required int minute, //마감 분
    required bool age, //모집 나이
    required  int userLimit, //모집 인원 수
    required int fee, //참가비
    required String title, //모임 제목
    required String content, //모임 내용
    required bool approval, // 자동 승인 여부
    //모임 사진

    //모임 현재 정보
    required bool complete, //모집 완료 여부
    required int commentNum, //댓글 수
    required int curUserNum, //현재 모집된 인원 수
  }) = _meetList;

  // //키 값
  // int userNo;
  // int meetNo;
  //
  // // 호스트 정보 (사용자 프로필 클래스 필요)
  // String hostName; //호스트 이름
  // //호스트 사진
  // int hostAge; //호스트 나이
  //
  // //모임 등록 정보
  // String category; //모임 카테고리
  // String location; //모임 장소
  // String address; //모임 장소 주소
  // int year; //모집 년
  // int month; // 모집 달
  // int date; //모집 일
  // int hour; // 마감 시
  // int minute; //마감 분
  // bool age; //모집 나이
  // int userLimit; //모집 인원 수
  // int fee; //참가비
  // String title; //모임 제목
  // String content; //모임 내용
  // bool approval; // 자동 승인 여부
  // //모임 사진
  //
  // //모임 현재 정보
  // bool complete; //모집 완료 여부
  // int commentNum; //댓글 수
  // final int curUserNum; //현재 모집된 인원 수


  // meetList(this.userNo, this.meetNo, this.hostName, this.hostAge, this.category, this.location, this.address,
  //     this.year, this.month, this.date, this.hour, this.minute, this.age,
  //     this.userLimit, this.fee, this.title, this.content, this.approval,
  //     this.complete, this.commentNum, this.curUserNum);

}

class curUserNumNotifier extends StateNotifier<int> {
  curUserNumNotifier(): super(test0.curUserNum);
}

final curUserNumProvider = StateNotifierProvider<curUserNumNotifier, int>((ref) {
  return curUserNumNotifier();
});

//List 클래스 더미 객체
meetList test0 = meetList(userNo: 10, meetNo: 0, hostName: '호스트0', hostAge: 25, category: '주류',
    location: '대구광역시 북구 90', address: '산격동', year: 2023, month: 5, date: 16, hour: 19,
    minute: 00, age: true, userLimit: 8, fee: 20000, title: '오늘 같이 놀 사람!', content: '오늘 같이 한잔 하실 분 구해요~!',
    approval: true, complete: false, commentNum: 0, curUserNum: 1);

meetList test1 = meetList(userNo: 11, meetNo: 1, hostName: '호스트1', hostAge: 24, category: '스터디',
    location: '부산광역시 남구 21-3', address: '용호동', year: 2023, month: 5, date: 23, hour: 14,
    minute: 30, age: true, userLimit: 4, fee: 10000, title: '스터디 모임 모집합니다', content: '스터디 내용',
    approval: true, complete: false, commentNum: 0, curUserNum: 1);

meetList test2 = meetList(userNo: 12, meetNo: 2, hostName: '호스트2', hostAge: 23, category: '운동',
    location: '대구광역시 달서구 17-1', address: '월성동', year: 2023, month: 7, date: 15, hour: 15,
    minute: 00, age: true, userLimit: 12, fee: 15000, title: '오늘 운동 알차게 할 헬창 급구', content: '운동 내용',
    approval: true, complete: false, commentNum: 0, curUserNum: 1);

meetList test3 = meetList(userNo: 13, meetNo: 3, hostName: '호스트3', hostAge: 26, category: '맛집',
    location: '울산광역시 서구 212-4', address: '강서동', year: 2023, month: 3, date: 7, hour: 16,
    minute: 30, age: true, userLimit: 6, fee: 25000, title: '꿀꿀할 땐 막창 국룰', content: '맛집 내용',
    approval: true, complete: false, commentNum: 0, curUserNum: 1);