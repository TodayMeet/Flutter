// 메인 리스트에서 보여지는 약식 정보 뷰어

// 최종 수정: 2023.5.9
// 작업자: 정해수

//추가 작업 예정 사항:
// 프로필 연결
// 댓글창 연결
// 사진 출력 여부

import 'package:flutter/material.dart';
import 'ListDetail.dart';
import 'package:front/data/meetList.dart';
import 'package:front/model/mainList/CategoryContainer.dart';
import 'package:front/model/TextPrint.dart';

class mainListView extends StatelessWidget { //건수 리스트 게시판 뷰
  final String category; //모임 카테고리
  final String title; //모임 제목
  final int month; // 모집 달
  final int date; //모집 일
  final int hour; // 마감 시
  final int minute; //마감 분
  final int meetNo;
  final int userNo;
  //호스트 프로필 이미지
  final String hostName; //호스트 이름
  final String address; //모임 장소 주소
  //모임 사진
  final int commentNum; //댓글 수
  final int userLimit; //모집 인원 수
  final String location; //모임 장소
  final int curUserNum; //현재 인원 수

  const mainListView({Key? key, required this.category, required this.title,
    required this.month, required this.date, required this.hour,
    required this.minute, required this.meetNo, required this.userNo,
    required this.hostName, required this.address, required this.commentNum,
    required this.userLimit, required this.location, required this.curUserNum}) : super(key: key);

  mainListView.list(meetList list) : this(category: list.category, title: list.title,
    month: list.month, date: list.date, hour: list.hour, minute: list.minute,
    meetNo: list.meetNo, userNo: list.userNo, hostName: list.hostName, address: list.address,
    commentNum: list.commentNum, userLimit: list.userLimit, location: list.location, curUserNum: list.curUserNum);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18), 
        height: 400,
        decoration: BoxDecoration( //컨테이너 테두리 조절
          color: Color(0xffF7F8FA),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Color(0xffF7F8FA), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18), // 컨테이너 내부 공백 조절
          child: Column( //컨테이너 내부 컬럼 정렬
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryContainer(category,),
                    Row(
                      children: [
                        StringText('모집 마감 시간: ', 12, 'PretendardRegular', Colors.black),
                        IntText(hour, 12, 'PretendardRegular', Colors.black),
                        StringText(':', 12, 'PretendardRegular', Colors.black),
                        TimeText(minute, 12, 'PretendardRegular', Colors.black),
                      ],
                    )
                  ],
                ), //카테고리, 마감시간

                const SizedBox(height: 12,),
                Row(
                  children: [
                    StringText(title, 18, 'PretendardBold', const Color(0xff2F3036))
                  ],
                ), //제목

                const SizedBox(height: 10,),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(SnackBar(content: Text('미구현 기능입니다 (사용자 프로필 페이지)')));
                      }, //프로필 페이지로 이동
                      child: Row(
                        children: [
                          Image.asset('assets/images/User_Picture/User_pic_null.png',
                              width: 26, height: 26),  //사용자 사진
                          const SizedBox(width: 10,),
                          StringText(hostName, 12, 'PretendardRegular', Colors.black)
                        ],
                      ),
                    )
                  ],
                ), //사용자 사진, 이름 -> 사용자 프로필 이동

                const SizedBox(height: 10,),
                Row(
                  children: [
                    StringText(address, 13, 'PretendardBold', const Color(0xff949596)), //동네 이름
                    StringText(' ', 13, 'PretendardBold', const Color(0xff949596)),
                    IntText(month, 13, 'PretendardBold', const Color(0xff949596)),
                    StringText('-', 13, 'PretendardBold', const Color(0xff949596)),
                    IntText(date, 13, 'PretendardBold', const Color(0xff949596)), // 모임 날짜
                    StringText(' ', 13, 'PretendardBold', const Color(0xff949596)),
                    StringText(' | ', 13, 'PretendardBold', const Color(0xff949596)),
                    IntText(hour, 13, 'PretendardBold', const Color(0xff949596)),
                    StringText(':', 13, 'PretendardBold', const Color(0xff949596)),
                    TimeText(minute, 13, 'PretendardBold', const Color(0xff949596)), //모임 시각
                  ],
                ), //동네, 날짜, 시간

                const SizedBox(height: 18,),
                Row(
                  children: [
                    Image.asset('assets/images/List_Image/List_image_sample1.png',
                        width: 100, height: 100),  //건수 등록 이미지
                    const SizedBox(width: 2,),
                    Image.asset('assets/images/List_Image/List_image_sample2.png',
                        width: 100, height: 100),
                  ],
                ), //등록 이미지

                const SizedBox(height: 18,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Image.asset('assets/images/User_Picture/User_pic_sample3.png',
                              width: 26, height: 26),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Image.asset('assets/images/User_Picture/User_pic_sample2.png',
                              width: 26, height: 26),
                        ),
                        Image.asset('assets/images/User_Picture/User_pic_sample1.png',
                            width: 26, height: 26),
                      ],
                    )
                  ],
                ), //참여중인 사용자 사진

                const SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(content: Text('미구현 기능입니다 (댓글창 페이지)')));
                        }, //댓글창 페이지로 이동
                        child: Container(
                          width: 65,
                          height: 30,
                          decoration: BoxDecoration( //컨테이너 테두리 조절
                            color: Color(0xffEBECF0),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Color(0xffEBECF0), width: 1),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 14,),
                              Image.asset('assets/images/List_Icon/List_icon_comments.png',
                                  width: 16, height: 16), //댓글 아이콘
                              const SizedBox(width: 6,),
                              IntText(commentNum, 12, 'PretendardBold', const Color(0xffA4A4A7)),
                            ],
                          ),
                        )
                    ), //댓글창
                    Container(
                      width: 76,
                      height: 30,
                      decoration: BoxDecoration( //컨테이너 테두리 조절
                        color: const Color(0xffEBECF0),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xffEBECF0), width: 1),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 14,),
                          Image.asset('assets/images/List_Icon/List_icon_user.png',
                              width: 16, height: 16), //댓글 아이콘
                          const SizedBox(width: 6,),
                          IntText(curUserNum, 12, 'PretendardBold', const Color(0xffA4A4A7)),//현재 인원수
                          StringText('/', 12, 'PretendardBold', const Color(0xffA4A4A7)),
                          IntText(userLimit, 12, 'PretendardBold', const Color(0xffA4A4A7)),//최대 인원수
                        ],
                      ),
                    )
                  ],
                ), //댓글 -> 댓글창으로 이동, 인원수
              ]
          ),
        ),
      ),
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => ListDetail()));
      }, // -> 건수 상세 페이지로 이동
    );
  }
}