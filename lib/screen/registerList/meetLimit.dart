// 참가 인원 선택 위젯

// 최종 수정일 : 2023.6.26
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
                    margin: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                    height: 54,
                    child: CheckboxListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      activeColor: const Color(0xFF5881EB),
                      tileColor: const Color(0xFFF7F8FA),
                      checkboxShape: const CircleBorder(),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(peoples[index],
                          style: const TextStyle(
                            color: Color(0xFF1F2024),
                            fontWeight: FontWeight.w700,
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
          margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            border: Border.all(
                color: const Color(0xFFC5C6CC),
                width: 1
            ),
          ),
          child: TextButton(
            style: const ButtonStyle(
                padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                  EdgeInsets.all(16),
                )
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(numbersOfPeople,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize:14,
                      color: Color(0xFF2F3036),
                      letterSpacing: -0.5
                  )
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
        isChecked? const MeetingFee()
            : const SizedBox.shrink(),
      ],
    );
  }
}