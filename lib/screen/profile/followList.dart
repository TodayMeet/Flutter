import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:front/screen/profile/profileMain.dart';
import '../../data/designconst/constants.dart';
import '../../model/UI/widget/button/svgButton.dart';






class followList extends StatefulWidget {
  final username;
  final userNo;
  followList({required this.username, required this.userNo});


  @override
  State<followList> createState() => _followListState();
}

class _followListState extends State<followList> {
  int userNumber = 0;
  String userProfileImage = '';
  String username = '';
   // List<String> followers = [{userNo: 2, userProfileImage: 'http://todaymeet.shop:8080/imagetest/10', username: 'yrdyvbser3'}, {userNo: 3, userProfileImage: http://todaymeet.shop:8080/imagetest/8, username: yrdyv4}]
   List<String> following = [];

   Future<void> followerLoad() async {
     final url = Uri.parse('http://todaymeet.shop:8080/followee/list?userNo=${widget.userNo}');
     final requestData = {
       "userNo": userNumber,
       "userProfileImage":  userProfileImage,
       "username": username
     };
     final jsonData = jsonEncode(requestData);
     final response = await http.get(url, headers: {'Content-Type': 'application/json'},);
     if (response.statusCode == 200) {
       final responseData = jsonDecode(response.body);
       print(responseData);
       print(responseData.runtimeType);
      // setState(() {
      //
      // });
     } else {}
   }//사용자 정보 불어오기

  Future<void> followingLoad() async {
    final url = Uri.parse('http://todaymeet.shop:8080/follow/list?userNo=${widget.userNo}');

    final requestData = {
      "userNo": userNumber,
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
  }//사용자 정보 불어오기

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                  Text(followers.length.toString(),style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,color: Colors.black),),
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
              itemCount: followers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(followers[index]),
                );
              },
            ),
            ListView.builder(
              itemCount: following.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(following[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
