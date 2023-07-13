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
  int userNo = UserNo.myuserNo;
  String userProfileImage = '';
  String username = '';


  List<Map> follower = [];
  List<Map> following = [];

   // List<String> followers = [
  // {userNo: 2, userProfileImage: 'http://todaymeet.shop:8080/imagetest/10', username: 'yrdyvbser3'},
  // {userNo: 3, userProfileImage: http://todaymeet.shop:8080/imagetest/8, username: yrdyv4}
  // ]


   Future<void> followerLoad() async {
     final url = Uri.parse('http://todaymeet.shop:8080/followee/list?userNo=${widget.userNo}');
     final requestData = {
       "userNo": userNo,
       "userProfileImage":  userProfileImage,
       "username": username
     };
     final jsonData = jsonEncode(requestData);
     final response = await http.get(url, headers: {'Content-Type': 'application/json'},);
     if (response.statusCode == 200) {
       final responseData = jsonDecode(response.body);
       print(responseData);

     } else {}
   }//팔로워 정보 불러오기

  Future<void> followingLoad() async {
    final url = Uri.parse('http://todaymeet.shop:8080/follow/list?userNo=${widget.userNo}');

    final requestData = {
      "userNo": userNo,
      "userProfileImage":  userProfileImage,
      "username": username
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print(responseData);
    } else {}
  }//팔로잉 정보 불러오기

  List<Map> followerr = [
    {'userNo': 2, 'userProfileImage': 'http://todaymeet.shop:8080/imagetest/10', 'username': 'yrdyvbser3'},
    {'userNo': 3, 'userProfileImage': 'http://todaymeet.shop:8080/imagetest/10', 'username': 'yrdyv4'}
  ];


   List<Map> followingg = [
  {'userNo': 5, 'userProfileImage': 'http://todaymeet.shop:8080/imagetest/1', 'username': 'yrdycrey'},
  {'userNo': 6, 'userProfileImage': 'http://todaymeet.shop:8080/imagetest/1', 'username': 'q'},
  {'userNo': 3, 'userProfileImage': 'http://todaymeet.shop:8080/imagetest/8', 'username': 'yrdyv4'},
  {'userNo': 3, 'userProfileImage': 'http://todaymeet.shop:8080/imagetest/8', 'username': 'yrdyv4'}
   ];


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
              // Navigator.pop(context);
              followerLoad();
              // followingLoad();
            },
          ),
          title: Text(widget.username,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,color: Colors.black),),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(child: Column(
                children: [
                  Text('팔로워',style: TextStyle(fontSize: 14.0,color: Colors.black),),
                  Text(followerr.length.toString(),style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,color: Colors.black),),
                ],
              ),),
              Tab(child: Column(
                children: [
                  Text('팔로잉',style: TextStyle(fontSize: 14.0,color: Colors.black),),
                  Text(followingg.length.toString(),style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,color: Colors.black),),
                ],
              ),),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async{},
          child: TabBarView(
            children: [
              ListView.builder(
                itemCount: followerr.length,
                itemBuilder: (context, index) {
                  final item = followerr[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => userProfile(userNo: item['userNo'],)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(left: 8),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: const BorderSide(
                              color: const Color(0xFFE3E3E3), width: 1.0),
                        ),
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
                          ElevatedButton(
                              onPressed: (){
                                // followerLoad();
                              },
                              child: Text('팔로우'))
                        ],
                      ),
                    ),
                  );
                },
              ),
              ListView.builder(
                itemCount: followingg.length,
                itemBuilder: (context, index) {
                  final item = followingg[index];
                  return GestureDetector(
                    onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => userProfile(userNo: item['userNo'],)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(left: 8),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: const BorderSide(
                              color: const Color(0xFFE3E3E3), width: 1.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              child: Image.network(item['userProfileImage']),
                              radius: 15,
                            ),
                          ),
                          Text(
                            item['username'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                              onPressed: (){},
                              child: Text('팔로우'))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
