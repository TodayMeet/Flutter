//hostevent1백업
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data/meetList.dart';
import '../../data/meetList_Provider.dart';
import '../../data/userNo.dart';
import '../../model/UI/widget/button/WhiteButton.dart';
import '../../model/mainList/meetListView.dart';
import '../../model/showtoast.dart';

import '../../data/designconst/constants.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';
import 'followList.dart';

class userProfile extends ConsumerStatefulWidget {
  const userProfile({Key? key, required this.userNo
  }) : super(key: key);
  final int userNo;
  @override
  ConsumerState createState() => _userProfileState();
}

class _userProfileState extends ConsumerState<userProfile> {

  // 게시판 컨트롤러
  RefreshController searchrefreshController = RefreshController(initialRefresh: true);
  late StateNotifierProvider<meetListNotifier, List<meetList>> meetListProvider;

  // 서버로 받아오는 리스트
  List<meetList> tempList = [];
  // 받아온 페이지 수
  int postNo = 0;
  int userNo = 0;
  String username = '';
  int gender = 0;
  String genderString = '';
  String birth = '';
  int followernum = 0;
  int followingnum = 0;
  String userprofileimage = '';
  int myuserNo = UserNo.myuserNo;
  bool isFollow = false;
  bool isBlock = false;



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
  Future<void> follow() async {
    final url1 = Uri.parse('http://todaymeet.shop:8080/follow/add');
    final requestData = {
      "followerNo":UserNo.myuserNo,
      "followeeNo": widget.userNo

    };
    final jsonData = jsonEncode(requestData);
    final response = await http.post(
      url1,
      headers: {'Content-Type': 'application/json'},
      body: jsonData,
    );
    if (response.statusCode == 200) {
      print('전송잘됨');

      print(url1);
      print('문의 완료    ${response.body}');
      print(response);


    } else {

      print('전송 자체가 안됨. 상태 코드: ${response.statusCode}');

      print(url1);


    }
  }
  Future<void> unfollow() async {
    final url1 = Uri.parse('http://todaymeet.shop:8080/follow/minus');
    final requestData = {
      "followerNo":widget.userNo,
      "followeeNo": myuserNo

    };
    final jsonData = jsonEncode(requestData);
    final response = await http.post(
      url1,
      headers: {'Content-Type': 'application/json'},
      body: jsonData,
    );
    if (response.statusCode == 200) {
      print('전송잘됨');
      print(url1);
      print('문의 완료    ${response.body}');
      print(response);
    } else {
      print('전송 자체가 안됨. 상태 코드: ${response.statusCode}');
      print(url1);


    }
  }
  Future<void> userInfoLoad() async {
    final url = Uri.parse('http://todaymeet.shop:8080/user-profile/${widget.userNo}');
    final requestData = {
      'userNo': widget.userNo,
      'username': username,
      'follownum': followernum,
      'followeenum': followingnum,
      'gender': gender,
      'birth': birth,
      'userprofileimage': userprofileimage
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        userNo = responseData['userNo'];
        userprofileimage = responseData['userProfileImage'];
        username = responseData['username'];

        if(responseData['birth']==null){
          birth = '';
        } else{
          birth = (responseData['birth'].substring(0,10)).replaceAll('-', '.');
        }

        if (responseData['gender'] == 1) {
          genderString = '(남)';
        } else if (responseData['gender'] == 2) {
          genderString = '(여)';
        }

      });
    } else {}
  }
  Future<void> followingLoad() async {
    final url = Uri.parse('http://todaymeet.shop:8080/follow/list?userNo=${widget.userNo}');
    print('foloowingLoad의 userNo입니다============================${widget.userNo}');

    final requestData = {
      "userNo": widget.userNo,
      "userProfileImage":  userprofileimage,
      "username": username
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final responseData2 =jsonDecode(utf8.decode(response.bodyBytes));

      followingnum = responseData2.length;
      print('임마 followingnum ${followingnum}');
      // setState(() {
      //   followNoList = responseData2.map<int>((user) => user['userNo'] as int).toSet().toList();
      //   UserNo.FollowList = followNoList;
      // });
    } else {}
  }//팔로잉 정보 불러오기
  Future<void> followerLoad() async {
    final url = Uri.parse('http://todaymeet.shop:8080/followee/list?userNo=${widget.userNo}');
    print('followerLoad의 userNo입니다============================${widget.userNo}');

    final requestData = {
      "userNo": widget.userNo,
      "userProfileImage":  userprofileimage,
      "username": username
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final responseData3 = jsonDecode(utf8.decode(response.bodyBytes));
      followernum = responseData3.length;
      print('followernum입니다 ${followernum}');
    } else {}
  }//팔로워 정보 불러오기

  @override
  void initState() {
    super.initState();
    userInfoLoad();
    followingLoad();
    followerLoad();
    meetListProvider = StateNotifierProvider<meetListNotifier, List<meetList>>(
            (ref) => meetListNotifier(tempList));
  }

  @override
  Widget build(BuildContext context) {
    List<meetList> viewList = ref.watch(meetListProvider);
    VoidCallback onFollowButtonPressed  = (){setState(() {isFollow = !isFollow;});};
    VoidCallback onBlockButtonPressed  = (){setState(() {isBlock = !isBlock;});};

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed:() {
            Navigator.pop(context);
          },
          width: 24.0,
          height: 24.0,
        ),
        title: username +' 님의 프로필',
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
          child: meeeeet(context, ref, viewList,userprofileimage,username,widget.userNo,genderString,birth,followernum,followingnum,isFollow,onFollowButtonPressed,isBlock,onBlockButtonPressed
          )
      ),

    );
  }
}



Widget meeeeet(BuildContext context, WidgetRef ref, List<meetList> viewList,
    String userprofileimage,String username, int userNo,String genderString,
    String birth,int followernum,int followingnum,bool isFollow,
    VoidCallback onFollowButtonPressed,bool isBlock,VoidCallback onBlockButtonPressed) {
  return ListView(  // 탐색 화면 검색 창 탭바
    padding: EdgeInsets.zero,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 24),
        child: Row(
          children: [
            ClipOval(
              child: Container(width: 70, height: 70, color: Colors.blue, child: Image.network(userprofileimage)),),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${username} ${genderString}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      '${birth} ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),//유저이름, 성, 생년월일
                SizedBox(
                  height: 11,
                ),
                Row(
                  children: [
                    whiteButton(
                      buttonText:
                      isFollow
                      ? '언팔로우'
                      : '팔로우',
                      onPressed: (){
                        onFollowButtonPressed();
                        print('팔로우함? ${isFollow}');
                        print(userNo);
                        print(UserNo.FollowList);},
                      width: (MediaQuery.of(context).size.width - 148) / 2 ,),
                    SizedBox(
                      width: 10.0,
                    ),//팔로우 버튼과 차단 버튼 사이 여백
                    whiteButton(
                      buttonText:
                      isBlock
                      ? '차단해제'
                      : '차단',
                      onPressed: (){
                        onBlockButtonPressed();
                        print(isBlock);
                      },
                      width: (MediaQuery.of(context).size.width - 148) / 2 ,
                    )
                  ],
                ),

              ],
            ),
          ],),
      ),
      Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFFCACACA),
                  width: 0.5,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('팔로워',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12.0,color: Color(0xFFA7A8A9)),),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>followList(userNo: userNo,username: username)));

                  },
                  child: Text(followernum.toString(),style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w700,color: Color(0xFF1F2024)),),
                )
              ],
            ),
          ), //팔로워
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFFCACACA),
                  width: 0.5,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('팔로우',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12.0,color: Color(0xFFA7A8A9)),),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>followList(userNo: userNo,username: username)));
                  },
                  child: Text(followingnum.toString(),style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w700,color: Color(0xFF1F2024)),),
                )
              ],
            ),
          ),//팔로잉
        ],
      ),
      ...viewList.asMap().entries.map((list) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          child: ListViewer(context, ref, list.value),
        );
      }).toList(), //건수 리스트
    ],
  );
}




