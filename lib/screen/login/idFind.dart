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
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';
import '../../screen/dialog/dialoglist.dart';


import 'idFindResult.dart';

import 'dart:async';



class idFind extends StatefulWidget {
  @override
  State<idFind> createState() => _idFindState();
}

class _idFindState extends State<idFind> {
  final TextEditingController _textEditingController = TextEditingController();
  String _text2 = '';
  String _text3 = '';
  int _countdown = 180;
  bool _isCountdownStarted = false;
  bool _ijSuccess = false;



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
  Widget build(BuildContext context) {
    int minutes = _countdown ~/ 60;
    int seconds = _countdown % 60;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          leadingWidget: SvgButton(
              imagePath: backarrow,
              onPressed: () {
                twobutton.backtoLoginDialog(context);
              }),
          title: '아이디 찾기',
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(children: [
            phoneNumberText(), //휴대전화번호 텍스트
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.only(left: 16.0),
              width: MediaQuery.of(context).size.width,
              height: 46.0,
              decoration: BoxDecoration(
                color: textfieldColor,
                borderRadius: BorderRadius.circular(10.0),
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
                        hintStyle:
                            TextStyle(color: hinttextColor, fontSize: 13.0),
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
                      fixedSize: Size(107, 46),
                      backgroundColor: Colors.black,
                    ),
                    child: Text(
                      '인증번호 요청',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
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
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: hinttextColor,
                        ),
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
                    onPressed: () {
                      onebutton.certificationSuccessDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10),
                        ),
                      ),
                      fixedSize: Size(107, 46),
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
            Spacer(),
            idfindButton()
          ]),
        ));
  }
}

class phoneNumberText extends StatelessWidget {
  const phoneNumberText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        "휴대전화번호",
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      Text(
        "*",
        style: TextStyle(
          color: messageRed,
          fontSize: 14.0,
        ),
      )
    ]);
  }
}

class idfindButton extends StatelessWidget {
  const idfindButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return blueButton(
        buttonText: '아이디찾기',
        // 입력시간 초과 -> _login_fail_timeover
        // 성공했으면 -> _login_success_phoneij
        //인증번호 틀리면 -> _login_fail_incorrectij
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => idFindResult(),
            ),
          );
        });
  }
}
