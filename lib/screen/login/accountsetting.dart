// 계정 설정
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/screen/login/Phone_ij.dart';

import 'login.dart';

class accountsetting extends StatefulWidget {
  @override
  _accountsettingState createState() => _accountsettingState();
}

class _accountsettingState extends State<accountsetting> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            _backto_Phoneij(context);

          },
        ),
        centerTitle: true,
        title: Text(
          '계정설정',
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.only(left: 3.0),
              child: Text(
                '아이디(이메일)',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Container(
                width: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: _idController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 12.0,
                    ),
                    hintText: '아이디를 입력하세요',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '* 이메일 주소는 "@"와 "."을 최소 하나 이상 포함되어야합니다.',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              '* 이미 가입된 이메일 주소입니다.',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 24.0),
            Padding(
              padding: EdgeInsets.only(left: 3.0),
              child: Text(
                '비밀번호',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Container(
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
            ),

            Text(
              '*2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 24.0),
            Padding(
              padding: EdgeInsets.only(left: 3.0),
              child: Text(
                '비밀번호 확인',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Container(
                width: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: _confirmPasswordController,
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
            ),

            Text(
              '*비밀번호가 일치합니다.',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              '*비밀번호가 일치하지 않습니다.',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              '*2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 32.0),
            Spacer(),
            Center(
              child:Container(
              width: 327,
              child: CupertinoButton(
                onPressed: () {
                  // 입력시간 초과 -> _login_fail_timeover
                  // 성공했으면 -> _login_success_phoneij
                  //인증번호 틀리면 -> _login_fail_incorrectij
                  },
                minSize: 0,
                padding: EdgeInsets.symmetric(
                  vertical: 24.0,
                ),
                color: CupertinoDynamicColor.resolve(
                  CupertinoColors.systemBlue,
                  context,
                ).withAlpha(0xFF4874EA),
                // 버튼의 수직 방향 패딩 값 조정
                borderRadius: BorderRadius.all(Radius.circular(12.0)),

                child: Text(
                  '다음',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),),
          ],
        ),
      ),
    );
  }
}

void _backto_Phoneij(BuildContext context) {
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
                  builder: (context) => Phone_ij()),
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
