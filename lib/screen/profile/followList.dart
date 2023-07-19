import 'dart:convert';
import 'package:front/screen/profile/userProfile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:front/screen/profile/profileMain.dart';
import '../../data/designconst/constants.dart';
import '../../data/userNo.dart';
import '../../model/UI/widget/button/svgButton.dart';

// username과 userno를 받아옴

class followList extends StatefulWidget {
  final username;
  final userNo;
  followList({required this.username, required this.userNo});

  @override
  State<followList> createState() => _followListState();
}

class _followListState extends State<followList> {
  String userProfileImage = '';
  String username = '';
  List<dynamic> follower = [];
  List<dynamic> following = [];
  bool isFollow = false;
  bool isMe = false;

  Future<void> followingLoad() async {
    final url = Uri.parse(
        'http://todaymeet.shop:8080/follow/list?userNo=${widget.userNo}');
    print(
        'foloowingLoad의 userNo입니다============================${widget.userNo}');

    final requestData = {
      "userNo": widget.userNo,
      "userProfileImage": userProfileImage,
      "username": username
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final responseData2 = jsonDecode(utf8.decode(response.bodyBytes));
      print('responseData2 입니다 .......................... ${responseData2}');
      setState(() {
        following = responseData2;
      });
    } else {}
  } //팔로잉 정보 불러오기

  Future<void> followerLoad() async {
    final url = Uri.parse(
        'http://todaymeet.shop:8080/followee/list?userNo=${widget.userNo}');
    print(
        'folooweeLoad의 userNo입니다============================${widget.userNo}');

    final requestData = {
      "userNo": widget.userNo,
      "userProfileImage": userProfileImage,
      "username": username
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final responseData3 = jsonDecode(utf8.decode(response.bodyBytes));
      print('responseData2 입니다 .......................... ${responseData3}');
      setState(() {
        follower = responseData3;
      });
    } else {}
  } //팔로잉 정보 불러오기

  Future<void> follow() async {
    final url1 = Uri.parse('http://todaymeet.shop:8080/follow/add');
    final requestData = {
      "followerNo": UserNo.myuserNo,
      "followeeNo": widget.userNo
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.post(
      url1,
      headers: {'Content-Type': 'application/json'},
      body: jsonData,
    );
    if (response.statusCode == 200) {
      isFollow = true;
    } else {
      print('전송 자체가 안됨. 상태 코드: ${response.statusCode}');

      print(url1);
    }
  } //팔로우

  Future<void> unfollow() async {
    final url1 = Uri.parse('http://todaymeet.shop:8080/follow/minus');
    final requestData = {
      "followerNo": UserNo.myuserNo,
      "followeeNo": widget.userNo
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.post(
      url1,
      headers: {'Content-Type': 'application/json'},
      body: jsonData,
    );
    if (response.statusCode == 200) {
      isFollow = false;
    } else {
      print('전송 자체가 안됨. 상태 코드: ${response.statusCode}');
      print(url1);
    }
  } // 언팔로우

  @override
  void initState() {
    super.initState();
    followingLoad();
    followerLoad();
  } //시작하면서 나를 팔로우하는사람, 내가 팔로우하는사람 로드

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        //앱바
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: SvgButton(
            imagePath: backarrow,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          //상단에 어떤 사람의 팔로우 목록인지 표시
          title: Text(
            widget.username,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
          centerTitle: true,

          //탭바에 팔로워와 팔로워 수, 팔로잉과 팔로잉 수를 둘 다 표시
          bottom: TabBar(
            tabs: [
              Tab(
                child: Column(
                  children: [
                    Text(
                      '팔로워',
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                    ),
                    Text(
                      follower.length.toString(),
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Text(
                      '팔로잉',
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                    ),
                    Text(
                      following.length.toString(),
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            // 팔로워 탭
            ListView.builder(
              itemCount: follower.length,
              itemBuilder: (context, index) {
                final item = follower[index];
                if (item['userNo'] == UserNo.myuserNo) {
                  isMe = true;
                } else {
                  isMe = false;
                }
                //팔로워 목록 보여주기
                return Container(
                  height: 60,
                  child: GestureDetector(
                    //탭하면 해당 유저 프로필로 이동
                    onTap: () {
                      if (isMe) {
                        print("누군가의 팔로우 리스트를 통해 내 프로필에 들어가는 경우 내 프로필로 이동");
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const profileMain()),
                            (route) => false);
                      } else {
                        print(
                            "다른 사람의 프로필을 보기 - 그 사람의 userNo를 통해 userProfile로 이동");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => userProfile(
                                      userNo: item['userNo'],
                                    )));
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(left: 8),
                      decoration: const BoxDecoration(),
                      child: Row(
                        children: [
                          //사용자 프로필 이미지 출력
                          ClipOval(
                            child: Container(
                                width: 40,
                                height: 40,
                                color: Colors.blue,
                                child: Image.network(item['userProfileImage'])),
                          ),
                          // 사진과 이름 사이 여백
                          SizedBox(
                            width: 10,
                          ),
                          // 유저 이름
                          Text(
                            item['username'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          // 이름과 팔로우 버튼 사이 여백
                          const Spacer(),

                          // 내가 아닌 다른 유저의 프로필일 경우
                          if (!isMe)
                            Container(
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      UserNo.FollowList.contains(item['userNo'])
                                          ? hinttextColor
                                          : buttonBlue,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            30.0), // Set the radius as needed.
                                      ),
                                    ),
                                  ),
                                  // 내가 팔로우 하고 있는 사람이면 팔로잉으로, 내가 팔로우 하고 있지 않으면 팔로우로 변경
                                  child: Text(
                                    UserNo.FollowList.contains(item['userNo'])
                                        ? '팔로잉'
                                        : '팔로우',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: UserNo.FollowList.contains(
                                                item['userNo'])
                                            ? Colors.black
                                            : Colors.white),
                                  )),
                            )
                          // 내 프로필일 경우 버튼 안보이게
                          else
                            Text(' '),
                          //팔로우와 화면 끝 사이의 여백
                          SizedBox(
                            width: 16.0,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            
            // 팔로잉 탭
            ListView.builder(
              itemCount: following.length,
              itemBuilder: (context, index) {
                final item = following[index];
                item['userNo'] == UserNo.myuserNo ? isMe = true : isMe = false;

                return Container(
                  height: 60,
                  child: GestureDetector(
                    onTap: () {
                      
                      // 다른 유저의 팔로워 리스트에서 내 프로필을 선택하면 내 프로필 화면으로 이동
                      isMe
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => profileMain()))
                      // 그렇지 않다면 해당 유저의 프로필로 이동
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => userProfile(
                                        userNo: item['userNo'],
                                      )));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(left: 8),
                      decoration: const BoxDecoration(),
                      child: Row(
                        children: [
                          // 프로필 사진 보여주기
                          ClipOval(
                            child: Container(
                                width: 40,
                                height: 40,
                                color: Colors.blue,
                                child: Image.network(item['userProfileImage'])),
                          ),

                          // 프로필 사진과 이름 사이의 여백
                          SizedBox(width: 10,),

                          //유저 이름
                          Text(
                            item['username'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),

                          // 유저 이름과 버튼 사이의 여백
                          const Spacer(),


                          if (!isMe)
                            Container(
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      UserNo.FollowList.contains(item['userNo'])
                                          ? hinttextColor
                                          : buttonBlue,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            30.0), // Set the radius as needed.
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    UserNo.FollowList.contains(item['userNo'])
                                        ? '팔로잉'
                                        : '팔로우',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: UserNo.FollowList.contains(
                                                item['userNo'])
                                            ? Colors.black
                                            : Colors.white),
                                  )),
                            )
                          else
                            Text(' '),
                          SizedBox(width: 16.0,)
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
