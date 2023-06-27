import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/model/svgbutton/svgbutton.dart';
import 'package:front/screen/profile/profileMain.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../model/profile/CustomAppBar.dart';





class followList extends StatefulWidget {
  @override
  State<followList> createState() => _followListState();
}

class _followListState extends State<followList> {
   List<String> followers = ['user1', 'user2', 'user3'];
   List<String> following = ['user4', 'user5', 'user6'];
   String username = 'username';
   String followerTitle = '팔로워';
   String followingTitle = '팔로잉';
   int followerCount = 100;
   int followingCount = 100;
   String backarrow = 'assets/images/ProfileImage/backarrow.svg';

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
                 Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => profileMain()));},
           ),
          title: Text(username,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,color: Colors.black),),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(child: Column(
                children: [
                  Text(followerTitle,style: TextStyle(fontSize: 14.0,color: Colors.black),),
                  Text(followerCount.toString(),style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,color: Colors.black),),
                ],
              ),),
              Tab(child: Column(
                children: [
                  Text(followingTitle,style: TextStyle(fontSize: 14.0,color: Colors.black),),
                  Text(followingCount.toString(),style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,color: Colors.black),),
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
