// 휴대폰인증
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/model/profile/bluebutton.dart';
import 'package:front/screen/login/pwFind.dart';
import 'login.dart';
import 'accountsetting.dart';
import 'dart:async';
import 'signup.dart';

class idFindResult extends StatefulWidget {
  @override
  State<idFindResult> createState() => _idFindResultState();
}

class _idFindResultState extends State<idFindResult> {
  String result = 'abcd@gmail.com';
  final String findPasswordButtonText = '비밀번호 찾기';
  final String buttonText = '로그인하기';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            '아이디 찾기',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0,horizontal: 16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Spacer(),
            Text(
              '가입하신 계정은',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            idResult(result: result),
            Text(
              '입니다.',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            Spacer(),
            findPasswordButton(findPasswordButtonText: findPasswordButtonText),
            SizedBox(height: 10,),
            gotoLoginButton(buttonText: buttonText),
          ]),
        ));
  }
}

class idResult extends StatelessWidget {
  const idResult({
    super.key,
    required this.result,
  });

  final String result;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        result,
        style: TextStyle(
          fontSize: 38.4,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class gotoLoginButton extends StatelessWidget {
  const gotoLoginButton({
    super.key,
    required this.buttonText,
  });

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return blueButton(
        buttonText: buttonText,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => login(),
            ),
          );
        });
  }
}

class findPasswordButton extends StatelessWidget {
  const findPasswordButton({
    super.key,
    required this.findPasswordButtonText,
  });

  final String findPasswordButtonText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.all(
          color: Color(0xFFA3A3A3),
        ),
      ),
      child: CupertinoButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => pwFind()));
        },
        minSize: 0,
        padding: EdgeInsets.symmetric(),
        child: Text(
          findPasswordButtonText,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
