// 탐색 페이지

// 최종 수정일 : 2023.7.18
// 작업자 : 김혁

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/data/search/recommendedHost.dart';
import 'package:front/data/search/recommendedHost_Provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../model/mainList/meetListView.dart';
import '../../model/showtoast.dart';
import '../../data/userNo.dart';
import '../../data/meetList.dart';
import '../../data/meetList_Provider.dart';

// 게시판 컨트롤러
late RefreshController searchrefreshController;
late StateNotifierProvider<meetListNotifier, List<meetList>> meetListProvider;

// 필터링 Provider
final categoryNumberProvider = StateProvider<int>((ref) => 0);
final StateProvider categoryNameProvider = StateProvider<String>((ref) => "전체보기");

// 추천 호스트 provider
late StateNotifierProvider<RecommendedHostState, List<RecommendedHost>> hostListProvider;

class SearchMain extends ConsumerStatefulWidget {
  const SearchMain({Key? key}) : super(key: key);

  @override
  SearchMainState createState() => SearchMainState();
}

class SearchMainState extends ConsumerState<SearchMain> {
  List<meetList> tempList = [];
  int postNo = 0;
  List<RecommendedHost> tempHost = [];
  bool first = true;
  final advertisementProvider = StateProvider<List<String>>((ref) => []);

  // 서버에서 listdata 받아오기
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

  // 서버에서 추천 호스트 받아오기
  Future<void> getRecommendedHost(String categoryName) async {
    try{
      final url = Uri.parse('http://todaymeet.shop:8080/popular-user');
      var postbody = {
        "userNo":UserNo.myuserNo,
        "categoryname":categoryName
      };

      http.Response response = await http.post(
        url,
        headers: {"Content-Type":"application/json"},
        body: json.encode(postbody),
      );

      if(response.statusCode == 200){
        final serverData = jsonDecode(utf8.decode(response.bodyBytes));
        debugPrint('------------------------탐색화면 추천 호스트 출력------------------------');
        print(serverData);
        tempHost = [];
        serverData
            .forEach((element) => tempHost.add(RecommendedHost.fromJson(element)));

        ref.read(hostListProvider.notifier).clearHost();
        tempHost.forEach(
                (element) => ref.read(hostListProvider.notifier).addHost(element));
      }else{
        debugPrint('추천 호스트 출력 서버 오류');
        showToast('추천 호스트 출력 서버 오류');
      }
    }catch(e){
      debugPrint('추천 호스트 출력 오류');
      showToast('추천 호스트 출력 오류');
    }
  }

  // 서버에서 광고 배너 이미지 받아오기
  Future<void> getAdvertisement() async {
    try{
      final url = Uri.parse("http://todaymeet.shop:8080/ad/three");

      http.Response response = await http.get(url);

      if(response.statusCode == 200){
        debugPrint('-------------광고 이미지 받기 성공-------------');

        var serverData = json.decode(utf8.decode(response.bodyBytes));
        print(serverData);
        serverData.forEach((element)=>ref.read(advertisementProvider.notifier).state.add(element));
      }else{
        debugPrint('광고 배너 서버 오류');
        showToast('광고 배너 서버 오류');
      }
    } catch (e){
      debugPrint('광고 배너 오류');
      showToast('광고 배너 오류');
    }
  }

  @override
  void initState() {
    super.initState();
    meetListProvider = StateNotifierProvider<meetListNotifier, List<meetList>>(
            (ref) => meetListNotifier(tempList));
    hostListProvider = StateNotifierProvider<RecommendedHostState, List<RecommendedHost>>(
            (ref) => RecommendedHostState(tempHost));
    searchrefreshController = RefreshController(initialRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    List<meetList> viewList = ref.watch(meetListProvider);
    List<RecommendedHost> hostList = ref.watch(hostListProvider);
    List<String> advertisementList = ref.watch(advertisementProvider.notifier).state;
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
              if (complete != 1) {
                showToast("불러오기 실패");
              }
              await getRecommendedHost(categoryName);
              if(first == true){
                await getAdvertisement();
                setState(() {
                  first = false;
                });
              }
              searchrefreshController.refreshCompleted();
            },
            onLoading: () async {
              int complete = await postListData("참여높은 순", postNo++, categoryName);
              tempList.forEach(
                      (element) => ref.read(meetListProvider.notifier).addList(element));
              if (complete == 2) {
                showToast("데이터가 더이상 없습니다.");
              } else if (complete == 0){
                showToast("로딩 실패");
              }
              searchrefreshController.loadComplete();
            },
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode){
                return Container();
              },
            ),
            controller: searchrefreshController,
            child: meetListViews(context, ref, viewList, hostList, advertisementList),
          ),
    ));
  }
}