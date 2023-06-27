// 참가 승인 위젯

// 최종 수정일 : 2023.6.26
// 작업자 : 김혁

// 추가 작업 예정 사항

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  void _registerMeet() async {
    final url = Uri.parse("http://todaymeet.shop:8080/meet/add");
    final Map<String, dynamic> jsonData = {
      'category':{
        'categoryNo': meet.meetInfo.categoryNo
      },
      'address' : meet.meetInfo.address,
      'lat' : meet.meetInfo.lat,
      'lon' : meet.meetInfo.lon,
      'time' : meet.meetInfo.time,
      'age' : meet.meetInfo.age,
      'peopleLimit' : meet.meetInfo.peopleLimit,
      'fee' : meet.meetInfo.fee,
      'title' : meet.meetInfo.title,
      'content' : meet.meetInfo.content,
      'approval' : meet.meetInfo.approval,
      'user': {
        'userNo' : 1
      },
    };

    final response = await http.post(
      url,
      headers: {'Content-Type' : 'application/json'},
      body: json.encode(jsonData),
    );

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        enabled? Column(
            children: [
              meet.Title(content:"참가 승인은 어떻게 할까요?"),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 46,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFF4874EA)),
                            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                            )
                          ),
                          onPressed: (){
                            setState(() {
                              _valueApproval = '자동 승인';
                              meet.meetInfo.approval = true;
                              isChecked = true;
                              enabled = false;
                            });
                          },
                          child: const Center(
                              child: Text('자동 승인',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 16,
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
                            backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFB6B6B6)),
                            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                            )
                          ),
                          onPressed: (){
                            setState(() {
                              _valueApproval = '확인 후 승인';
                              meet.meetInfo.approval = false;
                              isChecked = true;
                              enabled = false;
                            });
                          },
                          child: const Center(
                            child: Text('확인 후 승인',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 16,
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
              child: Text(_valueApproval,
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
        isChecked?  Container(
          height: 46,
          width: size.width,
          margin: const EdgeInsets.all(24),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFF0F1F5)),
              alignment: Alignment.center,
              shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
              )
            ),
            onPressed: (){
              print('category : ' + meet.meetInfo.categoryNo.toString());
              print('address : ' + meet.meetInfo.address);
              print('lat : ' + meet.meetInfo.lat.toString());
              print('lon : ' + meet.meetInfo.lon.toString());
              print('time : '+meet.meetInfo.time);
              print('age : '+ meet.meetInfo.age.toString());
              print('peopleLimit : '+meet.meetInfo.peopleLimit.toString());
              print('fee : '+meet.meetInfo.fee.toString());
              print('title : '+meet.meetInfo.title);
              print('content : '+meet.meetInfo.content);
              print('approval : '+meet.meetInfo.approval.toString());
              //_registerMeet();
              Navigator.pop(context);
            },
            child: const Text('등록 완료',
              style: TextStyle(
                color: Color(0xFF2F3036),
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ) : const SizedBox.shrink(),
      ],
    );
  }
}
