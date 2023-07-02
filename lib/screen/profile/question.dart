import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/UI/widget/button/blueButton.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';
import '../../model/UI/widget/text/textfieldTitle.dart';
import '../../screen/dialog/dialoglist.dart';
import 'package:front/screen/profile/profileMain.dart';

import '../../data/designconst/constants.dart';


// import 'mainListView.dart';



class question extends StatefulWidget {
  const question({Key? key}) : super(key: key);

  @override
  State<question> createState() => _questionState();
}

class _questionState extends State<question> {


  TextEditingController textarea = TextEditingController();
  TextEditingController textarea1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed:() {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profileMain()));},
        ),
        title: '문의하기',
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('작성하신 문의 답변은 이메일 아이디 주소로 보내드립니다.\n답변까지 최대 2~3일이 걸립니다.',
              style: TextStyle(
              fontSize: 14.0,

            ),),
            SizedBox(height: 12.0,),

            textfieldTitle(title: '제목',star: false,),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F6FA),
                border: Border.all(
                  width: 1,
                  color: Color(0xFFF5F6FA),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  TextField(
                    controller: textarea,
                    decoration: InputDecoration(
                      hintText: "2자 이상 30자 이하 한글, 영문, 숫자 입력 가능",
                      hintStyle: TextStyle(color: Color(0xFFC8C8CB),fontSize: 13.0),
                      border: InputBorder.none,
                    ),

                  ),
                ],
              ),
            ),

            SizedBox(height: 12.0,),
            textfieldTitle(title: '내용', star: false),
            SizedBox(height: 8,),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F6FA),
                border: Border.all(
                  width: 0,
                  color: Color(0xFFF5F6FA),
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              // alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: 16,),
              child: TextField(
                controller: textarea1,
                maxLines: 14,
                decoration: InputDecoration(
                  hintText: "500자 이하 텍스트 입력 가능",
                  hintStyle: TextStyle(color: Color(0xFFC8C8CB),fontSize: 13.0),
                  border: InputBorder.none,
                ),

              ),
            ),
            Spacer(),
            blueButton(buttonText: '문의하기', onPressed: (){

              if(textarea1.text.length >500){
                onebutton.over500Dialog(context);
              }else{
                onebutton.questionConfirmDialog(context);
              }
            }),


          ],

        ),
      ),
    );
  }
}



