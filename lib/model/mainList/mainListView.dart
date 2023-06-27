// 메인 리스트에서 보여지는 약식 정보 뷰어

// 최종 수정: 2023.6.26
// 작업자: 정해수 -> 김혁

//추가 작업 예정 사항:
// 프로필 연결
// 댓글창 연결
// 사진 출력 여부

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:front/data/meetList.dart';
import 'package:front/model/mainList/CategoryContainer.dart';
import 'package:front/model/TextPrint.dart';

Widget mainListView(meetList list, WidgetRef ref) {
  // 카테고리 표시 옆에 완료 텍스트
  final completeContainerProvider = Provider((ref) {
    if(list.peopleClosed /*|| list.timeClosed*/) { // 인원수 마감 or 시간 마감
      return Container(
        width: 33,
        height: 20,
        decoration: BoxDecoration(
          color: const Color(0xffD0D1D8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: StringText_letterspacing('완료', 10, FontWeight.w700, Colors.white, -0.5),
        ),
      );
    }else {
      return const SizedBox(width: 33,);
    }
  });
  final Widget completeContainer = ref.watch(completeContainerProvider);

  return Container(
    decoration: BoxDecoration( //컨테이너 테두리 조절
      color: const Color(0xffF7F8FA),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(18), // 컨테이너 내부 공백 조절
      child: Column( //컨테이너 내부 컬럼 정렬
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    categoryContainer(list.categoryName,),
                    const SizedBox(width: 6),
                    completeContainer
                  ],
                ),
                Row(
                  children: [
                    StringText_letterspacing('모집 마감 시간: ', 12, FontWeight.w400, Colors.black, -0.5),
                    StringText_letterspacing(DateFormat('HH:mm').format(list.time), 12, FontWeight.w400, Colors.black, -0.5),
                    /*StringText_letterspacing(':', 12, FontWeight.w400, Colors.black, -0.5),
                    StringText_letterspacing(DateFormat('mm').format(list.time), 12, FontWeight.w400, Colors.black, -0.5),*/
                  ],
                )
              ],
            ), //카테고리, 마감시간

            const SizedBox(height: 12,),
            Row(
              children: [
                StringText(list.title, 18, FontWeight.w700, const Color(0xff2F3036))
              ],
            ), //제목

            const SizedBox(height: 10,),
            Row(
              children: [
                InkWell(
                  onTap: (){}, //프로필 페이지로 이동
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.asset('assets/images/User_Picture/User_pic_null.png',
                            width: 26, height: 26),
                      ),  //사용자 사진
                      const SizedBox(width: 10,),
                      StringText_letterspacing(list.username, 12, FontWeight.w400, Colors.black, -0.5)
                    ],
                  ),
                )
              ],
            ), //사용자 사진, 이름 -> 사용자 프로필 이동

            const SizedBox(height: 10,),
            Row(
              children: [
                StringText(list.address, 13, FontWeight.w700, const Color(0xff949596)), //동네 이름
                StringText(' ', 13, FontWeight.w700, const Color(0xff949596)),
                StringText(DateFormat('MM-dd | hh:mm').format(list.time), 13, FontWeight.w700, const Color(0xff949596)),
                /*StringText('-', 13, FontWeight.w700, const Color(0xff949596)),
                StringText(DateFormat('dd').format(list.time), 13, FontWeight.w700, const Color(0xff949596)), // 모임 날짜
                StringText(' ', 13, FontWeight.w700, const Color(0xff949596)),
                StringText(' | ', 13, FontWeight.w700, const Color(0xff949596)),
                StringText(DateFormat('hh').format(list.time), 13, FontWeight.w700, const Color(0xff949596)),
                StringText(':', 13, FontWeight.w700, const Color(0xff949596)),
                StringText(DateFormat('mm').format(list.time), 13, FontWeight.w700, const Color(0xff949596)), //모임 시각*/
              ],
            ), //동네, 날짜, 시간
            const SizedBox(height: 18),
            Row(
              children: [
                Container(
                  width: 86,
                  height: 86,
                  color: const Color(0xffF0F1F5),
                  child: const Center(child: Text('(모임 사진 1)'),),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 86,
                  height: 86,
                  color: const Color(0xffF0F1F5),
                  child: const Center(child: Text('(모임 사진 2)'),),
                ),
              ],
            ), //건수 등록 이미지

            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                curUserIcon(list.peopleNum)
              ],
            ), //참여중인 사용자 사진

            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {}, //댓글창 페이지로 이동
                    child: Container(
                      width: 65,
                      height: 30,
                      decoration: BoxDecoration( //컨테이너 테두리 조절
                        color: const Color(0xffEBECF0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 14,),
                          Image.asset('assets/images/List_Icon/List_icon_comments.png',
                              width: 16, height: 16), //댓글 아이콘
                          const SizedBox(width: 6,),
                          IntText_letterspacing(list.commentNum, 12, FontWeight.w700, const Color(0xffA4A4A7), -0.5),
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
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 14,),
                      Image.asset('assets/images/List_Icon/List_icon_user.png',
                          width: 16, height: 16), //댓글 아이콘
                      const SizedBox(width: 6,),
                      //IntText(list.peopleNum, 12, FontWeight.w700, const Color(0xffA4A4A7)),//현재 인원수
                      StringText_letterspacing(
                          '${list.peopleNum} / ${list.peopleLimit}', 12, FontWeight.w700, const Color(0xffA4A4A7), -0.5), // 현재 인원수 / 최대 인원수
                      //IntText(list.peopleLimit, 12, FontWeight.w700, const Color(0xffA4A4A7)),//최대 인원수
                    ],
                  ),
                )
              ],
            ), //댓글 -> 댓글창으로 이동, 인원수
          ]
      ),
    ),
  );
}

Widget curUserIcon(int num) {
  if(num == 1) {
    return Stack(
        children: [
          ClipOval(
            child: Image.asset('assets/images/User_Picture/User_pic_null.png',
                width: 26, height: 26),
          ),
        ]
    );
  } else if(num == 2) {
    return Stack(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: ClipOval(
              child: Image.asset('assets/images/User_Picture/User_pic_null.png',
                  width: 26, height: 26),
            ),
          ),
          ClipOval(
            child: Image.asset('assets/images/User_Picture/User_pic_null.png',
                width: 26, height: 26),
          )
        ]
    );
  } else {
    return Stack(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
            child: ClipOval(
              child: Image.asset('assets/images/User_Picture/User_pic_null.png',
                  width: 26, height: 26),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: ClipOval(
              child: Image.asset('assets/images/User_Picture/User_pic_null.png',
                  width: 26, height: 26),
            ),
          ),
          ClipOval(
            child: Image.asset('assets/images/User_Picture/User_pic_null.png',
                width: 26, height: 26),
          ),
        ]
    );
  }
}