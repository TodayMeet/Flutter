import 'package:flutter/material.dart';
import 'package:front/model/TextPrint.dart';

import '../../model/profile/CustomAppBar.dart';
import '../../model/svgbutton/svgbutton.dart';
import 'profileMain.dart';
// import 'mainListView.dart';



class joinEvent extends StatefulWidget {
  const joinEvent({Key? key}) : super(key: key);

  @override
  State<joinEvent> createState() => _joinEventState();
}

class _joinEventState extends State<joinEvent> {
  String appbarText = '참가한 건수';
  String backarrow = 'assets/images/ProfileImage/backarrow.svg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed:() {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profileMain()));},
        ),
        title: appbarText,
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(24), //컨테이너 외부 공백 조절
      //   child: ListView( // 메인 리스트 스크롤 뷰
      //     children: <Widget>[
      //       const SizedBox(height: 24.0,), //
      //       StringText('📣 주변의 새 이벤트', 24, 'PretendardBold', Color(0xff2F3036)),
      //       const SizedBox(height: 19.0,),
      //
      //       mainListView.list(test0), //건수 리스트
      //       mainListView.list(test5),
      //       Advertisement('광고'), //광고 배너
      //       mainListView.list(test6),
      //
      //       StringText('🧭 주변 이벤트', 24, 'PretendardBold', Color(0xff2F3036)),
      //       mainListView.list(test7),
      //     ],
      //   ),
      // ),
    );
  }
}
