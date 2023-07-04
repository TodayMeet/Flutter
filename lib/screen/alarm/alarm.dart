import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../model/UI/widget/customAppBar.dart';
import '../mainList/Loading_to_mainListBoard.dart';

class alarm extends StatefulWidget {
  const alarm({Key? key}) : super(key: key);

  @override
  State<alarm> createState() => _alarmState();
}

class _alarmState extends State<alarm> {
  String host = '000';

  List<Map> alarm = [
    {
      'name': "000님이 나를 팔로우 합니다.",
      'time': '방금',
      'categories': 'follow',
      'num': 1
    },
    {
      'name': "000님이 나를 팔로우 합니다.",
      'time': '1분',
      'categories': 'follow',
      'num': 1
    },
    {
      'name': "새로운 건수가 3건 등록되었습니다.",
      'time': '3분',
      'categories': 'newEvent',
      'num': 2
    },
    {
      'name': "강남역에서 불금~! 참가가 승인되었습니다.",
      'time': '5분',
      'categories': 'approved',
      'num': 3
    },
    {
      'name': "강남역에서 불금~! 참가가 거절되었습니다.",
      'time': '7분',
      'categories': 'denied',
      'num': 4
    },
    {
      'name': "강남역에서 불금~!에 새로운 댓글이 달렸습니다.",
      'time': '9분',
      'categories': 'comment',
      'num': 5
    },
    {
      'name': "강남역에서 불금~!에서 참가 요청을 했습니다.",
      'time': '11분',
      'categories': 'invite',
      'num': 6
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '알림',
        actionWidget: null,
        leadingWidget: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            icon: SvgPicture.asset(
              "assets/icons/back_icon.svg",
              height: 24,
              width: 24,
            )
        ),
      ),
      body: ListView.builder(
        itemCount: alarm.length,
        itemBuilder: (context, index) {
          final items = alarm[index];
          final alarmCategory = alarm[index]['num'];

          return ListTile(
              leading: CircleAvatar(
                child: Text(items['name'][0]),
              ),
              title: Text(items['name']),
              subtitle: Text(items['time']),
              onTap: () {
                // switch(alarmCategory){
                //   case 1:
                //     Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => userProfile()));
                //     break;
                //   case 2:
                //     Navigator.push(context,
                //         MaterialPageRoute(
                //             builder: (context) => Loading_to_mainListBoard()));
                //     break;
                //   case 3:
                //     Navigator.push(context,
                //         MaterialPageRoute(
                //             builder: (context) => userProfile()));
                //   case 4:
                //     Navigator.push(context,
                //         MaterialPageRoute(
                //             builder: (context) => Loading_to_mainListBoard()));
                //   case 5:
                //     Navigator.push(context,
                //         MaterialPageRoute(
                //             builder: (context) => Loading_to_mainListBoard()));
                //   case 6:
                //     Navigator.push(context,
                //         MaterialPageRoute(
                //             builder: (context) => Loading_to_mainListBoard()));
                // }
              });
        },
      ),
    );
  }
}
