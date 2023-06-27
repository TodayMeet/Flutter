//메인 리스트 게시판

// 최종 수정: 2023.6.27
// 작업자: 정해수 -> 김혁

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:front/model/TextPrint.dart';
import '../../data/meetList_Provider.dart';
import '../../model/mainList/meetListView.dart';
import '../mainMap/mainPageMap.dart';
import '../setting/setFilter.dart';
import '../setting/setlocation.dart';
import 'package:front/data/meetList.dart';
import 'package:front/model/bottomBar.dart';

RefreshController _refreshController = RefreshController(initialRefresh: false);

class MainListBoard extends ConsumerStatefulWidget {
  const MainListBoard({Key? key,
    required this.meetListData
  }) : super(key: key);

  final dynamic meetListData;

  @override
  MainListBoardState createState() => MainListBoardState();
}

class MainListBoardState extends ConsumerState<MainListBoard> {
  late StateNotifierProvider<meetListNotifier, List<meetList>> meetListProvider;
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
        showToast('Data download failed! : ${response.statusCode}');
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
    widget.meetListData.forEach((element) => tempList.add(meetList.fromJson(element)));
    meetListProvider = StateNotifierProvider<meetListNotifier, List<meetList>>((ref) {
      return meetListNotifier(tempList);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<meetList> viewList = ref.watch(meetListProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 110,
        leading: TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LocationPage()));
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 12, top: 13, bottom: 13),
                child: Text(
                  ref.watch(dongProvider),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              SvgPicture.asset(
                "assets/icons/drop_down.svg",
                height: 24,
                width: 24,
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("오늘의 건수",
          style: TextStyle(
              fontWeight : FontWeight.w700,
              color: Colors.black,
              fontSize: 16
          ),
        ),
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
          postNo = 0;
          postListData("최신순", postNo++);
          ref.read(meetListProvider.notifier).clearList();
          tempList.forEach((meetList) => ref.read(meetListProvider.notifier).addList(meetList));
          _refreshController.refreshCompleted();
        },
        onLoading: () async {
          if(ref.read(meetListProvider).length < 31) {
            if(postNo <= 1) {
              ref.read(meetListProvider.notifier).clearList();
            }
            postListData("최신순", postNo++);
            tempList.forEach((meetList) => ref.read(meetListProvider.notifier).addList(meetList));
          }
          _refreshController.loadComplete();
        },
        header: CustomHeader(
          builder: (BuildContext context, RefreshStatus? mode) {
            Widget body;
            if (mode == RefreshStatus.idle) {
              body = StringText('건수 목록 새로고침', 20, FontWeight.w700, Colors.black);
            } else if (mode == RefreshStatus.refreshing) {
              body = StringText('건수 불러오는 중...', 20, FontWeight.w700, Colors.black);
            } else if (mode == RefreshStatus.failed) {
              body = StringText('불러오는 과정에서 오류가 발생했습니다', 20, FontWeight.w700, Colors.black);
            } else {
              body = StringText('건수 목록 새로고침', 20, FontWeight.w700, Colors.black);
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
              body =  StringText('건수 더 보기', 20, FontWeight.w700, Colors.black);
            }
            else if(mode==LoadStatus.loading){
              body =  StringText('건수 불러오는 중...', 20, FontWeight.w700, Colors.black);
            }
            else if(mode == LoadStatus.failed){
              body = StringText('불러오는 과정에서 오류가 발생했습니다', 20, FontWeight.w700, Colors.black);
            }
            else if(mode == LoadStatus.canLoading){
              body = StringText('건수 불러오는 중...', 20, FontWeight.w700, Colors.black);
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
        child: meetListView(context, ref, viewList),
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
              child: SvgPicture.asset(
                "assets/icons/filter.svg",
              ),
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
              child: SvgPicture.asset(
                  "assets/icons/map.svg"
              ),
            ),
          ), //지도 화면 이동 아이콘
        ],
      ),
    );
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      fontSize: 15,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM
  );
}