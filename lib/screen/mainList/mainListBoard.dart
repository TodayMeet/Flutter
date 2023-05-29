//메인 리스트 게시판

// 최종 수정: 2023.5.17
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
import 'ListDetail.dart';
import 'mainListView.dart';
import 'package:front/model/mainList/Advertisement.dart';
import 'package:front/data/meetList.dart';
import 'package:front/model/bottomBar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String dong = "용산동";

class MainListBoard extends ConsumerStatefulWidget {
  const MainListBoard({Key? key}) : super(key: key);

  @override
  _MainListBoardState createState() => _MainListBoardState();
}

class _MainListBoardState extends ConsumerState<MainListBoard> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        leading: TextButton.icon(
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => const LocationPage()));
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
        child: ListView(// 메인 리스트 스크롤 뷰
          children: [
            const SizedBox(height: 24.0,), //
            StringText('📣 주변의 새 이벤트', 24, 'PretendardBold', const Color(0xff2F3036)),
            const SizedBox(height: 19.0,),

            ElevatedButton(
              onPressed: () => ref.watch(curUserNumProvider.notifier).state++,
                // ignore: prefer_const_constructors
              child: Text('test (+)'),
            ), // test+
            ElevatedButton(
              onPressed: () => ref.watch(curUserNumProvider.notifier).state--,
              // ignore: prefer_const_constructors
              child: Text('test (-)'),
            ), // test-

            //건수 리스트
            ListViewer(context, ref, test0),
            ListViewer(context, ref, test1),

            Advertisement('광고'), //광고 배너
            StringText('🧭 주변 이벤트', 24, 'PretendardBold', const Color(0xff2F3036)),
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
                        builder: (context) => const Filter()));
              },
              child: const Icon(Icons.tune, color: Color(0xFFFFFFFF)),
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

Widget ListViewer(BuildContext context, WidgetRef ref, meetList List) {

  return InkWell(
    child: mainListView(List, ref),
    onTap: (){
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => const ListDetail()));
    }, // -> 건수 상세 페이지로 이동
  );
}