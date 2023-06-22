import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/model/dialogEx/logoutDialog.dart';
import 'package:front/screen/login/favorite.dart';
import 'package:front/screen/login/registerProfile.dart';
import 'package:front/screen/mainMap/mainPageMap.dart';
import 'package:front/screen/profile/blockManage.dart';
import 'package:front/screen/profile/hostEvent.dart';
import 'package:front/screen/profile/joinEvent.dart';
import 'package:front/screen/profile/noticeList.dart';
import 'package:front/screen/profile/oftenQuestion.dart';
import 'package:front/screen/profile/privatePolicy.dart';
import 'package:front/screen/profile/profileFavorite.dart';
import 'package:front/screen/profile/pwChange.dart';
import 'package:front/screen/profile/question.dart';
import 'package:front/screen/profile/secession.dart';
import 'package:front/screen/profile/termsofUse.dart';
import 'package:front/screen/profile/userProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/bottomBar.dart';
import '../login/login.dart';

class profileMain extends StatefulWidget {
  const profileMain({Key? key}) : super(key: key);

  @override
  State<profileMain> createState() => _profileMainState();
}

class _profileMainState extends State<profileMain> {
  int follower = 100;
  int following = 100;
  String name = '돌고래밥';
  String gender = '남';
  String birthdate = '2000.03.01';
  
  @override
  Widget build(BuildContext context) {
    double halfWidth = MediaQuery.of(context).size.width / 2;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color : Color(0xFFE3E3E3), // 테두리 선의 색상
            height: 1.0, // 테두리 선의 높이
          ),
        ),
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => MainPageMap()));
        //     },
        //     icon: Icon(
        //       Icons.arrow_back_ios,
        //       color: Colors.black,
        //     )),
        //leading아이콘 혹시나 필요하면

        title: Text(
          '내정보',
          style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.w700),
        ),
        actions: [
          TextButton(
            onPressed: () => _logout(context),
            child: Text(
              '로그아웃',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                color: Color(0xFFA7A8A9),
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              SizedBox(
                width: 24,
              ),
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage("assets/images/Loginimage/googlelogin.png"),


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
                          fontWeight: FontWeight.w700
                        ),
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
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 138,
                      height: 40.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => registerProfile(
                                      email: '', password: '')));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '프로필 수정',
                              style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: 14.0,
                                ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF666666),
                              size: 10,
                            ),
                          ],
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          elevation: MaterialStateProperty.all<double>(0),
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(
                                color: Color(0xFFD8D8D8),
                                width: 1.0), // 테두리 색상과 너비 지정
                          ),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(6.0), // 테두리 둥글기 지정
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),//프로필 이미지 내용
          SizedBox(
            height: 12,
          ),//중간여백
          Row(
            children: [
              Container(
                width: halfWidth,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xFFCACACA),
                    width: 0.5,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '팔로워',
                        style: TextStyle(
                          fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                          color: Color(0xFFA7A8A9),

                        ),
                      ),
                      Text(
                        follower.toString(),
                        style: TextStyle(
                          fontSize: 24,
                            fontWeight: FontWeight.w700,
                          color: Color(0xFF1F2024),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: halfWidth,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xFFCACACA),
                    width: 0.5,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '팔로잉',
                        style: TextStyle(

                          fontSize: 12.0,
                          color: Color(0xFFA7A8A9),
                        ),
                      ),
                      Text(
                        following.toString(),
                        style: TextStyle(
                          fontSize: 24,
                            fontWeight: FontWeight.w700,
                          color: Color(0xFF1F2024), // 텍스트의 색상
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),//팔로워 , 팔로잉
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE3E3E3), width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal : 9),
                    child: Text(
                      '개최한 건수',
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
                                builder: (context) => userProfile()));
                      },
                      icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ),//개최한 건수
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE3E3E3), width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal : 9),
                    child: Text(
                      '참가한 건수',
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
                                builder: (context) => joinEvent()));
                      },
                      icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ),//참가한 건수
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE3E3E3), width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal : 9),
                    child: Text(
                      '비밀번호 변경',
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
                                builder: (context) => pwChange()));
                      },
                      icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ),//비밀번호 변경
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE3E3E3), width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal : 9),
                    child: Text(
                      '차단 관리',
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
                                builder: (context) => blockManage()));
                      },
                      icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ),//차단 관리
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE3E3E3), width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal : 9),
                    child: Text(
                      '관심사',
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
                                builder: (context) => proflieFavorite()));
                      },
                      icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ),//관심사
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE3E3E3), width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal : 9),
                    child: Text(
                      'FAQ',
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
                                builder: (context) => oftenQuestion()));
                      },
                      icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ),//FAQ
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE3E3E3), width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal : 9),
                    child: Text(
                      '문의하기',
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
                                builder: (context) => question()));
                      },
                      icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ),//문의하기
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE3E3E3), width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal : 9),
                    child: Text(
                      '공지사항',
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
                                builder: (context) => noticeList()));
                      },
                      icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ),//공지사항
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE3E3E3), width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal : 9),
                    child: Text(
                      '개인정보처리방침',
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
                                builder: (context) => privatePolicy()));
                      },
                      icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ),//개인정보처리방침
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE3E3E3), width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal : 9),
                    child: Text(
                      '이용약관',
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
                                builder: (context) => termsofUse()));
                      },
                      icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ),//이용약관
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => secession()));
                },
                child: Text(
                  '탈퇴신청',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                    color: Color(0xFFA7A8A9),

                    fontSize: 14.0
                  ),
                ),
              ),
              SizedBox(width: 15,)
            ],
          ),
          Spacer(),
          Text(
            'V 1.0.0',
            style: TextStyle(color: Colors.grey,fontSize: 14.0, fontWeight: FontWeight.w700),
          ),//버전
          SizedBox(
            height: 12,
          )//여백
        ],
      ),
      bottomNavigationBar: const BottomAppBar(child: BottomBar()),
    );
  }
}



void _clearLoginCredentials() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('username');
  await prefs.remove('password');
}//로그아웃


void _logout(BuildContext context){
  showDialog(context: context,
      builder: (BuildContext context){
    return logoutDialog();
      },
  );
}