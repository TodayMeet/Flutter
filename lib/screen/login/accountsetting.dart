// 계정 설정
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/data/designconst/constants.dart';
import 'package:front/screen/login/Phone_ij.dart';
import 'package:front/screen/login/registerProfile.dart';
import 'package:http/http.dart' as http;
import '../../model/dialogEx/dialoglist.dart';
import '../../model/profile/CustomAppBar.dart';
import '../../model/profile/bluebutton.dart';
import '../../model/svgbutton/svgbutton.dart';
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
  String appbarText = '계정설정';
  String buttonText = '다음';
  bool isDuplicate = false;
  bool isDuplicatepw = false;
  bool obscureText = true;

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
    return isDuplicate ? '* 비밀번호가 일치합니다.' : '* 비밀번호가 일치하지 않습니다.';
  }

  bool isPasswordMatch() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    return password == confirmPassword;
  }

  final _emailController = TextEditingController();
  final _pwordController = TextEditingController();

  // void _toregisterProfile() {
  //   final String email = _idController.text;
  //   final String password = _passwordController.text;
  //
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => registerProfile(email: email, password: password),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          leadingWidget: SvgButton(
            imagePath: backarrow,
            onPressed: () {
              twobutton.backtoLoginDialog(context);
            },
          ),
          title: appbarText,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Text(
                      '아이디(이메일)',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Color(0xFF1F2024)),
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
                  Text(
                    '* 이메일 주소는 "@"와 "."을 최소 하나 이상 포함되어야합니다.',
                    style: TextStyle(color: messageRed, fontSize: 12.0),
                  ),
                  Text(
                    convertIsDuplicateToString(isDuplicate),
                    style: TextStyle(color: messageRed, fontSize: 12.0),
                  ),
                ],
              ), // 아이디(이메일)
              SizedBox(height: 24.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Text(
                      '비밀번호',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14.0),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: textfieldColor,
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                        hintText: '2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
                        hintStyle: TextStyle(
                          color: hinttextColor,
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {
                            obscureText = !obscureText;
                          },
                          icon: Icon(
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: suffixiconColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '* 2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
                    style: TextStyle(color: messageRed, fontSize: 12.0),
                  ),
                ],
              ), //비밀번호
              SizedBox(height: 24.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Text(
                      '비밀번호 확인',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: textfieldColor),
                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                        hintText: '2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
                        hintStyle: TextStyle(
                          color: hinttextColor,
                          fontSize: 13,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            obscureText = !obscureText;
                          },
                          icon: Icon(
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: suffixiconColor,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '* 2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
                    style: TextStyle(color: messageRed, fontSize: 12.0),
                  ),
                  Text(
                    isPasswordMatch()
                        ? '* 비밀번호가 일치합니다.'
                        : '* 비밀번호가 일치하지 않습니다.',
                    style: TextStyle(color: messageRed, fontSize: 12.0),
                  ),
                  SizedBox(height: 24.0),
                ],
              ), //비밀번호 확인
              Spacer(),
              blueButton(buttonText: buttonText, onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => registerProfile(),
                    ),
                  );
                },),



            ],
          ),
        ),
      ),
    );
  }
}
