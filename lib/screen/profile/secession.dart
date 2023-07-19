//탈퇴하기


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:front/main.dart';
import 'package:front/model/UI/widget/text/textfieldTitle.dart';
import '../../model/UI/widget/button/blueButton.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';
import '../../screen/dialog/dialoglist.dart';
import 'package:front/screen/profile/profileMain.dart';
import 'package:front/data/designconst/constants.dart';

import '../login/login.dart';

class secession extends StatefulWidget {
  final int userNo;

  secession({required this.userNo});

  @override
  State<secession> createState() => _secessionState();
}


class _secessionState extends State<secession> {
  TextEditingController textarea = TextEditingController();

  @override
  void dispose() {
    textarea.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed:() {
            Navigator.pop(context);
            },
        ),
        title: '탈퇴신청',
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //텍스트필드 제목 사유
            textfieldTitle(title: '사유', star: false),

            //텍스트필드 제목과 사유 입력 사이 여백
            SizedBox(height: 8.0,),

            //텍스트필드
            Container(decoration: BoxDecoration(color: textfieldColor, borderRadius: BorderRadius.circular(12.0),),
              child: TextField(controller: textarea, maxLines: 10,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 16.0),
                  hintText: "200자 이하 텍스트 입력 가능",
                  hintStyle: TextStyle(color: hinttextColor,fontSize: 13.0),
                  border: InputBorder.none,
                ),
              ),
            ),

            //텍스트필드 - 메시지 사이 여맥
            SizedBox(
              height: 8.0,
            ),

            //200자 이내로 입력가능합니다. 메시지
            textfieldTitle(title: ' 200자 이내로 입력 가능합니다.', star: true, reverse: true,),//텍스트필드-입력가능 사이 여백 //200자 이내로 입력 가능합니다.

            //메시지와 탈퇴 버튼 사이 여백
            Spacer(),
            //탈퇴버튼
            //200자가 넘으면 over200Dialog
            blueButton(buttonText: '탈퇴', onPressed: (){
                  if(textarea.text.length > 200){
                    onebutton.over200Dialog(context);
                  }else{
                    print('탈퇴하는 유저의 번호 : ${widget.userNo}');
                    twobutton.secessionDialog(context);
                  }

                })
          ],
        ),
      ),
    );
  }
}


