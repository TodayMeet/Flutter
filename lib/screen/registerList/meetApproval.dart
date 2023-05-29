// 참가 승인 위젯

// 최종 수정일 : 2023.5.28
// 작업자 : 김혁

// 추가 작업 예정 사항
// 서버로 모임 정보 보내주기


import 'package:flutter/material.dart';

import '../setting/registerMeeting.dart' as meet;

class MeetingApproval extends StatefulWidget {
  const MeetingApproval({Key? key}) : super(key: key);

  @override
  State<MeetingApproval> createState() => _MeetingApprovalState();
}

class _MeetingApprovalState extends State<MeetingApproval> {
  bool enabled = true;
  bool isChecked = false;
  late String _valueApproval;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        enabled? Column(
            children: [
              meet.Title(content:"참가 승인은 어떻게 할까요?"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: 46,
                      margin: EdgeInsets.fromLTRB(20, 0, 10, 20),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFF4874EA)),
                        ),
                        onPressed: (){
                          setState(() {
                            _valueApproval = '자동 승인';
                            meet.meetInfo.approval = true;
                            isChecked = true;
                            enabled = false;
                          });
                        },
                        child: const Center(child: Text('자동 승인', style: TextStyle(
                            fontFamily: 'PretendardBold', color: Colors.white, fontSize: 16
                        ))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 46,
                      margin: EdgeInsets.fromLTRB(10, 0, 20, 20),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFB6B6B6)),
                        ),
                        onPressed: (){
                          setState(() {
                            _valueApproval = '확인 후 승인';
                            meet.meetInfo.approval = false;
                            isChecked = true;
                            enabled = false;
                          });
                        },
                        child: const Center(child: Text('확인 후 승인', style: TextStyle(
                            fontFamily: 'PretendardBold', color: Colors.white, fontSize: 16
                        ))),
                      ),
                    ),
                  ),
                ],
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
              child: Text(_valueApproval,
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
        isChecked?  Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12)),
          height: 46,
          width: size.width,
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: TextButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFF0F1F5)),
              alignment: Alignment.center,
            ),
            onPressed: (){
              print('category : '+meet.meetInfo.categoryName);
              print('time : '+meet.meetInfo.time);
              print('age : '+ meet.meetInfo.age.toString());
              print('peopleLimit : '+meet.meetInfo.peopleLimit.toString());
              print('fee : '+meet.meetInfo.fee.toString());
              print('title : '+meet.meetInfo.title);
              print('content : '+meet.meetInfo.content);
              print('approval : '+meet.meetInfo.approval.toString());
            },
            child: const Text('등록 완료',
              style: TextStyle(
                color: Color(0xFF2F3036),
                fontSize: 14,
                fontFamily: 'PretendardBold'
              ),
            ),
          ),
        ) : const SizedBox.shrink(),
      ],
    );
  }
}
