//메인 리스트 게시판

// 최종 수정: 2023.6.2
// 작업자: 정해수

//추가 작업 예정 사항:
// 주변 이벤트 vs 주변의 새 이벤트
// 리스트 정렬 순서

import 'package:flutter/material.dart';
import 'package:front/data/dummy_meetList.dart';
import 'package:front/data/meet.dart';
import 'package:front/model/TextPrint.dart';
//import 'package:front/screen/mainList/serverTest.dart';
import '../../data/meetList_Provider.dart';
import '../mainMap/mainPageMap.dart';
import 'package:front/screen/alarm/alarm.dart';
import '../setting/setFilter.dart';
import '../setting/setlocation.dart';
import 'Loading.dart';
import 'mainListView.dart';
import 'package:front/model/mainList/Advertisement.dart';
import 'package:front/data/meetList.dart';
import 'package:front/model/bottomBar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

RefreshController _refreshController = RefreshController(initialRefresh: true);

class MainListBoard extends ConsumerStatefulWidget {
  const MainListBoard({Key? key}) : super(key: key);

  @override
  MainListBoardState createState() => MainListBoardState();
}

class MainListBoardState extends ConsumerState<MainListBoard> {
  List<meetList> tempList = [];
  int postNo = 0;

  void postListData(String sort, int pageNo) async {
    try {
      final url = Uri.parse("http://todaymeet.shop:8080/meet/list/대");
      var postBody =
      {
        "sort":sort,
        "page":pageNo
      };

      http.Response response = await http.post(
        url,
        headers: {'Content-Type' : 'application/json'},
        body: json.encode(postBody),
      );

      if (response.statusCode == 200) {
        tempList = [];
        List<dynamic> meetListData = json.decode(utf8.decode(response.bodyBytes));
        meetListData.forEach((element) => tempList.add(meetList.fromJson(element)));
      } else {
        showToast('Data download failed!');
        print('Failed to post data : ${response.statusCode}');
      }
    } catch(e) {
      showToast('Data download failed!');
      print('Failed to post data');
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    List<meetList> viewList = ref.watch(meetListProvider);

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
            label: Text(ref.read(dongProvider.notifier).state,
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => alarm()));
              },
              icon: Icon(
                Icons.notifications_none,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      bottomNavigationBar: const BottomAppBar(
          child: BottomBar()
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: () async {
          Future.delayed(const Duration(milliseconds: 300));
          postNo = 0;
          print(postNo);
          postListData("최신순", postNo);
          postNo++;
          ref.read(meetListProvider.notifier).clearList();
          tempList.forEach((element) => print(element));
          tempList.forEach((meetList) => ref.read(meetListProvider.notifier).addList(meetList));
          _refreshController.refreshCompleted();
        },
        onLoading: () async {
          Future.delayed(const Duration(milliseconds: 300));
          if(ref.read(meetListProvider).length < 31) {
            print(postNo);
            postListData("최신순", postNo);
            postNo++;
            tempList.forEach((element) => print(element));
            tempList.forEach((meetList) => ref.read(meetListProvider.notifier).addList(meetList));
          }
          _refreshController.loadComplete();
        },
        header: CustomHeader(
          builder: (BuildContext context, RefreshStatus? mode) {
            Widget body;
            if (mode == RefreshStatus.idle) {
              body = StringText('건수 목록 새로고침', 20, 'PretendardBold', Colors.black);
            } else if (mode == RefreshStatus.refreshing) {
              body = StringText('건수 불러오는 중...', 20, 'PretendardBold', Colors.black);
            } else if (mode == RefreshStatus.failed) {
              body = StringText('불러오는 과정에서 오류가 발생했습니다', 20, 'PretendardBold', Colors.black);
            } else {
              body = StringText('건수 목록 새로고침', 20, 'PretendardBold', Colors.black);
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus? mode){
            Widget body;
            if(ref.read(meetListProvider).length > 31) {
              body = const Text("");
            } else if(mode==LoadStatus.idle){
              body =  StringText('건수 더 보기', 20, 'PretendardBold', Colors.black);
            }
            else if(mode==LoadStatus.loading){
              body =  StringText('건수 불러오는 중...', 20, 'PretendardBold', Colors.black);
            }
            else if(mode == LoadStatus.failed){
              body = StringText('불러오는 과정에서 오류가 발생했습니다', 20, 'PretendardBold', Colors.black);
            }
            else if(mode == LoadStatus.canLoading){
              body = StringText('건수 불러오는 중...', 20, 'PretendardBold', Colors.black);
            }
            else{
              body = const Text("");
            }
            return SizedBox(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        child: ListView(// 메인 리스트 스크롤 뷰
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 24.0,), //
            StringText('📣 주변의 새 이벤트', 24, 'PretendardBold', const Color(0xff2F3036)),
            const SizedBox(height: 19.0,),

            //test용 버튼
            ElevatedButton(
              onPressed: () {
                /*Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) =>serverTest())
                );*/
              },
              // ignore: prefer_const_constructors
              child: Text('server test'),
            ), // test-

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
  return Column(
    children: [
      InkWell(
        child: mainListView(List, ref),
        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => Loading(meetNo: List.meetNo, userNo: tempUser['userNo'],)));
        }, // -> 건수 상세 페이지로 이동
      ),
      const SizedBox(height: 18,)
    ],
  );
}