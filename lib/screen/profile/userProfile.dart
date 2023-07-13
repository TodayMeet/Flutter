import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:front/model/UI/widget/button/WhiteButton.dart';
import 'package:front/screen/profile/profileMain.dart';

import '../../data/designconst/constants.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';
import '../../model/bottomBar.dart';


import 'followList.dart';

class userProfile extends StatefulWidget {
  final int userNo;
  userProfile ({required this.userNo});

  // const userProfile({Key? key}) : super(key: key);

  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  int userNo = 0;
  String username = '';
  int gender = 0;
  String genderString = '';
  String birth = '2000.07.19';
  int follownum = 100;
  int followingnum = 100;
  String userprofileimage = '';
  int myuserNo = 1;
  bool isFollow = false;



  Future<void> follow() async {
    final url1 = Uri.parse('http://todaymeet.shop:8080/follow/add');
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
    //{username,follownum,followeenum,gender,birth,userpofileimage}
    final requestData = {
      'userNo': widget.userNo,
      'username': username,
      'follownum': follownum,
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
      final responseData = jsonDecode(response.body);
      setState(() {
        userNo = responseData['userNo'];
        userprofileimage = responseData['userProfileImage'];
        username = responseData['username'];
        birth = (responseData['birth'].substring(0,10)).replaceAll('-', '.');

        if (responseData['gender'] == 1) {
          genderString = '(남)';
        } else if (responseData['gender'] == 2) {
          genderString = '(여)';
        }
        follownum = responseData['followNum'];
        followingnum = responseData['followeeNum'];
        print(responseData);

      });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    userInfoLoad();
  }



  @override
  Widget build(BuildContext context) {
    double halfWidth = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed: () {
            // Navigator.pop(context);
            // follow();
          },
        ),
        title: username + '님의 프로필',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:24.0,vertical: 12.0),
            child: Row(
              children: [
                CircleAvatar(
                  //clipoval 씌우기
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
                        nameGender(name: username, gender: genderString),
                        SizedBox(
                          width: 8.0,
                        ),
                        birthDate(birthdate: birth),
                      ],
                    ),//유저이름, 성, 생년월일
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      children: [
                        //팔로우버튼
                        whiteButton(
                          buttonText: '팔로우',
                          onPressed: (){
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context)=>profileMain()));
                          },
                          width: (MediaQuery.of(context).size.width - 148) / 2 ,
                        ),



                        SizedBox(
                          width: 10.0,
                        ),//팔로우 버튼과 차단 버튼 사이 여백


                        whiteButton(
                          buttonText: '차단',
                          onPressed: (){
                            Navigator.pop(context);
                        },
                            width: (MediaQuery.of(context).size.width - 148) / 2 ,
                        )
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
                        color: Color(0xFFCACACA),
                        width: 0.5,
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('팔로워',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12.0,color: Color(0xFFA7A8A9)),),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>followList(userNo: widget.userNo,username: username)));
                        },
                        child: Text(follownum.toString(),style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w700,color: Color(0xFF1F2024)),),
                      )
                    ],
                  ),
                ), //팔로워
                Container(
                  width: halfWidth,
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>followList(userNo: widget.userNo,username: username)));
                        },
                        child: Text(followingnum.toString(),style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w700,color: Color(0xFF1F2024)),),
                      )
                    ],
                  ),
                ),//팔로잉
              ],
            ),
          ), //팔로워 , 팔로잉,
          //개최한 건수 리스트 출력
        ],
      ),

    );
  }
}

class birthDate extends StatelessWidget {
  const birthDate({
    super.key,
    required this.birthdate,
  });

  final String birthdate;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${birthdate} ',
      style: TextStyle(
        color: Colors.black,
        fontSize: 12,
      ),
    );
  }
}

class nameGender extends StatelessWidget {
  const nameGender({
    super.key,
    required this.name,
    required this.gender,
  });

  final String name;
  final String gender;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${name} ${gender}',
      style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.w700),
    );
  }
}
