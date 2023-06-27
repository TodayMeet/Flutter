import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'package:front/model/dialogEx/dialoglist.dart';
import 'package:front/screen/profile/blockManage.dart';
import 'package:front/screen/profile/followList.dart';
import 'package:front/screen/profile/hostEvent.dart';
import 'package:front/screen/profile/joinEvent.dart';
import 'package:front/screen/profile/noticeList.dart';
import 'package:front/screen/profile/oftenQuestion.dart';

import 'package:front/screen/profile/profileEdit.dart';
import 'package:front/screen/profile/profileFavorite.dart';
import 'package:front/screen/profile/pwChange.dart';
import 'package:front/screen/profile/question.dart';
import 'package:front/screen/profile/secession.dart';
import 'package:front/screen/profile/termsofUse.dart';
import 'package:front/screen/profile/userProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/bottomBar.dart';
import '../../model/dialogEx/CustomDialog.dart';
import '../../model/profile/CustomAppBar.dart';
import '../login/login.dart';

class profileMain extends StatefulWidget {
  const profileMain({Key? key}) : super(key: key);

  @override
  State<profileMain> createState() => _profileMainState();
}

class _profileMainState extends State<profileMain> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> menu = [
    {"name": '개최한 건수', 'goto': hostEvent()},
    {"name": '참가한 건수', 'goto': joinEvent()},
    {"name": '비밀번호 변경', 'goto': pwChange()},
    {"name": '차단 관리', 'goto': blockManage()},
    {"name": '관심사', 'goto': profileFavorite()},
    {"name": 'FAQ', 'goto': oftenQuestion()},
    {"name": '문의하기', 'goto': question()},
    {"name": '공지사항', 'goto': noticeList()},
    {"name": '개인정보처리방침', 'goto': privatePolicy()},
    {"name": '이용약관', 'goto': termsofUse()},
    {"name": '다른 유저 프로필 임시', 'goto': userProfile()}
  ];
  int follower = 100;
  int following = 100;
  String name = '돌고래밥';
  String gender = '남';
  String birthdate = '2000.03.01';
  String appbarText = '내정보';
  String logoutbuttonText = '로그아웃';
  String followerText = '팔로워';
  String followingText = '팔로잉';
  String versionText = 'V 1.0.0';
  String profileEditButtonText = '프로필 수정';
  String fowardarrow = 'assets/images/ProfileImage/fowardarrow.svg';

  Color appbarBackgroundColor = Color(0xFFFFFFFF);
  Color appbarBorderColor = Color(0xFFE4E4E4);
  Color followbuttonBorderColor = Color(0xFFCACACA);
  Color logoutbuutonTextColor = Color(0xFFA7A8A9);
  Color followTextColor = Color(0xFFA7A8A9);
  Color secessionTextcolor = Color(0xFFA7A8A9);
  Color scaffoldBakgroundColor = Color(0xFFFFFFFF);
  Color profileEditTextColor = Color(0xFF666666);
  Color follownumberColor = Color(0xFF1F2024);
  double logoutbuttonTextsize = 12.0;
  double appbarHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    double halfWidth = MediaQuery.of(context).size.width / 2;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
      backgroundColor: scaffoldBakgroundColor,
      appBar: AppBar(
        toolbarHeight: appbarHeight,
        backgroundColor: appbarBackgroundColor,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: appbarBorderColor,
            height: 1.0,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              twobutton.logoutDialog(context);
            },
            child: Text(
              logoutbuttonText,
              style: TextStyle(
                  color: logoutbuutonTextColor,
                  fontSize: logoutbuttonTextsize,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
        title: Text(
          appbarText,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ), //Appbar
      body: Scrollbar(
        controller: _scrollController,
        child: ListView(
          controller: _scrollController,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage:
                        AssetImage("assets/images/Loginimage/googlelogin.png"),
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
                              color: Color(0xFF1F2024),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 138,
                        height: 40.0,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => profileEdit()));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                profileEditButtonText,
                                style: TextStyle(
                                  color: profileEditTextColor,
                                  fontSize: 14.0,
                                ),
                              ),
                              SvgPicture.asset(fowardarrow,semanticsLabel: 'Button',
                                fit: BoxFit.contain,),
                            ],
                          ),
                        ),
                      )
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
            ), //팔로워 팔로잉


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: menu.length,
                      itemBuilder: (context, index) {
                        final item = menu[index];
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Color(0xFFE3E3E3), width: 1.0),
                            ),
                          ),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 12.0),
                                child: Text(
                                  item['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                iconSize: 16,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => item['goto']),
                                  );
                                },
                                icon: Icon(Icons.arrow_forward_ios),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ), //메뉴
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => secession()));

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => secession()),
                          );
                        }, child: Text('탈퇴신청',style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.w700,color: secessionTextcolor),)),
                      ],
                    ),
                  ), //탈퇴신청
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Center(
                      child: Text(
                        versionText,
                        style: TextStyle(
                            color: Color(0xFFA7A8A9),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ), //메뉴
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(child: BottomBar()),
    );
  }
}

// void _clearLoginCredentials() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.remove('username');
//   await prefs.remove('password');
// } //로그아웃

