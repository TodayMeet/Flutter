// 비용 선택 위젯

// 최종 수정일 : 2023.5.28
// 작업자 : 김혁

// 추가 작업 예정 사항

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../setting/registerMeeting.dart' as meet;
import 'meetTitle.dart';

class MeetingFee extends StatefulWidget {
  const MeetingFee({Key? key}) : super(key: key);

  @override
  State<MeetingFee> createState() => _MeetingFeeState();
}

class _MeetingFeeState extends State<MeetingFee> {
  int fee = 0;
  bool enabled = true;
  bool isChecked = false;
  bool isPressed = true;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        enabled? Column(
            children: [
              meet.Title(content:"참가비는 얼마인가요?"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: 46,
                      margin: EdgeInsets.fromLTRB(24, 10, 12, 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: isPressed? const MaterialStatePropertyAll<Color>(Color(0xFF4874EA))
                              :const MaterialStatePropertyAll<Color>(Color(0xFFB6B6B6)),
                        ),
                        onPressed: (){
                          setState(() {
                            isPressed = true;
                            fee = 0;
                          });
                        },
                        child: const Center(child: Text('없음', style: TextStyle(
                            fontFamily: 'PretendardBold', color: Colors.white, fontSize: 16
                        ))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 46,
                      margin: EdgeInsets.fromLTRB(12, 10, 24, 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: isPressed? const MaterialStatePropertyAll<Color>(Color(0xFFB6B6B6))
                              :const MaterialStatePropertyAll<Color>(Color(0xFF4874EA)),
                        ),
                        onPressed: (){
                          setState(() {
                            isPressed = false;
                          });
                        },
                        child: const Center(child: Text('있음', style: TextStyle(
                            fontFamily: 'PretendardBold', color: Colors.white, fontSize: 16
                        ))),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                height: 48,
                margin: const EdgeInsets.fromLTRB(24, 5, 24, 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6FA),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '참가비를 입력해주세요.',
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
                margin: const EdgeInsets.fromLTRB(24, 5, 24, 5),
                child: TextButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFF0F1F5)),
                    alignment: Alignment.center,
                  ),
                  child: const Text("다음",
                      style: TextStyle(
                          color: Color(0xFF2F3036),
                          fontSize: 14,
                          fontFamily: 'PretendardBold')
                  ),
                  onPressed: (){
                    setState(() {
                      if(isPressed == true){
                        fee = 0;
                      }else{
                        fee = int.parse(controller.text);
                      }
                      meet.meetInfo.fee = fee;
                      isChecked = true;
                      enabled = false;
                    });
                  },
                ),
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
              child: Text(fee.toString(),
                  style: const TextStyle(
                      fontFamily: "PretendardBold",
                      fontSize:16,
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
        isChecked? MeetingTitle()
            : const SizedBox.shrink(),
      ],
    );
  }
}