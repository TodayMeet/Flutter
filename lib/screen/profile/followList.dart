import 'dart:convert';
import 'package:front/screen/profile/userProfile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:front/screen/profile/profileMain.dart';
import '../../data/designconst/constants.dart';
import '../../data/userNo.dart';
import '../../model/UI/widget/button/svgButton.dart';






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
    final url = Uri.parse('http://todaymeet.shop:8080/follow/list?userNo=${widget.userNo}');
    print('foloowingLoad의 userNo입니다============================${widget.userNo}');

    final requestData = {
      "userNo": widget.userNo,
      "userProfileImage":  userProfileImage,
      "username": username
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final responseData2 =jsonDecode(utf8.decode(response.bodyBytes));
      print('responseData2 입니다 .......................... ${responseData2}');
      setState(() {
        following = responseData2;
      });
    } else {}
  }//팔로잉 정보 불러오기

  Future<void> followerLoad() async {
    final url = Uri.parse('http://todaymeet.shop:8080/followee/list?userNo=${widget.userNo}');
    print('folooweeLoad의 userNo입니다============================${widget.userNo}');

    final requestData = {
      "userNo": widget.userNo,
      "userProfileImage":  userProfileImage,
      "username": username
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final responseData3 =jsonDecode(utf8.decode(response.bodyBytes));
      print('responseData2 입니다 .......................... ${responseData3}');
      setState(() {
        follower = responseData3;
      });
    } else {}
  }//팔로잉 정보 불러오기



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
  }

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
  }






  @override
  void initState() {
    super.initState();
     followingLoad();
     followerLoad();

  }

  @override
  Widget build(BuildContext context) {



    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: SvgButton(
            imagePath: backarrow,
            onPressed:() {
              Navigator.pop(context);
            },
          ),
          title: Text(widget.username,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,color: Colors.black),),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(child: Column(
                children: [
                  Text('팔로워',style: TextStyle(fontSize: 14.0,color: Colors.black),),
                  Text(follower.length.toString(),style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,color: Colors.black),),
                ],
              ),),
              Tab(child: Column(
                children: [
                  Text('팔로잉',style: TextStyle(fontSize: 14.0,color: Colors.black),),
                  Text(following.length.toString(),style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,color: Colors.black),),
                ],
              ),),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: follower.length,
              itemBuilder: (context, index) {

                final item = follower[index];
                if( item['userNo']==UserNo.myuserNo ){
                  isMe = true;
                } else{
                  isMe = false;
                }
                return Container(
                  height: 60,
                  child: GestureDetector(
                    onTap: () {
                      if (isMe) {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                            builder: (context) => const profileMain()), (route) => false);
                      } else {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                userProfile(userNo: item['userNo'],)));
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(left: 8),
                      decoration: const BoxDecoration(

                      ),
                      child: Row(

                        children: [
                          ClipOval(child: Container(
                                width: 40,
                                height: 40,
                                color: Colors.blue,
                                child: Image.network(item['userProfileImage'])
                            ),),
                          SizedBox(width: 10,),
                          Text(
                            item['username'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          if (!isMe) Container(

                            child: ElevatedButton(
                                onPressed: (){},
                                style: ButtonStyle(

                                    backgroundColor: MaterialStateProperty.all(
                                        UserNo.FollowList.contains(item['userNo']) ? hinttextColor : buttonBlue)
                                ),
                                child: Text(UserNo.FollowList.contains(item['userNo']) ? '팔로잉' : '팔로우',
                                    style: TextStyle(fontWeight: FontWeight.w700, color: UserNo.FollowList.contains(item['userNo']) ? Colors.black : Colors.white),)
                            ),
                          ) else Text(' '),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            ListView.builder(
              itemCount: following.length,
              itemBuilder: (context, index) {
                final item = following[index];
                item['userNo']==UserNo.myuserNo  ? isMe=true : isMe=false;

                return Container(
                  height: 60,
                  child: GestureDetector(
                    onTap: () {
                      isMe
                      ? Navigator.push(
                          context, MaterialPageRoute(builder: (context) => profileMain()))
                      : Navigator.push(
                          context, MaterialPageRoute(builder: (context) => userProfile(userNo: item['userNo'],)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(left: 8),
                      decoration: const BoxDecoration(

                      ),
                      child: Row(
                        children: [
                          ClipOval(child: Container(
                              width: 40,
                              height: 40,
                              color: Colors.blue,
                              child: Image.network(item['userProfileImage'])
                          ),),
                          SizedBox(width: 10,),
                          Text(
                            item['username'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          if (!isMe) Container(

                            child: ElevatedButton(
                                onPressed: (){},
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        UserNo.FollowList.contains(item['userNo'])
                                            ? hinttextColor
                                            : buttonBlue)
                                ),
                                child: Text(
                                  UserNo.FollowList.contains(item['userNo'])
                                      ? '팔로잉'
                                      : '팔로우',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color:
                                      UserNo.FollowList.contains(item['userNo'])
                                          ? Colors.black
                                          : Colors.white
                                  ),)),
                          ) else Text(' '),
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
