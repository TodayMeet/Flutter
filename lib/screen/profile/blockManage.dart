import 'package:flutter/material.dart';


import 'package:front/screen/profile/profileMain.dart';

import '../../data/designconst/constants.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';


// import 'mainListView.dart';

class blockManage extends StatefulWidget {
  const blockManage({Key? key}) : super(key: key);

  @override
  State<blockManage> createState() => _blockManageState();
}

class _blockManageState extends State<blockManage> {


  List<Map> data =[{'name': '개굴개굴','image' : 'googlelogin','text':'차단해제','color': Color(0xFFD6D6DD),}, {'name': '꺄르를','image' : 'kakao_login_large_wide','text':'차단해제','color': Color(0xFFD6D6DD),},
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
          Navigator.pop(context);},
      ),
        title: '차단 관리',
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(24.0),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage(
                            "assets/images/User_Picture/User_pic_block.png"),
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
                          style: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.w700),
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
                ),
                SizedBox(height: 10,)
              ],
            );
          }),
    );
  }
}


