import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/screen/mainMap/mainPageMap.dart';

class alarm extends StatefulWidget {
  const alarm({Key? key}) : super(key: key);

  @override
  State<alarm> createState() => _alarmState();
}

class _alarmState extends State<alarm> {
  List<String> alarmList = [
    "000님이 나를 팔로우 합니다.",
    "000님이 나를 팔로우 합니다.",
    "새로운 건수가 3건 등록되었습니다.",
    "강남역에서 불금~! 참가가 승인되었습니다.",
    "강남역에서 불금~! 참가가 거절되었습니다.",
    "강남역에서 불금~!에 새로운 댓글이 달렸습니다.",
    "강남역에서 불금~! 참가 요청을 했습니다.",
  ];

  List<String> alarmtimeList = [
    "방금",
    "1분",
    "3분",
    "5분",
    "7분",
    "9분",
    "05분",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => MainPageMap()));
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('알림',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: alarmList.length,
        itemBuilder: (context, index) {
          final alarmItem = alarmList[index];
          final alarmItem1 = alarmtimeList[index];

          return ListTile(
            leading: CircleAvatar(
              child: Text(alarmItem[0]),
            ),
            title: Text(alarmItem),
            subtitle: Text(alarmItem1),
            onTap: () {
            },
          );
        },
      ),
    );
  }
}

void _inviteapprove(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) =>
        CupertinoAlertDialog(
          content: const Text('000님이 참가를 요청했습니다.\n참가를 승인하시겠습니까?'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('프로필보기'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('승인'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('거절'),
            ),
          ],
        ),
  );
}



