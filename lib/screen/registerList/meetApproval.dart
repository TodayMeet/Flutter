// 참가 승인 위젯

// 최종 수정일 : 2023.6.26
// 작업자 : 김혁

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:front/data/userNo.dart';
import 'package:http_parser/http_parser.dart';

import '../setting/registerMeeting.dart' as meet;
import '../../routes.dart';

class MeetingApproval extends StatefulWidget {
  const MeetingApproval({Key? key}) : super(key: key);

  @override
  State<MeetingApproval> createState() => _MeetingApprovalState();
}

class _MeetingApprovalState extends State<MeetingApproval> {
  bool enabled = true;
  bool isChecked = false;
  late String _valueApproval;

  // 서버에 건수 등록
  void _registerMeet() async {
    // 이미지 파일 경로로 변환
    List<MultipartFile> imagefiles;
    if(meet.meetInfo.imagefiles.isNotEmpty){
      imagefiles = meet.meetInfo.imagefiles.map((image) => MultipartFile.fromFileSync(image.path,
        contentType: MediaType('image', 'jpg'))).toList();
    }else{
      imagefiles = [];
    }

    Dio dio = Dio();

    // 디오로 보낼 데이터 생성
    dio.options.contentType = 'multipart/form-data';
    FormData formData = FormData.fromMap({
      'categoryname': meet.meetInfo.categoryName,
      'address' : meet.meetInfo.address,
      'lat' : meet.meetInfo.lat,
      'lon' : meet.meetInfo.lon,
      'time' : meet.meetInfo.time,
      'age' : meet.meetInfo.age,
      'peopleLimit' : meet.meetInfo.peopleLimit,
      'fee' : meet.meetInfo.fee,
      'title' : meet.meetInfo.title,
      'content' : meet.meetInfo.content,
      'Files' : imagefiles,
      'approval' : meet.meetInfo.approval,
      'userNo' : UserNo.myuserNo,
    });

    // 서버로 받은 응답
    final response = await dio.post(
        "http://todaymeet.shop:8080/meet/addwithImage",
        data: formData
    );

    if (response.statusCode == 201) {
      // 성공
      debugPrint('--------------------- 건수 등록 완료 --------------------');
    } else {
      // 오류
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
              const meet.Title(content:"참가 승인은 어떻게 할까요?"),

              // 참가 승인 방법 선택 위젯
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                child: Row(
                  children: [
                    // 자동 승인 버튼
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
                    // 확인 후 승인 버튼
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
        ): Container(                              // 선택 완료 후 버튼
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
        isChecked?  Container(                   // 등록 완료 버튼
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
              debugPrint('category : ${meet.meetInfo.categoryName}');
              debugPrint('address : ${meet.meetInfo.address}');
              debugPrint('lat : ${meet.meetInfo.lat.toString()}');
              debugPrint('lon : ${meet.meetInfo.lon.toString()}');
              debugPrint('time : ${meet.meetInfo.time}');
              debugPrint('age : ${meet.meetInfo.age.toString()}');
              debugPrint('peopleLimit : ${meet.meetInfo.peopleLimit.toString()}');
              debugPrint('fee : ${meet.meetInfo.fee.toString()}');
              debugPrint('title : ${meet.meetInfo.title}');
              debugPrint('content : ${meet.meetInfo.content}');
              debugPrint('approval : ${meet.meetInfo.approval.toString()}');
              _registerMeet();
              Navigator.pushReplacementNamed(
                  context,
                  Routes.registerRoute);
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
