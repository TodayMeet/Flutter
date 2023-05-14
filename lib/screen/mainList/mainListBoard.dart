//메인 리스트 게시판

// 최종 수정: 2023.5.9
// 작업자: 정해수

//추가 작업 예정 사항:
// 주변 이벤트 vs 주변의 새 이벤트
// 리스트 정렬 순서
// 리스트 필터 화면 이동 아이콘
// 지도 화면 이동 아이콘
// 현재 위치 설정
// 하단 고정 바

import 'package:flutter/material.dart';
import 'package:front/model/TextPrint.dart';
import '../setting/setFilter.dart';
import '../setting/setlocation.dart';
import 'mainListView.dart';
import 'package:front/model/mainList/Advertisement.dart';
import 'package:front/data/meetList.dart';
import 'package:front/model/bottomBar.dart';
import 'package:front/screen/mainMap/mainPageMap.dart';

String dong = "용산동";

//List 클래스 더미 객체
meetList test0 = meetList('호스트0', 25, 10, 0, '게임', '대구광역시 북구 90', '산격동', 2023, 6, 30, 17, 00, true, 8, 20000, '내가 이 과목 왜했지', 'ㄹㅇ 인생 최대 실수\n과거의 나야 그만둬\n지금 학점이 문제가 아닙니다', true, 0, 0, 1);
meetList test1 = meetList('호스트1', 24, 11, 1, '스터디', '부산광역시 남구 21-3', '용호동', 2023, 5, 23, 14, 30, true, 4, 15000, '진짜로 왜 했지', '후회막급\n인생실전\n인욕끝없\n같실반복', true, 0, 0, 1);
meetList test2 = meetList('호스트2', 23, 12, 2, '운동', '대구광역시 용산구 123-1', '산격동', 2023, 7, 15, 15, 00, true, 12, 10000, '내가 이 과목 왜했지', 'ㄹㅇ 인생 최대 실수\n과거의 나야 그만둬\n지금 학점이 문제가 아닙니다', true, 0, 0, 1);
meetList test3 = meetList('호스트3', 26, 13, 3, '맛집', '울산광역시 서구 212-31', '강서동', 2023, 3, 7, 16, 30, true, 6, 25000, '진짜로 왜 했지', '후회막급\n인생실전\n인욕끝없\n같실반복', true, 0, 0, 1);

class MainListBoard extends StatefulWidget {
  const MainListBoard({Key? key}) : super(key: key);

  @override
  State<MainListBoard> createState() => _MainListBoardState();
}

class _MainListBoardState extends State<MainListBoard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        leading: TextButton.icon(
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => LocationPage()));
            },
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
            label: Text(dong,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'PretendardBold'),
            )),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("오늘의 건수",
          style: TextStyle(
              fontFamily: 'PretendardBold',
              color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: const BottomAppBar(
          child: BottomBar()
      ),
      body: Padding(
        padding: const EdgeInsets.all(24), //컨테이너 외부 공백 조절
        child: ListView( // 메인 리스트 스크롤 뷰
          children: <Widget>[
            const SizedBox(height: 24.0,), //
            StringText('📣 주변의 새 이벤트', 24, 'PretendardBold', Color(0xff2F3036)),
            const SizedBox(height: 19.0,),

            mainListView.list(test0), //건수 리스트
            mainListView.list(test1),
            Advertisement('광고'), //광고 배너
            mainListView.list(test2),

            StringText('🧭 주변 이벤트', 24, 'PretendardBold', Color(0xff2F3036)),
            mainListView.list(test3),
          ],
        ),
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: <Widget> [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            margin: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              heroTag: "필터화면 이동",
              backgroundColor: const Color(0xFF4874EA),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => Filter()));
              },
              child: const Icon(Icons.menu, color: Color(0xFFFFFFFF)),
            ),
          ), //필터 화면 이동 아이콘
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            margin: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              heroTag: "지도화면 이동",
              backgroundColor: const Color(0xFFFFFFFF),
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Icon(Icons.map, color: Color(0xFF4874EA)),
            ),
          ), //지도 화면 이동 아이콘
        ],
      ),
    );
  }
}