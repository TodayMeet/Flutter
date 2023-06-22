import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/main.dart';
import 'package:front/model/dialogEx/SecessionDialog.dart';
import 'package:front/screen/profile/profileMain.dart';



import '../login/login.dart';

class secession extends StatefulWidget {
  const secession({Key? key}) : super(key: key);

  @override
  State<secession> createState() => _secessionState();
}

class _secessionState extends State<secession> {
  TextEditingController textarea = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String appbarText = '탈퇴신청';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color : Color(0xFFE3E3E3), // 테두리 선의 색상
            height: 1.0, // 테두리 선의 높이
          ),
        ),
        leading: IconButton(
            iconSize: 14.93,
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => profileMain()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF2F2F2F),
            )),
        //leading아이콘 혹시나 필요하면

        title: Text(appbarText,
          style: TextStyle(fontSize: 16.0,color: Colors.black,fontFamily: 'PretendardBold'),
        ),

        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24.0,
            ),
            Text(
              "사유",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'PretendardBold'),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F6FA),
                border: Border.all(
                  width: 12,
                  color: Color(0xFFF5F6FA),
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 4),
              child: Column(
                children: [
                  TextField(
                    controller: textarea,
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintText: "200자 이하 텍스트 입력 가능",
                      hintStyle: TextStyle(color: Color(0xFFC8C8CB),fontFamily: 'PretendardRegular',fontSize: 13.0),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),//텍스트 필드
            SizedBox(
              height: 8.0,
            ),//텍스트필드-입력가능 사이 여백
            Text(
              '*200자 내로 입력 가능합니다.',
              style: TextStyle(color: Color(0xFFFF3D00)),
            ),//200자 이내로 입력 가능합니다.
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 56,
              child: CupertinoButton(
                onPressed: () {
                  if (textarea.text.length > 200) {
                    _textover200(context);
                  } else {
                    _secession(context);
                  }
                },
                minSize: 0,
                color: CupertinoDynamicColor.resolve(
                  CupertinoColors.systemBlue,
                  context,
                ).withAlpha(0xFF4874EA),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                child: Text(
                  '탈퇴',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),//탈퇴버튼
            SizedBox(
              height: 21.0,
            ),
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



void _secession(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SecessionDialog();
    },
  );
} //탈퇴 다이얼로그