// 휴대폰인증
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/data/designconst/constants.dart';
import '../../model/UI/widget/button/blueButton.dart';
import '../../screen/dialog/dialoglist.dart';

import 'package:front/screen/login/pwFindResult.dart';


import 'login.dart';
import 'accountsetting.dart';
import 'dart:async';



class pwFind extends StatefulWidget {
  @override
  State<pwFind> createState() => _pwFindState();
}

class _pwFindState extends State<pwFind> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final TextEditingController _textEditingController = TextEditingController();
  String _text2 = '';
  String _text3 = '';
  int _countdown = 180;
  bool _isCountdownStarted = false;
  bool _ijSuccess = false;
  String buttonText = '비밀번호 찾기';
  String messageText = '* 2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.';

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

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _countdown ~/ 60;
    int seconds = _countdown % 60;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () {
              twobutton.backtoLoginDialog(context);
            },
          ),
          centerTitle: true,
          title: Text(
            '비밀번호 찾기',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        "아이디(이메일)",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    SizedBox(height: 8.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 12.0,
                          ),
                          hintText: messageText,
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      messageText,
                      style: TextStyle(
                        color: messageRed,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),//이메일 입력
                SizedBox(height: 24.0),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "휴대전화번호",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16.0),
                      width: MediaQuery.of(context).size.width,
                      height: 46.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6FA),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          width: 1.0,
                          color: Colors.transparent,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  _text2 = value;
                                });
                              },
                              style: TextStyle(fontSize: 13),
                              decoration: InputDecoration(
                                hintText: '휴대전화번호를 입력해주세요',
                                hintStyle: TextStyle(fontSize: 13.0,color: hinttextColor,),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(width: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              if (!_isCountdownStarted) {
                                startCountdown();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(10.0),
                                ),
                              ),
                              fixedSize: Size(107, 46.55),
                              backgroundColor: Colors.black,
                            ),
                            child: Text(
                              '인증번호 요청',
                              style: TextStyle(
                                  fontSize: 13,

                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16.0),
                      width: MediaQuery.of(context).size.width,
                      height: 46.0,
                      decoration: BoxDecoration(
                        color: textfieldColor,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          width: 1.0,
                          color: textfieldColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  _text3 = value;
                                });
                              },
                              style: TextStyle(fontSize: 13),
                              decoration: InputDecoration(
                                hintText: '인증번호',
                                hintStyle: TextStyle(color: hinttextColor),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(width: 13.0),
                          Text(
                            '$minutes:${seconds.toString().padLeft(2, '0')}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(width: 13.0),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(10),
                                ),
                              ),
                              fixedSize: Size(107.2, 46.55),
                              backgroundColor: Colors.black,
                            ),
                            child: Text(
                              '확인',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),//휴대전화번호인증
                Spacer(),
                blueButton(buttonText: buttonText, onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => pwFindResult()),
                    );
                  },),
              ]),
        ));
  }
}
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => pwFindResult()),
// );
// },
