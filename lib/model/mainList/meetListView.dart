//메인 리스트 게시판 바디 틀

// 최종 수정: 2023.6.27
// 작업자: 정해수 -> 김혁

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/dummy_meetList.dart';
import '../../data/meetList.dart';
import '../../screen/mainList/Loading_to_ListDetail.dart';
import 'mainListView.dart';
import '../TextPrint.dart';
import 'Advertisement.dart';

Widget meetListView(BuildContext context, WidgetRef ref, List<meetList> viewList) {
  return ListView(// 메인 리스트 스크롤 뷰
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    children: [
      //const SizedBox(height: 24.0,),
      //StringText('📣 주변의 새 이벤트', 24, FontWeight.w700, const Color(0xff2F3036)),
      StringText('🧭 주변 이벤트', 24, FontWeight.w700, const Color(0xff2F3036)),
      const SizedBox(height: 19.0,),

      Column(
          children: viewList.asMap().entries.map((list) {
            if(list.key % 5 == 0 && list.key != 0) { //광고 나오는 조건
              return Column(
                children: [
                  Advertisement('광고'), //광고 배너
                  ListViewer(context, ref, list.value),
                ],
              );
            }
            return ListViewer(context, ref, list.value);
          }).toList()
      ), //건수 리스트
      //StringText('🧭 주변 이벤트', 24, FontWeight.w700, const Color(0xff2F3036)),
    ],
  );
}

Widget ListViewer(BuildContext context, WidgetRef ref, meetList List) {
  return Column(
    children: [
      InkWell(
        child: mainListView(List, ref),
        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => Loading_to_ListDetail(meetNo: List.meetNo, userNo: tempUser['userNo'],)));
        }, // -> 건수 상세 페이지로 이동
      ),
      const SizedBox(height: 18,)
    ],
  );
}

Widget meetListViews(BuildContext context, WidgetRef ref, List<meetList> viewList) {
  return Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
        children: viewList.asMap().entries.map((list) {
          if(list.key % 5 == 0 && list.key != 0) { //광고 나오는 조건
            return Column(
              children: [
                Advertisement('광고'), //광고 배너
                ListViewer(context, ref, list.value),
              ],
            );
          }
          return ListViewer(context, ref, list.value);
        }).toList()
    ),
  );
}