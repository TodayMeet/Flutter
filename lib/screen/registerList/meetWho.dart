// 참가 나이 선택 위젯

// 최종 수정일 : 2023.6.26
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
              const meet.Title(content:"누구와 만날까요?"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 누구나 버튼
                  Expanded(
                    child: Container(
                      height: 46,
                      margin: const EdgeInsets.fromLTRB(24, 0, 5, 12),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFF4874EA)),
                          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                          ),
                        ),
                        onPressed: (){
                          setState(() {
                            _valueWho = '누구나';
                            meet.meetInfo.age = false;
                            isChecked = true;
                            enabled = false;
                          });
                        },
                        child: const Center(
                          child: Text('누구나',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            )
                          )
                        ),
                      ),
                    ),
                  ),

                  // 또래만 버튼
                  Expanded(
                    child: Container(
                      height: 46,
                      margin: const EdgeInsets.fromLTRB(5, 0, 24, 12),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFB6B6B6)),
                          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                          ),
                        ),
                        onPressed: (){
                          setState(() {
                            _valueWho = '또래만';
                            meet.meetInfo.age = true;
                            isChecked = true;
                            enabled = false;
                          });
                        },
                        child: const Center(
                          child: Text('또래만',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            )
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]
        ): Container(                             // 버튼 선택 완료 후 출력 버튼
          margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
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
              child: Text(_valueWho,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize:15,
                      color: Color(0xFF2F3036),
                      letterSpacing: -0.5,
                  )
              ),
            ),
            onPressed: () {
              setState(() {
                enabled = true;
              });
            },
          ),
        ),
        isChecked? const MeetingLimit()
            : const SizedBox.shrink(),
      ],
    );
  }
}
