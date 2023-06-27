import 'package:flutter/material.dart';
import 'package:front/screen/profile/profileMain.dart';

import '../../model/bottomBar.dart';
import '../../model/profile/CustomAppBar.dart';
import '../../model/svgbutton/svgbutton.dart';
import '../login/registerProfile.dart';
import 'followList.dart';

class userProfile extends StatefulWidget {
  const userProfile({Key? key}) : super(key: key);

  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  String name = '000';
  String gender = '여';
  Color followButtonTextColor = Color(0xFF666666);
  String followerText = '팔로워';
  String followButtonText = '팔로우';
  String birthdate = '2000.07.19';
  int follower = 100;
  int following = 100;
  String appbarText = '님의 프로필';
  String backarrow = 'assets/images/ProfileImage/backarrow.svg';
  Color followbuttonBorderColor = Color(0xFFCACACA);
  Color followTextColor = Color(0xFFA7A8A9);
  Color follownumberColor = Color(0xFF1F2024);
  String followingText = '팔로잉';
  String blockButtonText = '차단';


  @override
  Widget build(BuildContext context) {
    double halfWidth = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => profileMain()));
          },
        ),
        title: name + appbarText,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:24.0,vertical: 12.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${name}(${gender})',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          '${birthdate} ',
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
                        //팔로우버튼
                        Container(
                          width: (MediaQuery.of(context).size.width - 148) / 2,
                          height: 40,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical:0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                )
                              ),
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => profileMain()));
                              }, child: Text(followButtonText,style: TextStyle(color: followButtonTextColor,fontSize: 14.0,),)),
                        ),



                        SizedBox(
                          width: 10.0,
                        ),//팔로우 버튼과 차단 버튼 사이 여백
                        Container(
                          width: (MediaQuery.of(context).size.width - 148) / 2,
                          height: 40,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical:0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(6)),
                                  )
                              ),
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => profileMain()));
                              }, child: Text(blockButtonText,style: TextStyle(color: followButtonTextColor,fontSize: 14.0,),)),
                        ),
                      ],
                    ),

                  ],
                ),
              ],
            ),
          ), //프로필 이미지 내용

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Container(
                  width: halfWidth,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: followbuttonBorderColor,
                        width: 0.5,
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(followerText,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12.0,color: followTextColor),),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>followList()));
                        },
                        child: Text(follower.toString(),style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w700,color: follownumberColor),),
                      )
                    ],
                  ),
                ),
                Container(
                  width: halfWidth,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: followbuttonBorderColor,
                        width: 0.5,
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(followingText,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12.0,color: followTextColor),),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>followList()));
                        },
                        child: Text(following.toString(),style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w700,color: follownumberColor),),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ), //팔로워 , 팔로잉,
          //개최한 건수 리스트 출력
        ],
      ),
      bottomNavigationBar: const BottomAppBar(child: BottomBar()),
    );
  }
}
