// 휴대폰인증
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/screen/login/pwFindResult.dart';

import 'login.dart';
import 'accountsetting.dart';
import 'dart:async';

import 'signup.dart';

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
            _backto_login(context);
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
      body: Column(children: [

        Padding(
          padding: const EdgeInsets.only(
            left: 23.0,
          ),
          child: Row(children: [
            Text(
              "아이디(이메일)",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),

          ]),
        ),
SizedBox(height: 10,),

        Container(
    width: 360,
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
    hintText: '*2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
    hintStyle: TextStyle(
    color: Colors.grey[400],
    fontSize: 13,
    ),
    border: InputBorder.none,
    ),
    ),
    ),


    Text(
    '*2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
    style: TextStyle(color: Colors.red),
    ),
    SizedBox(height: 24.0),
    Padding(
    padding: const EdgeInsets.only(
    left: 23.0,
    ),
    child: Row(children: [
    Text(
    "휴대전화번호",
    style: TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    ),
    ),
    Text(
    "*",
    style: TextStyle(
    color: Colors.red,
    fontSize: 14.0,
    ),
    )
    ]),
    ),
    SizedBox(height: 8.0),
    Container(
    padding: EdgeInsets.only(left: 8.0),
    width: 350.91,
    height: 46.0,
    decoration: BoxDecoration(
    color: Color(0xFFF5F6FA),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
    width: 1.0,
    color: Colors.grey,
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
    labelText: '휴대전화번호를 입력해주세요',
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
    fontWeight: FontWeight.bold,
    color: Colors.white),
    ),
    ),
    ],
    ),
    ),
    SizedBox(height: 10.0),
    Container(
    padding: EdgeInsets.only(left: 5.0),
    width: 350.91,
    height: 46.0,
    decoration: BoxDecoration(
    color: Color(0xFFF5F6FA),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
    width: 1.0,
    color: Colors.grey,
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
    labelText: '인증번호',
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

    },
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
    // '$minutes:${seconds.toString().padLeft(2, '0')}'
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
    Container(
    width: 327,
    height: 56,
    child: CupertinoButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => pwFindResult()),
      );
    },
    minSize: 0,
    padding: EdgeInsets.symmetric(
    // vertical: 24.0,
    ),
    color: CupertinoDynamicColor.resolve(
    CupertinoColors.systemBlue,
    context,
    ).withAlpha(0xFF4874EA),

    borderRadius: BorderRadius.all(Radius.circular(10.0)),

    child: Text(
    '비밀번호 찾기',
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white),
    ),
    ),
    ),
    SizedBox(height: 24.0),
    ]));
  }
}


void _backto_login(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: const Text('뒤로가기를 하실 경우 입력된 내용이 삭제됩니다.\n 이전화면으로 이동 하시겠습니까?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => login()),
            );
          },
          child: const Text('확인'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('취소'),
        ),
      ],
    ),
  );
}