import 'package:flutter/material.dart';
import 'package:front/model/UI/widget/button/WhiteButton.dart';
import 'package:front/screen/profile/profileMain.dart';

import '../../data/designconst/constants.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';
import '../../model/bottomBar.dart';


import 'followList.dart';

class userProfile extends StatefulWidget {
  const userProfile({Key? key}) : super(key: key);

  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  String name = '이름';
  String gender = '성별';
  String birthdate = '2000.07.19';
  int follower = 100;
  int following = 100;







  @override
  Widget build(BuildContext context) {
    double halfWidth = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => profileMain()));
          },
        ),
        title: name + '님의 프로필',
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
                        nameGender(name: name, gender: gender),
                        SizedBox(
                          width: 8.0,
                        ),
                        birthDate(birthdate: birthdate),
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

                        // Container(
                        //   width: (MediaQuery.of(context).size.width - 148) / 2,
                        //   height: 40,
                        //   child: OutlinedButton(
                        //       style: OutlinedButton.styleFrom(
                        //           padding: EdgeInsets.symmetric(vertical:0),
                        //           shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.all(Radius.circular(6)),
                        //           )
                        //       ),
                        //       onPressed: (){
                        //         // Navigator.push(
                        //         //     context,
                        //         //     MaterialPageRoute(
                        //         //         builder: (context) => profileMain()));
                        //       }, child: Text('차단',style: TextStyle(color: Color(0xFF666666),fontSize: 14.0,),)),
                        // ),
                        whiteButton(
                          buttonText: '차단',
                          onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>profileMain()));
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>followList()));
                        },
                        child: Text(follower.toString(),style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w700,color: Color(0xFF1F2024)),),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>followList()));
                        },
                        child: Text(following.toString(),style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w700,color: Color(0xFF1F2024)),),
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
      bottomNavigationBar: const BottomAppBar(child: BottomBar()),
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
      '${name}(${gender})',
      style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.w700),
    );
  }
}
