// 계정 설정
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/screen/login/Phone_ij.dart';
import 'package:front/screen/login/registerProfile.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class accountsetting extends StatefulWidget {
  void navigateToDestination() {
    String data = "Hello, World!";
    // registerProfile registerprofile = registerProfile(email);
  }

  @override
  _accountsettingState createState() => _accountsettingState();
}

class _accountsettingState extends State<accountsetting> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String email = '';

  bool isDuplicate = false;
  bool isDuplicatepw = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> emailnumDuplicate() async {
    final email = _idController.text;
    final url = Uri.parse('http://todaymeet.shop:8080/email/${email}');
    final response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      print('전송잘됨');
      print(email);
      print(url);
      print(response.body);
      setState(() {
        isDuplicate = false;
      });
    } else {
      // print('전송 자체가 안됨. 상태 침드: ${response.statusCode}');
      // print(email);
      // print(url);
      setState(() {
        isDuplicate = true;
      });
      // print(isDuplicate);
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String convertIsDuplicateToString(bool isDuplicate) {
    return isDuplicate
        ? '* 이미 가입된 이메일 주소입니다.'
        : '                             ';
  }

  String convertIsDuplicatepwToString(bool isDuplicate) {
    return isDuplicate
        ? '* 비밀번호가 일치합니다.'
        : '* 비밀번호가 일치하지 않습니다.';
  }

  bool isPasswordMatch() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    return password == confirmPassword;
  }
  final _emailController = TextEditingController();
  final _pwordController = TextEditingController();

  void _toregisterProfile() {
    final String email = _idController.text;
    final String password = _passwordController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => registerProfile(email: email, password: password),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 25,
          ),
          onPressed: () {
            // email = _idController.text;
            // phonenumDuplicate();
            _backto_login(context);
          },
        ),
        centerTitle: true,
        title: Text(
          '계정설정',
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.only(left: 3.0),
              child: Text(
                '아이디(이메일)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
                  onChanged: (value) {
                    emailnumDuplicate();
                    // print(isDuplicate);
                    // print(convertIsDuplicateToString);
                  },
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
              convertIsDuplicateToString(isDuplicate),
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 24.0),
            Padding(
              padding: EdgeInsets.only(left: 3.0),
              child: Text(
                '비밀번호',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
              '*2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              isPasswordMatch() ? '* 비밀번호가 일치합니다.' : '* 비밀번호가 일치하지 않습니다.',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 32.0),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  child: CupertinoButton(
                    onPressed: () {
                      if(isDuplicate==true || isPasswordMatch()==false){
                        _login_accountCheck(context);
                      }else if(_idController.text=='' || _passwordController==''){
                        _login_accountCheck(context);
                      }

                      else{
                        emailnumDuplicate();
                        _toregisterProfile();
                      }
                    },
                    padding: EdgeInsets.symmetric(),
                    color: CupertinoDynamicColor.resolve(
                      CupertinoColors.systemBlue,
                      context,
                    ).withAlpha(0xFF4874EA),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    child: Text(
                      '다음',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
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
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (BuildContext context) => login()),
                (route) => false);
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

void _login_accountCheck(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: const Text('아이디 또는 비밀번호를 \n 다시 확인해주세요.'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('확인'),
        ),
      ],
    ),
  );
}