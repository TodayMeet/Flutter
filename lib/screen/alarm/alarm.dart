// 알림창 페이지

// 최종 수정일 : 2023.7.11
// 작업자 : 남재혁 -> 김혁

// 추가 작업 예정 사항

import 'package:flutter/material.dart';
import 'package:front/data/dummy_meetList.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../model/UI/widget/customAppBar.dart';
import '../../model/showtoast.dart';
import '../../data/alarm/alarmMessage.dart';
import '../../data/alarm/indexProcess.dart';
import '../../data/dummy_meetList.dart';
import '../mainList/Loading_to_mainListBoard.dart';
import '../profile/userProfile.dart';

class alarm extends StatefulWidget {
  const alarm({Key? key}) : super(key: key);

  @override
  State<alarm> createState() => _alarmState();
}

class _alarmState extends State<alarm> {

  // 게시판 컨트롤러
  RefreshController alarmrefreshController = RefreshController(initialRefresh: true);

  // 현재 알림 리스트
  List<Alarm> tempAlarm = [];

  // 서버에서 알림 리스트 받아오기
  Future<void> getAlarmList() async {
    try {
      final url = Uri.parse(
          "http://todaymeet.shop:8080/notifi/all?userNo=${tempUser["userNo"]}");

      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        tempAlarm = [];
        List<dynamic> serverData = json.decode(utf8.decode(response.bodyBytes));
        print(serverData);
        serverData.forEach((element) => tempAlarm.add(Alarm.fromJson(element)));
        setState(() {});
      }else{
        print('서버 통신 오류');
        showToast('서버 통신 오류');
      }
    }catch(e) {
      print('알림 오류');
      showToast('알림 오류');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        automaticallyImplyLeading: false,
        title: '알림',
        actionWidget: null,
      ),
      body: SmartRefresher(
        controller: alarmrefreshController,
        enablePullUp: false,
        enablePullDown: true,
        onRefresh: () async {
          await getAlarmList();
          print(tempAlarm);

          alarmrefreshController.refreshCompleted();
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView.builder(
            itemCount: tempAlarm.length,
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: (){
                  pageTransition(context, tempAlarm[index].notiType,
                      tempAlarm[index].userNumber, tempAlarm[index].meetNumber, tempAlarm[index].name);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFFF7F8FA),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 알림창 사진
                      ClipOval(
                        child: Image.network(
                          tempAlarm[index].imageLink,
                          height: 36,
                          width: 36,
                        ),
                      ),
                      const SizedBox(width: 12),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 알림 메세지
                          SizedBox(
                            width: 250,
                              child: alarmMessage(tempAlarm[index].notiType, tempAlarm[index].name)),
                          const SizedBox(height:4),

                          // 시간
                          Text(
                            tempAlarm[index].time,
                            style: const TextStyle(
                              color: Color(0xFF949596),
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      )
    );
  }
}