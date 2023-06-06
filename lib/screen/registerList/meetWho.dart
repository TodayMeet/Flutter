// 참가 나이 선택 위젯

// 최종 수정일 : 2023.5.28
// 작업자 : 김혁

// 추가 작업 예정 사항

import 'package:flutter/material.dart';

import '../setting/registerMeeting.dart' as meet;
import 'meetLimit.dart';

class MeetingWho extends StatefulWidget {
  const MeetingWho({Key? key}) : super(key: key);

  @override
  State<MeetingWho> createState() => _MeetingWhoState();
}

class _MeetingWhoState extends State<MeetingWho> {
  bool enabled = true;
  bool isChecked = false;
  late String _valueWho;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        enabled? Column(
            children: [
              meet.Title(content:"누구와 만날까요?"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: 46,
                      margin: const EdgeInsets.fromLTRB(24, 0, 5, 20),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFF4874EA)),
                        ),
                        onPressed: (){
                          setState(() {
                            _valueWho = '누구나';
                            meet.meetInfo.age = false;
                            isChecked = true;
                            enabled = false;
                          });
                        },
                        child: const Center(child: Text('누구나', style: TextStyle(
                            fontFamily: 'PretendardBold', color: Colors.white, fontSize: 16
                        ))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 46,
                      margin: const EdgeInsets.fromLTRB(5, 0, 24, 20),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFB6B6B6)),
                        ),
                        onPressed: (){
                          setState(() {
                            _valueWho = '또래만';
                            meet.meetInfo.age = true;
                            isChecked = true;
                            enabled = false;
                          });
                        },
                        child: const Center(child: Text('또래만', style: TextStyle(
                            fontFamily: 'PretendardBold', color: Colors.white, fontSize: 16
                        ))),
                      ),
                    ),
                  ),
                ],
              ),
            ]
        ): Container(
          margin: const EdgeInsets.fromLTRB(24, 5, 24, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: TextButton(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(_valueWho,
                  style: const TextStyle(
                      fontFamily: "PretendardBold",
                      fontSize:15,
                      color: Color(0xFF2F3036))
              ),
            ),
            onPressed: () {
              setState(() {
                enabled = true;
              });
            },
          ),
        ),
        isChecked? MeetingLimit()
            : const SizedBox.shrink(),
      ],
    );
  }
}
