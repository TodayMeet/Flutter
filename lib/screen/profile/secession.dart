import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
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
  final String email;
  final String password;

  secession({required this.password, required this.email});

  @override
  State<secession> createState() => _secessionState();
}

class _secessionState extends State<secession> {
  TextEditingController textarea = TextEditingController();

  Future<void> secessionFunction() async {
    final url1 = Uri.parse('http://todaymeet.shop:8080/delete-user');
    final requestData = {
      'password' : widget.password,
      'email': widget.email,
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.post(
      url1,
      headers: {'Content-Type': 'application/json'},
      body: jsonData,
    );
    if (response.statusCode == 200) {
      print('전송잘됨');

      print(url1);
      print('join success!!임 이건 ?${response.body}');
      print(response);


    } else {
     print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");

    }
  }

  @override
  Widget build(BuildContext context) {
    String appbarText = '탈퇴신청';
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
        title: appbarText,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textfieldTitle(title: '사유', star: false),
            SizedBox(
              height: 8.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: textfieldColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: TextField(
                controller: textarea,
                maxLines: 10,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 16.0),
                  hintText: "200자 이하 텍스트 입력 가능",
                  hintStyle: TextStyle(color: hinttextColor,fontSize: 13.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            textfieldTitle(title: ' 200자 이내로 입력 가능합니다.', star: true, reverse: true,),//텍스트필드-입력가능 사이 여백 //200자 이내로 입력 가능합니다.
            Spacer(),
            //탈퇴버튼
            //200자가 넘으면 over200Dialog
            blueButton(
                buttonText: '탈퇴',
                onPressed: (){
                  // if(textarea.text.length > 200){
                  //   onebutton.over200Dialog(context);
                  // }else{
                  //   twobutton.secessionDialog(context);
                  // }
                  // secessionFunction();
                  print(widget.email);
                }
                )
          ],
        ),
      ),
    );
  }
}


