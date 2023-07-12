import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/meetList.dart';
import '../../data/meetList_Provider.dart';
import '../../model/mainList/meetListView.dart';
import '../../model/showtoast.dart';
import 'profileMain.dart';
import '../../data/designconst/constants.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';

class hostEvent extends ConsumerStatefulWidget {
  const hostEvent({Key? key, required this.userNo
  }) : super(key: key);
  final int userNo;
  @override
  ConsumerState createState() => _hostEventState();
}

class _hostEventState extends ConsumerState<hostEvent> {

  // 게시판 컨트롤러
  RefreshController searchrefreshController = RefreshController(initialRefresh: true);
  late StateNotifierProvider<meetListNotifier, List<meetList>> meetListProvider;

  // 서버로 받아오는 리스트
  List<meetList> tempList = [];
  // 받아온 페이지 수
  int postNo = 0;

  //서버에서 listdata 받아오기
  Future<int> postListData(String sort, int pageNo) async {
    try {
      final url = Uri.parse("http://todaymeet.shop:8080/meet/hostlist/${widget.userNo}");
      var postBody = {
        "sort": sort,
        "page": pageNo,
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
  }
  
  @override
  Widget build(BuildContext context) {
    List<meetList> viewList = ref.watch(meetListProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed:() {
            Navigator.pop(context);},
          width: 24.0,
          height: 24.0,
        ),
        title: '개최한 건수',
      ),
      body: SmartRefresher(
        enablePullUp: true,
        enablePullDown: true,
        onRefresh: () async {
          postNo = 0;
          int complete = await postListData("최신순", postNo++);
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
          int complete = await postListData("최신순", postNo++);
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
        child: meetListViewSearch(context, ref, viewList),
      ),

    );
  }
}

