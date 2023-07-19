// 휴대폰인증
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정

import 'dart:convert';


import 'package:flutter/services.dart';
import 'package:front/model/UI/widget/text/textfieldTitle.dart';
import 'package:front/screen/login/idFindResult.dart';

import '../../data/designconst/constants.dart';
import '../../model/UI/widget/button/blueButton.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';
import '../../screen/dialog/dialoglist.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../profile/profileMain.dart';
import 'login.dart';
import 'accountsetting.dart';
import 'dart:async';


class idFind extends StatefulWidget {
  @override
  State<idFind> createState() => _idFindState();
}

class _idFindState extends State<idFind> {

  TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController _textEditingController = TextEditingController();
  String _text2 = '';
  String _text3 = '';
  int _countdown = 180;
  bool _isCountdownStarted = false;
  String phoneNumber = '';
  String apvNum = '';
  String email = '';
  bool notMember = false;

  //아이디 찾기 결과를 불러오는 함수
  Future<void> idResultLoad() async {
    // url 주소
    final url = Uri.parse('http://todaymeet.shop:8080/find-email/${phoneNumber}');
    // 서버로 email 전송
    final requestData = {
      'email' : email,
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {

      if(response.body.contains("@")){
        print("===========================전화번호와 일치하는 아이디를 찾았을때=======================================");
        print('입력한 전화번호에 해당하는 이메일주소 출력 :  ${response.body}');
        setState(() {
          notMember = false;
          // email 변수에 response 대입
          email = response.body;
        });
      } else {
        setState(() {
          //notMember를 true로 변환
          notMember = true;
        });
      }
    }






     else{
      print('==================================전송 실패했을때================================================');
    }

  }

  //카운트다운 시작
  void startCountdown() {
    if (!_isCountdownStarted) {
      _isCountdownStarted = true;
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdown > 0) {
            _countdown--;
          } else {
            timer.cancel();
            _isCountdownStarted = false;
          }
        });
      });
    }
  }

  //카운트다운 초기화
  void resetCountdown() {
    setState(() {
      _isCountdownStarted = false;
      _countdown = 0;
    });
  }



  @override
  Widget build(BuildContext context) {
    int minutes = _countdown ~/ 60;
    int seconds = _countdown % 60;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        //AppBar
        appBar: CustomAppBar(
          leadingWidget: SvgButton(
              imagePath: backarrow,
              onPressed:() {
                // idResultLoad();
                // print('이메일은 이거 입니다.............................${email}');
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => login(),
                  ),
                );
              }),
          title: '아이디 찾기',
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(children: [
            //휴대전화번호 * 제목
            textfieldTitle(title: '휴대전화번호', star: true),

            //여백
            SizedBox(height: 8,),

            //휴대전화번호를 입력해주세요 textfield + 인증번호 요청
            Container(decoration: BoxDecoration(color: Color(0xFFF5F6FA), borderRadius: BorderRadius.circular(12), ),
              height: 46, //전체 높이
              child: TextField(
                controller: phoneNumberController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, NumberFormatter(),], //textfield입력 양식, 숫자만 들어오게 NumberFormatter로 중간에 하이픈 삽입
                onChanged: (value) {
                  setState(() {
                    _text2 = value;
                    phoneNumber = _text2;
                  });
                },
                style: TextStyle(fontSize: 13.0),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 16),//textfield 내부 여백 설정
                  hintText: "휴대전화번호를 입력해주세요",
                  hintStyle: TextStyle(color: hinttextColor, fontSize: 13.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none
                  ),
                  suffixIcon: Container(
                    width: 100,
                    margin: EdgeInsets.zero,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        //elevation은 눌렀을때 0이 되게 함. 디폴트는 0.5
                        elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return 0;
                          }
                          return 0.5;
                        }),
                        //elevatedbutton의 오른쪽 부분만 둥글게 함
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(12.0)),),),
                        //눌렀을때 색깔이 퍼지는 현상 Colors.transparent로 제거
                        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                        //배경색 : 눌려있을때의 색상과 기본 색상을 다르게 함
                        backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            // 버튼이 눌려 있을 때의 배경색
                            //color: rgb(72,116,234);
                            return Colors.black54; //
                          }
                          return Colors.black; // 기본 배경색
                        }),
                      ),
                      // 버튼에 들어가는 text
                      child: Text('인증번호 요청', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white,),),
                      // _isCountdownStarted의 디폴트값이 false이기 때문에 누르면 카운트다운 시작
                      onPressed: () {
                        if (!_isCountdownStarted) {
                          startCountdown();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),

            //여백 설정
            SizedBox(height: 10.0),

            //인증번호 입력, 확인 버튼
            Container(
              padding: EdgeInsets.only(left: 16.0),
              width: MediaQuery.of(context).size.width,
              height: 46.0,
              decoration: BoxDecoration(
                color: textfieldColor,
                borderRadius: BorderRadius.circular(10.0),

              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        setState(() {
                          _text3 = value;
                        });
                      },
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: '인증번호',
                        hintStyle: TextStyle(color: hinttextColor,fontSize: 13.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  Text(
                    '$minutes:${seconds.toString().padLeft(2, '0')}',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(width: 13.0),

                  Container(
                    width: 100,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () {
                        onebutton.certificationSuccessDialog(context);
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            // 버튼 눌려있을때는 높이 0으로 해놓고
                            return 0;
                          }
                          return 0.5; // 이건 디폴트
                        }),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(12.0)),
                          ),
                        ),
                        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                        backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            // 버튼이 눌려 있을 때의 배경색
                            //color: rgb(72,116,234);
                            return Colors.black54; //
                          }
                          return Colors.black; // 기본 배경색
                        }),
                      ),
                      child: Text(
                        '확인',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 텍스트필드 뒤부터 여백
            Spacer(),

            //아이디 찾기 버튼
            blueButton(buttonText: '아이디 찾기',
              //누르면 idFindResult (아이디 결과 확인 화면으로 이메일을 전송
              onPressed: (){
              idResultLoad();
              //위 함수를 통해 구한 notMember를 통해 다음 페이지로 넘어갈지 안넘어갈지 결정
              if(!notMember){
                print("==================저장되어있는 전화번호일때 이메일 출력 후 결과화면으로 이동====================================");
                print('전화번호에 해당하는 email 결과 : ${email}');
                Navigator.push(context, MaterialPageRoute(builder: (context) => idFindResult(email: email,),),);
              } else{
                print("==================저장되어있는 전화번호가 아닐때 회원이 아니라는 다이얼로그 출력====================================");
                onebutton.notmemberDialog(context);
              }

            },)
          ]),
        ));
  }
}


//숫자 입력 시 휴대폰 번호 형식으로 전환(중간에 하이픈 삽입)
class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex <= 3) {
        if (nonZeroIndex % 3 == 0 && nonZeroIndex != text.length) {
          buffer.write('-'); // Add double spaces.
        }
      } else {
        if (nonZeroIndex % 7 == 0 &&
            nonZeroIndex != text.length &&
            nonZeroIndex > 4) {
          buffer.write('-');
        }
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}