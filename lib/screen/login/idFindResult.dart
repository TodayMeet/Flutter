// 휴대폰인증
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: const IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.transparent,
            ),
            onPressed: null,
          ),
          centerTitle: true,
          title: const Text(
            '아이디 찾기',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Spacer(),
          const Text(
            '가입하신 계정은',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          const Text(
            'abcd@gmail.com',
            style: TextStyle(
              fontSize: 38.4,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Text(
            '입니다.',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Container(
            width: 327,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(
                color: Colors.black,
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
                '비밀번호 찾기',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            width: 327,
            height: 56,
            child: CupertinoButton(
              onPressed: () {
                // 입력시간 초과 -> _login_fail_timeover
                // 성공했으면 -> _login_success_phoneij
                //인증번호 틀리면 -> _login_fail_incorrectij
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => login()));
              },
              minSize: 0,
              padding: EdgeInsets.symmetric(),
              color: CupertinoDynamicColor.resolve(
                CupertinoColors.systemBlue,
                context,
              ).withAlpha(0xFF4874EA),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Text(
                '로그인하기',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 24.0),
        ])));
  }
}