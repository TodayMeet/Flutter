import 'package:flutter/material.dart';
import 'package:front/screen/profile/profileMain.dart';

import '../../model/bottomBar.dart';
import '../login/registerProfile.dart';

class userProfile extends StatefulWidget {
  const userProfile({Key? key}) : super(key: key);

  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  String name = '000';
  String gender = '여';
  String birthdate = '2000.07.19';
  int follower = 100;
  int following = 100;

  @override
  Widget build(BuildContext context) {
    double halfWidth = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Color(0xFFE3E3E3), // 테두리 선의 색상
            height: 1.0, // 테두리 선의 높이
          ),
        ),
        leading: IconButton(
            iconSize: 14.93,
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => profileMain()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF2F2F2F),
            )),
        //leading아이콘 혹시나 필요하면

        title: Text(
          name + '님의 프로필',
          style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        ),

        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(),
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 148)/2,
                          height: 40.0,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              '팔로우',
                              style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: 14.0,
                                  ),
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
                              shape:
                                  MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(6.0), // 테두리 둥글기 지정
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0,),
                      Padding(
                        padding: const EdgeInsets.only(),
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 120)/2,
                          height: 40.0,
                          child: ElevatedButton(
                            onPressed: () {

                            },
                            child: Text(
                              '차단',
                              style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: 14.0,
                                  ),
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
                              shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(6.0), // 테두리 둥글기 지정
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 24.0,)
                ],
              ),
            ],
          ), //프로필 이미지 내용
          SizedBox(
            height: 12,
          ), //중간여백
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
                            color: Color(0xFFA7A8A9),
                            fontWeight: FontWeight.w700),
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
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                          color: Color(0xFFA7A8A9),
                        ),
                      ),
                      Text(
                        following.toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700, // 텍스트의 크기
                          color: Color(0xFF1F2024), // 텍스트의 색상
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ), //팔로워 , 팔로잉,
          //개최한 건수 리스트 출력
        ],
      ),
      bottomNavigationBar: const BottomAppBar(child: BottomBar()),
    );
  }
}
