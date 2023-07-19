// 건수 등록 페이지

// 최종 수정일 : 2023.7.19
// 작업자 : 김혁

import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../registerList/meetCategory.dart';
import '../registerList/meetLocation.dart';

class MeetingInfo{
  MeetingInfo();

  late String categoryName;
  late String address;
  late String lat;
  late String lon;
  late String time;
  late bool age;
  late int peopleLimit;
  late int fee;
  late String title;
  late String content;
  late List<XFile> imagefiles;
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
                  fontWeight: FontWeight.w700)),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          /*leading: IconButton(
              onPressed: () {
              },
              color: Colors.black,
              icon: SvgPicture.asset(
                "assets/icons/back_icon.svg",
                height: 24,
                width: 24,
              )
          ),*/
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
                margin: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 2.0),
                alignment: Alignment.centerLeft,
                child: const Text("어떤 건 수를\n등록해 볼까요?",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Color(0xff2f3036)
                  )
                ),
              ),
              const MeetingCategory(),
              const MeetingLocation(),
            ],
          ),
        ),
      ),
    );
  }
}

// 각각의 제목 출력 위젯
class Title extends StatelessWidget {
  final String content;

  const Title({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12.0),
      alignment: Alignment.centerLeft,
      child: Text(content,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 24,
          color: Color(0xff2f3036))),
    );
  }
}