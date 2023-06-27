// 비용 선택 위젯

// 최종 수정일 : 2023.6.26
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 46,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: isPressed? const MaterialStatePropertyAll<Color>(Color(0xFF4874EA))
                                :const MaterialStatePropertyAll<Color>(Color(0xFFB6B6B6)),
                            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                            )
                          ),
                          onPressed: (){
                            setState(() {
                              isPressed = true;
                              fee = 0;
                            });
                          },
                          child: const Center(
                              child: Text('없음',
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
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 46,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: isPressed? const MaterialStatePropertyAll<Color>(Color(0xFFB6B6B6))
                                :const MaterialStatePropertyAll<Color>(Color(0xFF4874EA)),
                            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                            )
                          ),
                          onPressed: (){
                            setState(() {
                              isPressed = false;
                            });
                          },
                          child: const Center(
                              child: Text('있음',
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
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 48,
                margin: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6FA),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    border: InputBorder.none,
                    hintText: '참가비를 입력해주세요.',
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
              Container(
                height: 46,
                width: size.width,
                margin: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFF0F1F5)),
                    alignment: Alignment.center,
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    )
                  ),
                  child: const Text("다음",
                      style: TextStyle(
                          color: Color(0xFF2F3036),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5
                      )
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
              child: Text(fee.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize:14,
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
        isChecked? const MeetingTitle()
            : const SizedBox.shrink(),
      ],
    );
  }
}