// 계정 설정
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/data/designconst/constants.dart';
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
            twobutton.backtoLoginDialog(context);
          },
        ),
        centerTitle: true,
        title: Text(
          '비밀번호 변경',
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                    "새 비밀번호 ",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "*",
                    style: TextStyle(
                      color: messageRed,
                      fontSize: 14.0,
                    ),
                  )
                ]),
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
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 12.0,
                        ),
                        hintText: '*2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
                        hintStyle: TextStyle(
                          color: hinttextColor,
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  '* 2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
                  style: TextStyle(fontSize:12.0,color: messageRed),
                ),
              ],
            ),
            SizedBox(height: 24.0),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                    "새 비밀번호 확인 ",
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
                ]),
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
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 12.0,
                      ),
                      hintText: '*2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
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
                  '* 비밀번호가 일치합니다.',
                  style: TextStyle(fontSize:12.0,color: messageRed),
                ),
                Text(
                  '* 비밀번호가 일치하지 않습니다.',
                  style: TextStyle(fontSize:12.0,color: messageRed),
                ),
                SizedBox(height: 8.0),
                Text(
                  '* 2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
                  style: TextStyle(fontSize:12.0,color: messageRed),
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
