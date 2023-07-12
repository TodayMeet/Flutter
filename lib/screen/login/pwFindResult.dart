// 계정 설정
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/data/designconst/constants.dart';
import 'package:front/model/UI/widget/button/svgButton.dart';
import 'package:front/model/UI/widget/customAppBar.dart';
import 'package:front/model/UI/widget/text/textfieldTitle.dart';
import '../../model/UI/widget/button/blueButton.dart';
import '../../screen/dialog/dialoglist.dart';

import 'login.dart';

class pwFindResult extends StatefulWidget {
  @override
  _pwFindResultState createState() => _pwFindResultState();
}

class _pwFindResultState extends State<pwFindResult> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final String buttonText = '비밀번호 변경';
  String password ='';
  String confirmPassword ='';
  bool obscureText1 = true;
  bool obscureText = true;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          title: '비밀번호 변경',
      leadingWidget: SvgButton(
        imagePath: backarrow,
      onPressed: (){
        twobutton.backtoLoginDialog(context);
      }
      ),),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textfieldTitle(title: '새 비밀번호', star: true),
                SizedBox(height: 8.0),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: textfieldColor,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: textfieldColor),
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: obscureText,
                      onChanged: (value) {
                        password = _passwordController.text;
                        isPasswordMatch();
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 12.0,
                        ),
                        hintText: pwTitle,
                        hintStyle: TextStyle(
                          color: hinttextColor,
                          fontSize: 13,
                        ),
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
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                textfieldTitle(title: pwTitle, star: true,reverse: true,)
              ],
            ),
            SizedBox(height: 24.0),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textfieldTitle(title: '새 비밀번호 확인', star: true,reverse: false),
                SizedBox(height: 8.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: textfieldColor,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: TextField(
                    controller: _confirmPasswordController,
                    obscureText: obscureText1,
                    onChanged: (value) {
                      confirmPassword = _confirmPasswordController.text;
                      isPasswordMatch();
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 12.0,
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
                SizedBox(height: 8.0),

                SizedBox(height: 8.0),
                textfieldTitle(title: pwTitle, star: true,reverse: true,),
                Text(
                  isPasswordMatch()
                      ? '* 비밀번호가 일치합니다.'
                      : '* 비밀번호가 일치하지 않습니다.',
                  style: TextStyle(color: messageRed, fontSize: 12.0),
                ),


              ],
            ),

            Spacer(),

            blueButton(buttonText: buttonText, onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => login()),
                );
                // 입력시간 초과 -> _login_fail_timeover
                // 성공했으면 -> _login_success_phoneij
                //인증번호 틀리면 -> _login_fail_incorrectij
              },
            )
          ],
        ),
      ),
    );
  }
}

// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => login()),
// );
// // 입력시간 초과 -> _login_fail_timeover
// // 성공했으면 -> _login_success_phoneij
// //인증번호 틀리면 -> _login_fail_incorrectij
// },
