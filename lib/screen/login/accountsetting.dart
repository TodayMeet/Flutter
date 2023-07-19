// 계정 설정
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/data/designconst/constants.dart';
import 'package:front/model/UI/widget/text/textfieldTitle.dart';

import 'package:front/screen/login/registerProfile.dart';
import 'package:http/http.dart' as http;
import '../../model/UI/widget/button/blueButton.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';
import '../../screen/dialog/dialoglist.dart';


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





  //이메일 중복검사
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
        print('email : ${email}');
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


  //이메일 중복검사를 통해 중복여부를 bool값으로 받으면? 그에 맞는 텍스트를 반환한다
  String convertIsDuplicateToString(bool isDuplicate) {
    return isDuplicate ? '* 이미 가입된 이메일 주소입니다.' : '                             ';
  }

  //입력한 비밀번호와 다시 입력한 비밀번호가 맞는지 중복검사를 통해 나온 bool 값으로 텍스트를 반환
  String convertIsDuplicatepwToString(bool isDuplicate) {
    return isDuplicate ? '* 비밀번호가 일치합니다.' : '* 비밀번호가 일치하지 않습니다.';
  }


  //입력한 비밀번호랑 다시 입력한 비밀번호가 맞는가
  bool isPasswordMatch() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    if(password =='' || confirmPassword==''){
      return true;
    } else{
      return password == confirmPassword;
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false, //작동 안됨
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

        //전체를 여백 24패딩으로 감쌌음
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //텍스트필드 제목
                  textfieldTitle(title: '아이디(이메일) ', star: true),

                  //여백
                  SizedBox(height: 8.0),

                  //아이디 이메일 텍스트필드
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

                  //여백
                  SizedBox(height: 8.0),

                  //이메일 주소 메세지 문구
                  Text('* 이메일 주소는 "@"와 "."을 최소 하나 이상 포함되어야합니다.', style: TextStyle(color: messageRed, fontSize: 12.0),),

                  //중복이면 메시지 출력
                  Text(convertIsDuplicateToString(isDuplicate), style: TextStyle(color: messageRed, fontSize: 12.0),),
                ],
              ), // 아이디(이메일)

              //여백
              SizedBox(height: 24.0,),

              //비밀번호 입력 텍스트필드
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //비밀번호 텍스트필드 제목
                  textfieldTitle(title: '비밀번호', star: false),
                  //여백
                  SizedBox(height: 8.0),

                  //비밀번호 텍스트필드
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: textfieldColor,
                    ),
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9!@#$%^&*().]"),),
                      ],
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

                  //여백
                  SizedBox(height: 8.0,),

                  //비밀번호 입력조건 메시지
                  Text(
                    '* 2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
                    style: TextStyle(color: messageRed, fontSize: 12.0),
                  ),
                ],
              ), //비밀번호

              //여백
              SizedBox(height: 24.0,),

              //비밀번호 재확인 텍스트필드
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //비밀번호 확인 텍스트필드 제목
                  textfieldTitle(title: '비밀번호 확인', star: false),

                  //여백
                  SizedBox(height: 8.0),

                  //비밀번호 확인 텍스트필드
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: textfieldColor),
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9!@#$%^&*().]"),),
                      ],
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

                  //여백
                  SizedBox(height: 8.0,),

                  //비밀번호 재확인란 입력 조건
                  Text(
                    '* 2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
                    style: TextStyle(color: messageRed, fontSize: 12.0),
                  ),

                  //비밀번호 일치 여부 텍스트
                  Text(
                    isPasswordMatch()
                        ? '* 비밀번호가 일치합니다.'
                        : '* 비밀번호가 일치하지 않습니다.',
                    style: TextStyle(color: messageRed, fontSize: 12.0),
                  ),

                  //여백
                  SizedBox(height: 24.0),
                ],
              ), //비밀번호 확인
              Spacer(),

              //
              blueButton(buttonText: '다음', onPressed: () {
                print('이메일  : =======================${email}');

                //이메일과 비밀번호를 registerProfile에 넘겨야ㅏ함
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
