import 'package:flutter/material.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/model/svgbutton/svgbutton.dart';
import 'package:front/screen/profile/profileMain.dart';

import '../../model/profile/CustomAppBar.dart';
// import 'mainListView.dart';

class blockManage extends StatefulWidget {
  const blockManage({Key? key}) : super(key: key);

  @override
  State<blockManage> createState() => _blockManageState();
}

class _blockManageState extends State<blockManage> {
  String backarrow = 'assets/images/ProfileImage/backarrow.svg';
  Color _mygrey = Color(0xFFD6D6DD);
  Color _blue = Color(0xFF4874EA);

  List<Map> data =[
    {'name': '개굴개굴','image' : 'googlelogin','text':'차단해제','color': Color(0xFFD6D6DD),},
    {'name': '꺄르를','image' : 'kakao_login_large_wide','text':'차단해제','color': Color(0xFFD6D6DD),},
    {'name': '보라돌이','image' : 'logoimage','text':'차단해제','color': Color(0xFFD6D6DD),},
    {'name': '오늘만산다','image' : 'naverlogin','text':'차단해제','color': Color(0xFFD6D6DD),},
    {'name': '심심해','image' : 'titleimage','text':'차단해제','color': Color(0xFFD6D6DD),},
  ];
  List<String> entries = <String>['개굴개굴', '꺄르르', '보라돌이', '오늘만산다', '심심해'];
  List<String> entries1 = <String>[
    'googlelogin',
    'kakao_login_large_wide',
    'logoimage',
    'naverlogin',
    'titleimage'
  ];
  List<String> buttonTexts = <String>[
    '차단해제',
    '차단해제',
    '차단해제',
    '차단해제',
    '차단해제'
  ];
  List<Color> buttonColors = <Color>[
    Color(0xFFD6D6DD),
    Color(0xFFD6D6DD),
    Color(0xFFD6D6DD),
    Color(0xFFD6D6DD),
    Color(0xFFD6D6DD),
  ];
  String initext = '차단해제';

  String appbarText = '차단 관리';

  void changeButtonState(int index) {
    setState(() {
      if (buttonTexts[index] == '차단해제') {
        buttonTexts[index] = '차단';
        buttonColors[index] = Color(0xFF4874EA);
      } else {
        buttonTexts[index] = '차단해제';
        buttonColors[index] = Color(0xFFD6D6DD);
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(
                        "assets/images/LoginImage/${entries1[index]}.png"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${entries[index]}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: ()=> changeButtonState(index),
                    child: Text(
                      buttonTexts[index],
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(buttonColors[index]),
                      elevation: MaterialStateProperty.all<double>(0),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.transparent,),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
