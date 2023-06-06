// 메인 페이지 하단 바

// 최종 수정일 : 2023.5.28
// 작업자 : 김혁

// 추가 작업 예정 사항
// 페이지 생성 되면 각 페이지로 하단바 연결

import 'package:flutter/material.dart';
import 'package:front/screen/chat/chatlist.dart';
import 'package:front/screen/setting/registerMeeting.dart';
import '../screen/profile/profileMain.dart';
import '../screen/search/searchMain.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Image.asset(
            "assets/images/Bottombar/Bottombar_first.png",
            scale: 4,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Image.asset("assets/images/Bottombar/Bottombar_second.png",
              scale: 4),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SearchMain()));
          },
        ),
        IconButton(
          icon: Image.asset("assets/images/Bottombar/Bottombar_center.png",
              scale: 4),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterMeeting()));
          },
        ),
        IconButton(
          icon: Image.asset("assets/images/Bottombar/Bottombar_third.png",
              scale: 4),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => chatlist()));
          },
        ),
        IconButton(
          icon: Image.asset("assets/images/Bottombar/Bottombar_fourth.png",
              scale: 4),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => profileMain()));
          },
        ),
      ],
    );
  }
}
