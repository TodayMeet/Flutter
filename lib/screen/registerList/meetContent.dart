// 내용 입력 위젯

// 최종 수정일 : 2023.5.28
// 작업자 : 김혁

// 추가 작업 예정 사항
// 이미지 선택 위젯 완성되면 거기에 연결하기

import 'package:flutter/material.dart';
import 'package:front/screen/registerList/meetApproval.dart';

import '../setting/registerMeeting.dart' as meet;
import 'meetImage.dart';

class MeetingContent extends StatefulWidget {
  const MeetingContent({Key? key}) : super(key: key);

  @override
  State<MeetingContent> createState() => _MeetingContentState();
}

class _MeetingContentState extends State<MeetingContent> {
  String content = "";
  bool enabled = true;
  bool isChecked = false;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        enabled? Column(
            children: [
              meet.Title(content:"내용을 입력해주세요."),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                height: 140,
                margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6FA),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: TextField(
                  maxLength: 500,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    hintText: '500자 내 텍스트 입력 가능',
                    hintStyle: TextStyle(
                      fontFamily: "PretendardRegular",
                      fontSize: 14,
                      color: Color(0xFFC8C8CB),
                    ),
                  ),
                  controller: controller,
                  maxLines: null,
                  expands: true,
                ),
              ),
              Container(
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
                    setState(() {
                      content = controller.text;
                      enabled = false;
                      isChecked = true;
                      meet.meetInfo.content = content;
                    });
                  },
                  child: const Text('다음',
                    style: TextStyle(
                        color: Color(0xFF2F3036),
                        fontSize: 14,
                        fontFamily: 'PretendardBold'
                    ),
                  ),
                ),
              )
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
              child: Text(content,
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
        isChecked? const MeetingApproval()
            : const SizedBox.shrink(),
      ],
    );
  }
}
