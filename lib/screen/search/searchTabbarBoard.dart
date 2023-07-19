// 탐색 3 페이지 TabbarWidget

// 최종 수정일 : 2023.7.19
// 작업자 : 김혁

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../model/mainList/meetListView.dart';
import '../../model/showtoast.dart';
import '../../data/meetList.dart';
import '../../data/meetList_Provider.dart';

class SearchTabbarViewItem extends ConsumerStatefulWidget {
  SearchTabbarViewItem({
    Key? key, required this.searchword, required this.categoryName,
  }) : super(key: key);

  String searchword;
  final String categoryName;

  @override
  ConsumerState createState() => _SearchTabbarViewItemState();
}

class _SearchTabbarViewItemState extends ConsumerState<SearchTabbarViewItem> {
  // 게시판 컨트롤러
  RefreshController searchrefreshController = RefreshController(initialRefresh: true);
  late StateNotifierProvider<meetListNotifier, List<meetList>> meetListProvider;

  List<meetList> tempList = [];
  int postNo = 0;

  //서버에서 제목에 검색어가 들어간 listdata 받아오기
  Future<int> postListData(String sort, int pageNo, String categoryName) async {
    try {
      final url = Uri.parse("http://todaymeet.shop:8080/meet/titlelist/${widget.searchword}");
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
          return 1;
        }

        debugPrint('--------------------- 탐색 화면 탭바 리스트 불러오기 완료 --------------------');
        return 0;
      } else {
        showToast('Data download failed! : ${response.statusCode}');
        debugPrint('Failed to post data : ${response.statusCode}');
        return -1;
      }
    } catch (e) {
      showToast('Data download failed!!');
      debugPrint('Failed to post data!!');
      return -1;
    }
  }

  @override
  void initState() {
    super.initState();
    meetListProvider = StateNotifierProvider<meetListNotifier, List<meetList>>(
            (ref) => meetListNotifier(tempList));
  }


  // 검색어 변경시 refresh 적용
  @override
  void didUpdateWidget(covariant SearchTabbarViewItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.searchword != oldWidget.searchword){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _triggerRefresh();
      });
    }
  }

  Future<void> _triggerRefresh() async {
    if(!mounted) return;
    searchrefreshController.requestRefresh();
  }

  @override
  Widget build(BuildContext context) {
    List<meetList> viewList = ref.watch(meetListProvider);

    return SmartRefresher(
      enablePullUp: true,
      enablePullDown: true,
      onRefresh: () async {
        postNo = 0;
        int complete = await postListData("참여높은 순", postNo++, widget.categoryName);
        ref.read(meetListProvider.notifier).clearList();
        tempList.forEach(
                (element) => ref.read(meetListProvider.notifier).addList(element));
        if (complete != 0) {
          showToast("불러오기 실패");
        }
        searchrefreshController.refreshCompleted();
      },
      onLoading: () async {
        int complete = await postListData("참여높은 순", postNo++, widget.categoryName);
        tempList.forEach(
                (element) => ref.read(meetListProvider.notifier).addList(element));
        if (complete == 1) {
          showToast("데이터가 더이상 없습니다");
        } else if (complete == -1) {
          showToast("로딩 실패");
        }
        searchrefreshController.loadComplete();
      },
      controller: searchrefreshController,
      child: meetListViewSearch(context, ref, viewList),
    );
  }
}
