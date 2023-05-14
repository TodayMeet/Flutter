// 메인 페이지 하단 바

// 최종 수정일 : 2023.5.8
// 작업자 : 김혁

// 추가 작업 예정 사항
// 페이지 생성 되면 각 페이지로 하단바 연결

import 'package:flutter/material.dart';
import 'package:front/screen/setting/registerMeeting.dart';

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
        IconButton(icon: Image.asset("assets/images/Bottombar/Bottombar_first.png"),onPressed: () {},),
        IconButton(icon: Image.asset("assets/images/Bottombar/Bottombar_second.png"),onPressed: () {},),
        IconButton(icon: Image.asset("assets/images/Bottombar/Bottombar_center.png"),onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => RegisterMeeting()));
          },
        ),
        IconButton(icon: Image.asset("assets/images/Bottombar/Bottombar_third.png"),onPressed: () {},),
        IconButton(icon: Image.asset("assets/images/Bottombar/Bottombar_fourth.png"),onPressed: () {},),
      ],
    );
  }
}
