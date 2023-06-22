import 'package:flutter/material.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/screen/profile/profileMain.dart';
// import 'mainListView.dart';

class blockManage extends StatefulWidget {
  const blockManage({Key? key}) : super(key: key);

  @override
  State<blockManage> createState() => _blockManageState();
}

class _blockManageState extends State<blockManage> {
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
  Color inibuttonColor = Color(0xFFD6D6DD);

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
String appbarText = '차단 관리';

  @override
  Widget build(BuildContext context) {

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
                        fontWeight: FontWeight.w600),
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
