// 탐색 페이지

// 최종 수정일 : 2023.6.28
// 작업자 : 김혁

// 추가 작업 예정 사항
// 카테고리 별로 다른 게시판 출력

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../model/mainList/meetListView.dart';
import '../../model/showtoast.dart';
import '../../data/meetList.dart';
import '../../data/meetList_Provider.dart';

// 게시판 컨트롤러
late RefreshController searchrefreshController;
late StateNotifierProvider<meetListNotifier, List<meetList>> meetListProvider;

// 필터링 Provider
final categoryNumberProvider = StateProvider<int>((ref) => 0);
final StateProvider categoryNameProvider = StateProvider<String>((ref) => "전체보기");

class SearchMain extends ConsumerStatefulWidget {
  const SearchMain({Key? key}) : super(key: key);

  @override
  SearchMainState createState() => SearchMainState();
}

class SearchMainState extends ConsumerState<SearchMain> {
  List<meetList> tempList = [];
  int postNo = 0;

  //서버에서 listdata 받아오기
  Future<int> postListData(String sort, int pageNo, String categoryName) async {
    try {
      final url = Uri.parse("http://todaymeet.shop:8080/meet/categorylist");
      var postBody = {
        "sort": sort,
        "page": pageNo,
        "categoryName": categoryName
      };

      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(postBody),
      );

      if (response.statusCode == 200) {
        tempList = [];
        List<dynamic> meetListData = json.decode(utf8.decode(response.bodyBytes));
        meetListData
            .forEach((element) => tempList.add(meetList.fromJson(element)));
        if(tempList == []){
          return 2;
        }
        return 1;
      } else {
        showToast('Data download failed! : ${response.statusCode}');
        print('Failed to post data : ${response.statusCode}');
        return 0;
      }
    } catch (e) {
      showToast('Data download failed!!');
      print('Failed to post data!!');
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    meetListProvider = StateNotifierProvider<meetListNotifier, List<meetList>>(
            (ref) => meetListNotifier(tempList));
    searchrefreshController = RefreshController(initialRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    List<meetList> viewList = ref.watch(meetListProvider);
    final categoryName = ref.watch(categoryNameProvider);

    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            shadowColor: Colors.transparent,
            title: const Text(
              "탐색",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
            ),
          ),
          body: SmartRefresher(
            enablePullUp: true,
            enablePullDown: true,
            onRefresh: () async {
              postNo = 0;
              int complete = await postListData("참여높은 순", postNo++, categoryName);
              ref.read(meetListProvider.notifier).clearList();
              tempList.forEach(
                      (element) => ref.read(meetListProvider.notifier).addList(element));
              if (complete == 1) {
                showToast("불러오기 성공");
              } else {
                showToast("불러오기 실패");
              }
              searchrefreshController.refreshCompleted();
            },
            onLoading: () async {
              int complete = await postListData("참여높은 순", postNo++, categoryName);
              tempList.forEach(
                      (element) => ref.read(meetListProvider.notifier).addList(element));
              if (complete == 1) {
                showToast("로딩 성공");
              } else if (complete == 2) {
                showToast("데이터가 더이상 없어");
              } else {
                showToast("로딩 실패");
              }
              searchrefreshController.loadComplete();
            },
            controller: searchrefreshController,
            child: meetListViews(context, ref, viewList),
          ),
    ));
  }
}