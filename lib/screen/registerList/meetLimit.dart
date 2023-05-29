// 참가 인원 선택 위젯

// 최종 수정일 : 2023.5.28
// 작업자 : 김혁

// 추가 작업 예정 사항

import 'package:flutter/material.dart';

import '../setting/registerMeeting.dart' as meet;
import 'meetFee.dart';

class MeetingLimit extends StatefulWidget {
  const MeetingLimit({Key? key}) : super(key: key);

  @override
  State<MeetingLimit> createState() => _MeetingLimitState();
}

class _MeetingLimitState extends State<MeetingLimit> {
  String numbersOfPeople = "";
  bool enabled = true;
  bool isChecked = false;
  List<bool?> checked = List<bool>.filled(5, false);
  List<String> peoples = ['2명','4명','8명','10명','무제한'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        enabled? Column(
            children: [
              meet.Title(content:"몇명이서 만날까요?"),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  5,
                  (index) => Container(
                    margin: const EdgeInsets.fromLTRB(24, 5, 24, 5),
                    height: 54,
                    child: CheckboxListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      tileColor: const Color(0xFFF7F8FA),
                      checkboxShape: const CircleBorder(),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(peoples[index], style: const TextStyle(
                          color: Color(0xFF1F2024),
                          fontFamily: "PretendardBold",
                          fontSize: 16
                      )),
                      value: checked[index],
                      onChanged: (bool? value){
                        setState(() {
                          checked[index] = value;
                          numbersOfPeople = peoples[index];
                          enabled = false;
                          isChecked = true;
                          meet.meetInfo.peopleLimit = index;
                        });
                      },
                    ),
                  )),
              ),
            ]
        ): Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: TextButton(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(numbersOfPeople,
                  style: const TextStyle(
                      fontFamily: "PretendardBold",
                      fontSize:15,
                      color: Color(0xFF2F3036))
              ),
            ),
            onPressed: () {
              setState(() {
                enabled = true;
                checked = List<bool?>.filled(5, false);
              });
            },
          ),
        ),
        isChecked? MeetingFee()
            : const SizedBox.shrink(),
      ],
    );
  }
}