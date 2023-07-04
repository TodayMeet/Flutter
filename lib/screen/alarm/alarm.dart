import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../model/UI/widget/customAppBar.dart';
import '../mainList/Loading_to_mainListBoard.dart';
import '../profile/userProfile.dart';

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
      'num': 1,
      'image':'assets/images/User_Picture/User_pic_sample7.png'
    },
    {
      'name': "000님이 나를 팔로우 합니다.",
      'time': '1분',
      'categories': 'follow',
      'num': 1,
      'image':'assets/images/User_Picture/User_pic_sample6.png'
    },
    {
      'name': "새로운 건수가 3건 등록되었습니다.",
      'time': '3분',
      'categories': 'newEvent',
      'num': 2,
      'image':'assets/images/User_Picture/User_pic_sample5.png'
    },
    {
      'name': "강남역에서 불금~! 참가가 승인되었습니다.",
      'time': '5분',
      'categories': 'approved',
      'num': 3,
      'image':'assets/images/User_Picture/User_pic_sample6.png'
    },
    {
      'name': "강남역에서 불금~! 참가가 거절되었습니다.",
      'time': '7분',
      'categories': 'denied',
      'num': 4,
      'image':'assets/images/User_Picture/User_pic_sample6.png'
    },
    {
      'name': "강남역에서 불금~!에 새로운 댓글이 달렸습니다.",
      'time': '9분',
      'categories': 'comment',
      'num': 5,
      'image':'assets/images/User_Picture/User_pic_sample6.png'
    },
    {
      'name': "강남역에서 불금~!에서 참가 요청을 했습니다.",
      'time': '11분',
      'categories': 'invite',
      'num': 6,
      'image':'assets/images/User_Picture/User_pic_sample6.png'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        title: '알림',
        actionWidget: null,
      ),
      body: ListView.builder(
        itemCount: alarm.length,
        itemBuilder: (context, index) {
          final items = alarm[index];
          final alarmCategory = alarm[index]['num'];//0xFFF7F8FA

          return ListTile(
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(

                  shape: BoxShape.circle,
                ),
                child: Image.asset(items['image'],fit: BoxFit.cover),
              ),

              title: Text(items['name']),
              subtitle: Text(items['time']),
              onTap: () {

              });
        },
      ),
    );
  }
}
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