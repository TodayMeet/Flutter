// 계정 설정
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/data/designconst/constants.dart';

import 'package:front/screen/login/registerProfile.dart';
import 'package:http/http.dart' as http;
import '../../model/UI/widget/button/blueButton.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';
import '../../screen/dialog/dialoglist.dart';


import 'login.dart';

class accountsetting extends StatefulWidget {
  void navigateToDestination() {
    // String data = "Hello, World!";
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
  bool obscureText = true;
  bool obscureText1 = true;
  String text3 = '';
  String password='';
  // final _emailController = TextEditingController();
  final _pwordController = TextEditingController();

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
    if(email==''){
      setState(() {
        isDuplicate =false;
      });
    } else {
      if (response.statusCode == 200) {
        print('전송잘됨');
        print(email);
        print(url);
        print(response.body);
        setState(() {
          isDuplicate = false;
        });
      } else {
        print('전송 자체가 안됨. 상태 침드: ${response.statusCode}');
        print(email);
        print(url);
        setState(() {
          isDuplicate = true;
        });
        print(isDuplicate);
      }
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
    if(password =='' || confirmPassword==''){
      return true;
    } else{
      return password == confirmPassword;
    }
  }



  void _toregisterProfile() {

    if(password==''){
      onebutton.noInputPwDialog(context);
    }else if(email==''){
      onebutton.noInputIDDialog(context);
    } else if (isDuplicate){
      onebutton.emailDuplicateCheckDialog(context);
    } else{
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => registerProfile(email: email,password: password),
        ),
      );
    }
  }

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
          title: '계정설정',
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
                        email= _idController.text;
                        emailnumDuplicate();
                        print(isDuplicate);
                        print(convertIsDuplicateToString);
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
                      obscureText: obscureText,
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
                            setState(() {
                              obscureText = !obscureText;

                            });
                          },
                          icon: Icon(
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xFFD0D0D0),
                          ),
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          password = value;
                        });
                      },
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
                      obscureText: obscureText1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                        hintText: pwTitle,
                        hintStyle: TextStyle(
                          color: hinttextColor,
                          fontSize: 13,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText1 = !obscureText1;
                              isPasswordMatch();
                            });
                          },
                          icon: Icon(
                            obscureText1
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xFFD0D0D0),
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
              blueButton(buttonText: '다음', onPressed: () {
                print(email);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => registerProfile(email: email, password: password),
                  ),
                );
                // _toregisterProfile();
              },),
            ],
          ),
        ),
      ),
    );
  }
}
