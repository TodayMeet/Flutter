// 내용 입력 위젯

// 최종 수정일 : 2023.6.26
// 작업자 : 김혁

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
              const meet.Title(content:"내용을 입력해주세요."),

              // 내용 입력 창
              Container(
                height: 140,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6FA),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: TextField(
                  maxLength: 500,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    counterText: '',
                    border: InputBorder.none,
                    hintText: '500자 내 텍스트 입력 가능',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFFC8C8CB),
                      letterSpacing: -0.5,
                    ),
                  ),
                  controller: controller,
                  maxLines: null,
                  expands: true,
                ),
              ),

              // 다음 버튼
              Container(
                height: 46,
                width: size.width,
                margin: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFF0F1F5)),
                    alignment: Alignment.center,
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                    )
                  ),
                  onPressed: (){
                    setState(() {
                      content = controller.text;
                      meet.meetInfo.content = content;
                      print(meet.meetInfo.content);
                      enabled = false;
                      isChecked = true;
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
        ): Container(                               // 입력 완료 후 출력 버튼
          margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            border: Border.all(
                color: const Color(0xFFC5C6CC),
                width: 1),
          ),
          child: TextButton(
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                EdgeInsets.all(16),
              )
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(content,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize:14,
                      color: Color(0xFF2F3036),
                      letterSpacing: -0.5,
                  ),
              ),
            ),
            onPressed: () {
              setState(() {
                enabled = true;
              });
            },
          ),
        ),
        isChecked? const MeetingImage()
            : const SizedBox.shrink(),
      ],
    );
  }
}
