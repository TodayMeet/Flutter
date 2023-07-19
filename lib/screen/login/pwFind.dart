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
import 'package:front/screen/login/pwFindResult.dart';

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


class pwFind extends StatefulWidget {
  @override
  State<pwFind> createState() => _pwFindState();
}

class _pwFindState extends State<pwFind> {


  final TextEditingController _textEditingController = TextEditingController();
  String _text2 = '';
  String _text3 = '';
  int _countdown = 180;
  bool _isCountdownStarted = false;
  bool _ijSuccess = false;
  String phoneNumber = '';
  String apvNum = '';
  final _idController = TextEditingController();
  bool isDuplicate = false;
  bool isDuplicatepw = false;







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

  void resetCountdown() {
    setState(() {
      _isCountdownStarted = false;
      _countdown = 0;
    });
  }

  String convertIsDuplicateToString(bool isDuplicate) {
    return isDuplicate
        ? '* 이미 가입된 이메일 주소입니다.'
        : '                             ';
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _countdown ~/ 60;
    int seconds = _countdown % 60;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            leadingWidget: SvgButton(imagePath: backarrow,onPressed: (){
              Navigator.pop(context);
            },),
            title: '비밀번호 찾기',
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              textfieldTitle(title: '아이디(이메일) ', star: true),
              SizedBox(height: 8.0),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFF1F2024)),
                ),
                child: TextField(
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9!@#$%^&*().]"),),],
                  controller: _idController,
                  onChanged: (value) {
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                    hintText: '아이디를 입력하세요',
                    hintStyle: TextStyle(
                      color: hinttextColor,
                      fontSize: 13,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              textfieldTitle(title: ' 이메일 주소는 “@”와 “.”을 최소 하나 이상 포함되어야 합니다.', star: true, reverse: true,),
              Text(
                convertIsDuplicateToString(isDuplicate),
                style: TextStyle(color: messageRed, fontSize: 12.0),
              ),
                  SizedBox(height: 24,),
              textfieldTitle(title: '휴대전화번호', star: true),
              SizedBox(height: 8,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 46.0,
                decoration: BoxDecoration(
                  color: textfieldColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextField(
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, NumberFormatter(),],
                        onChanged: (value) {
                          setState(() {
                            _text2 = value;
                          });
                        },
                        style: TextStyle(fontSize: 13.0),
                        decoration: InputDecoration(
                          hintText: '휴대전화번호를 입력해주세요',
                          hintStyle: TextStyle(color: hinttextColor, fontSize: 13.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Container(
                      width: 110,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_isCountdownStarted) {
                            startCountdown();
                          }
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

                        // style: ElevatedButton.styleFrom(
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.horizontal(
                        //       right: Radius.circular(8.0),
                        //     ),
                        //   ),
                        //   fixedSize: Size(107, 46),
                        //   backgroundColor: Colors.black,
                        // ),
                        child: Text(
                          '인증번호 요청',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
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
                    SizedBox(width: 13.0),
                    Text(
                      '$minutes:${seconds.toString().padLeft(2, '0')}',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    SizedBox(width: 13.0),

                    Container(
                      width: 110,
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
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              blueButton(buttonText: '비밀번호 찾기', onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => pwFindResult(),
                  ),
                );
              },)

            ]),
          )),
    );
  }
}

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