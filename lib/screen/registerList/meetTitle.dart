// 제목 입력 위젯

// 최종 수정일 : 2023.6.26
// 작업자 : 김혁

// 추가 작업 예정 사항

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../setting/registerMeeting.dart' as meet;
import 'meetContent.dart';

class MeetingTitle extends StatefulWidget {
  const MeetingTitle({Key? key}) : super(key: key);

  @override
  State<MeetingTitle> createState() => _MeetingTitleState();
}

class _MeetingTitleState extends State<MeetingTitle> {
  String title = "";
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
              meet.Title(content:"제목을 입력해주세요."),
              Container(
                height: 48,
                margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6FA),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: TextField(
                  maxLength: 20,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    counterText: '',
                    border: InputBorder.none,
                    hintText: '20자 내 텍스트 입력 가능',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFFC8C8CB),
                      letterSpacing: -0.5,
                    ),
                  ),
                  controller: controller,
                  maxLines: 1,
                ),
              ),
              Container(
                height: 46,
                width: size.width,
                margin: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFF0F1F5)),
                    alignment: Alignment.center,
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    )
                  ),
                  onPressed: (){
                    setState(() {
                      title = controller.text;
                      enabled = false;
                      isChecked = true;
                      meet.meetInfo.title = title;
                    });
                  },
                  child: const Text('다음',
                    style: TextStyle(
                        color: Color(0xFF2F3036),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                    ),
                  ),
                ),
              )
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
              child: Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize:14,
                      color: Color(0xFF2F3036),
                      letterSpacing:-0.5,
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
        isChecked? const MeetingContent()
            : const SizedBox.shrink(),
      ],
    );
  }
}
