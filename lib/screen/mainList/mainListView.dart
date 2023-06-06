// 메인 리스트에서 보여지는 약식 정보 뷰어

// 최종 수정: 2023.6.2
// 작업자: 정해수

//추가 작업 예정 사항:
// 프로필 연결
// 댓글창 연결
// 사진 출력 여부

import 'package:flutter/material.dart';
import 'package:front/data/meetList.dart';
import 'package:front/model/mainList/CategoryContainer.dart';
import 'package:front/model/TextPrint.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

Widget mainListView(meetList list, WidgetRef ref) {
  final completeContainerProvider = Provider((ref) {
    if(list.peopleClosed /*|| list.timeClosed*/) { // 인원수 마감 or 시간 마감
      return Container(
        width: 33,
        height: 20,
        decoration: BoxDecoration(
          color: const Color(0xffD0D1D8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: StringText('완료', 9, 'PretendardBold', Colors.white),
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
      border: Border.all(color: const Color(0xffF7F8FA), width: 1),
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
                    const SizedBox(width: 6,),
                    completeContainer
                  ],
                ),
                Row(
                  children: [
                    StringText('모집 마감 시간: ', 12, 'PretendardRegular', Colors.black),
                    IntText(DateFormat('HH').format(list.time), 12, 'PretendardRegular', Colors.black),
                    StringText(':', 12, 'PretendardRegular', Colors.black),
                    IntText(DateFormat('mm').format(list.time), 12, 'PretendardRegular', Colors.black),
                  ],
                )
              ],
            ), //카테고리, 마감시간

            const SizedBox(height: 12,),
            Row(
              children: [
                StringText(list.title, 18, 'PretendardBold', const Color(0xff2F3036))
              ],
            ), //제목

            const SizedBox(height: 10,),
            Row(
              children: [
                InkWell(
                  onTap: (){}, //프로필 페이지로 이동
                  child: Row(
                    children: [
                      Image.asset('assets/images/User_Picture/User_pic_null.png',
                          width: 26, height: 26),  //사용자 사진
                      const SizedBox(width: 10,),
                      StringText(list.username, 12, 'PretendardRegular', Colors.black)
                    ],
                  ),
                )
              ],
            ), //사용자 사진, 이름 -> 사용자 프로필 이동

            const SizedBox(height: 10,),
            Row(
              children: [
                StringText(list.address, 13, 'PretendardBold', const Color(0xff949596)), //동네 이름
                StringText(' ', 13, 'PretendardBold', const Color(0xff949596)),
                IntText(DateFormat('MM').format(list.time), 13, 'PretendardBold', const Color(0xff949596)),
                StringText('-', 13, 'PretendardBold', const Color(0xff949596)),
                IntText(DateFormat('dd').format(list.time), 13, 'PretendardBold', const Color(0xff949596)), // 모임 날짜
                StringText(' ', 13, 'PretendardBold', const Color(0xff949596)),
                StringText(' | ', 13, 'PretendardBold', const Color(0xff949596)),
                IntText(DateFormat('hh').format(list.time), 13, 'PretendardBold', const Color(0xff949596)),
                StringText(':', 13, 'PretendardBold', const Color(0xff949596)),
                IntText(DateFormat('mm').format(list.time), 13, 'PretendardBold', const Color(0xff949596)), //모임 시각
              ],
            ), //동네, 날짜, 시간
            const SizedBox(height: 18,),
            Row(
              children: [
                Image.asset('assets/images/List_Image/List_image_sample1.png',
                    fit: BoxFit.fitHeight,
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
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Image.asset('assets/images/User_Picture/User_pic_sample3.png',
                          width: 26, height: 26),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                    onTap: () {}, //댓글창 페이지로 이동
                    child: Container(
                      width: 65,
                      height: 30,
                      decoration: BoxDecoration( //컨테이너 테두리 조절
                        color: const Color(0xffEBECF0),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xffEBECF0), width: 1),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 14,),
                          Image.asset('assets/images/List_Icon/List_icon_comments.png',
                              width: 16, height: 16), //댓글 아이콘
                          const SizedBox(width: 6,),
                          IntText(list.commentNum, 12, 'PretendardBold', const Color(0xffA4A4A7)),
                        ],
                      ),
                    )
                ), //댓글창
                Container(
                  width: 76,
                  height: 30,
                  decoration: BoxDecoration( //컨테이너 테두리 조절
                    color: const Color(0xffEBECF0),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xffEBECF0), width: 1),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 14,),
                      Image.asset('assets/images/List_Icon/List_icon_user.png',
                          width: 16, height: 16), //댓글 아이콘
                      const SizedBox(width: 6,),
                      IntText(list.peopleNum, 12, 'PretendardBold', const Color(0xffA4A4A7)),//현재 인원수
                      StringText('/', 12, 'PretendardBold', const Color(0xffA4A4A7)),
                      IntText(list.peopleLimit, 12, 'PretendardBold', const Color(0xffA4A4A7)),//최대 인원수
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