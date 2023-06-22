import 'package:flutter/material.dart';
import 'package:front/model/TextPrint.dart';

import 'profileMain.dart';
// import 'mainListView.dart';



class joinEvent extends StatefulWidget {
  const joinEvent({Key? key}) : super(key: key);

  @override
  State<joinEvent> createState() => _joinEventState();
}

class _joinEventState extends State<joinEvent> {
  String appbarText = '참여한 건수';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        leading: IconButton(
            iconSize: 14.93,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => profileMain()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF2F2F2F),
            )),
        //leading아이콘 혹시나 필요하면

        title: Text(appbarText,
          style: TextStyle(fontSize: 16.0,color: Colors.black,fontFamily: 'PretendardBold'),
        ),

        centerTitle: true,
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
