// 건수 등록 페이지

// 최종 수정일 : 2023.5.28
// 작업자 : 김혁

// 추가 작업 예정 사항

import 'package:flutter/material.dart';

import 'package:front/model/bottomBar.dart';
import '../registerList/meetCategory.dart';
import '../registerList/meetLocation.dart';

class MeetingInfo{
  MeetingInfo();

  late int categoryNo;
  late String address;
  late String lat;
  late String lon;
  late String time;
  late bool age;
  late int peopleLimit;
  late int fee;
  late String title;
  late String content;
  late bool approval;
  late int userNo;
}

MeetingInfo meetInfo = MeetingInfo();

class RegisterMeeting extends StatefulWidget {
  const RegisterMeeting({Key? key}) : super(key: key);

  @override
  State<RegisterMeeting> createState() => _RegisterMeetingState();
}

class _RegisterMeetingState extends State<RegisterMeeting> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('오늘의 건수등록',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'PretendardBold')),
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black,
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Scrollbar(
          controller: _scrollController,
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 5.0),
                height: 70,
                alignment: Alignment.centerLeft,
                child: const Text("어떤 건 수를\n등록해 볼까요?", style: TextStyle(
                    fontFamily:"PretendardRegular",
                    fontSize: 24,
                    color: Color(0xff2f3036))),
              ),
              const MeetingCategory(),
              const MeetingLocation(),
            ],
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          child: BottomBar()
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String content;

  Title({required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 6.0),
      alignment: Alignment.centerLeft,
      child: Text(content, style: const TextStyle(
          fontFamily: "PretendardRegular",
          fontSize: 23,
          color: Color(0xff2f3036))),
    );
  }
}