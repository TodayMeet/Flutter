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
  
  String password ='';
  String confirmPassword ='';
  bool obscureText1 = true;
  bool obscureText = true;

  //화면 전환시 컨트롤러 삭제
  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  //비밀번호 확인에서 새 비밀번호와 새 비밀번호 확인 부분에 입력한 값이 동일한지
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
      resizeToAvoidBottomInset: false, //텍스트 필드에 입력하려고 할 때 아래의 버튼이 올라오지 않게 하기
      //앱바
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

            //새 비밀번호
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //텍스트필드 제목
                textfieldTitle(title: '새 비밀번호', star: true),

                //여백
                SizedBox(height: 8.0),

                //새 비밀번호 텍스트필드
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 46,
                  decoration: BoxDecoration(
                    color: textfieldColor,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: textfieldColor),
                  ),
                  child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9!@#$%^&*().]"),),
                    ],
                    controller: _passwordController,
                    obscureText: obscureText,
                    onChanged: (value) {
                      password = _passwordController.text;
                      isPasswordMatch();
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 12.0,
                      ),
                      hintText: pwTitle,
                      hintStyle: TextStyle(
                        color: hinttextColor,
                        fontSize: 11,
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

                //여백
                SizedBox(height: 8.0,),

                //2자 이상 12자 이하 영문숫자 특수기호만 입력가능 메시지 문구
                textfieldTitle(title: pwTitle, star: true,reverse: true,)
              ],
            ),

            //여백
            SizedBox(height: 24.0),

            //새 비밀번호 확인
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //새 비밀번호 확인 텍스트필드 제목
                textfieldTitle(title: '새 비밀번호 확인', star: true,reverse: false),

                // 여백
                SizedBox(height: 8.0),

                // 텍스트필드
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 46,
                  decoration: BoxDecoration(
                    color: textfieldColor,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9!@#$%^&*().]"),),
                    ],
                    controller: _confirmPasswordController,
                    obscureText: obscureText1,
                    onChanged: (value) {
                      confirmPassword = _confirmPasswordController.text;
                      isPasswordMatch();
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 12.0,
                      ),
                      hintText: pwTitle,
                      hintStyle: TextStyle(
                        color: hinttextColor,
                        fontSize: 11,
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

                // 여백
                SizedBox(height: 8.0),

               //2자 이상 12자 이하 영문 숫자 특수기호만 입력가능 메시지 문구
                textfieldTitle(title: pwTitle, star: true,reverse: true,),

                //새 비밀번호와 새 비밀번호 확인에서 입력한 텍스트가 동일하면 일치합니다, 일치하지 않으면 일치하지 않습니다 출력하는 텍스트
                Text(
                  isPasswordMatch()
                      ? '* 비밀번호가 일치합니다.'
                      : '* 비밀번호가 일치하지 않습니다.',
                  style: TextStyle(color: messageRed, fontSize: 12.0),
                ),


              ],
            ),

            //여백
            Spacer(),

            //비밀번호 변경 버튼
            blueButton(buttonText: '비밀번호 변경', onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => login()),
                );

              },
            )
          ],
        ),
      ),
    );
  }
}

