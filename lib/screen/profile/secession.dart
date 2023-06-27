import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/main.dart';

import 'package:front/model/dialogEx/dialoglist.dart';
import 'package:front/screen/profile/profileMain.dart';
import 'package:front/data/designconst/constants.dart';


import '../../model/dialogEx/CustomDialog.dart';
import '../../model/profile/CustomAppBar.dart';
import '../../model/svgbutton/svgbutton.dart';
import '../login/login.dart';

class secession extends StatefulWidget {
  const secession({Key? key}) : super(key: key);

  @override
  State<secession> createState() => _secessionState();
}

class _secessionState extends State<secession> {
  TextEditingController textarea = TextEditingController();
  String backarrow = 'assets/images/ProfileImage/backarrow.svg';


  Color hintTextColor = Color(0xFFC8C8CB);
  Color textfieldColor = Color(0xFFF5F6FA);
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
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profileMain()));},
        ),
        title: appbarText,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "사유",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
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
                  hintStyle: TextStyle(color: hintTextColor,fontSize: 13.0),
                  border: InputBorder.none,
                ),
              ),
            ),

            SizedBox(
              height: 8.0,
            ),//텍스트필드-입력가능 사이 여백
            Text(
              '*200자 내로 입력 가능합니다.',
              style: TextStyle(color: messageRed),
            ),//200자 이내로 입력 가능합니다.
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 46,
                child: ElevatedButton(style: ElevatedButton.styleFrom(
                  backgroundColor: buttonBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)
                  )
                ),onPressed: (){
                  twobutton.secessionDialog(context);
                }, child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 16.0),
                  child: Text('탈퇴',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,color: Colors.white),),
                ))
              ),
            ),//탈퇴버튼

          ],
        ),
      ),
    );
  }
}



void _textover200(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: const Text('200자 이하로 입력해주세요'),
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
}//200자 이내로 입력해주세요 다이얼로그




