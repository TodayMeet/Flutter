import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:front/model/TextPrint.dart';
import 'package:front/screen/profile/noticeList.dart';




class notice extends StatefulWidget {
  const notice({Key? key}) : super(key: key);

  @override
  State<notice> createState() => _noticeState();
}

class _noticeState extends State<notice> {
  String noticetext = '';

  @override
  void initState() {
    super.initState();
    loadText();
  }

  Future<void> loadText() async {
    String loadedText = await rootBundle.loadString('assets/texts/noticeTest.txt');
    setState(() {
      noticetext = loadedText;
    });
  }
  String titletext = '2022년 1월 1일 안드로이드 업데이트 예정';
  String date = '2021.11.23 12:33';


  @override
  Widget build(BuildContext context) {
    String appbarText = '공지사항';
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
                  MaterialPageRoute(builder: (context) => noticeList()));
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24,),
              Text(titletext,style: TextStyle(fontSize: 18,fontFamily: 'PretendardRegular',),),
              SizedBox(height: 4,),
              Text(date,style: TextStyle(fontSize: 14,fontFamily: 'PretendardRegular',color: Color(0xFF71727A)),),
              SizedBox(height: 16,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 240,
                color: Color(0xFFF5F6FA),
                child: Image.asset(
                  'assets/images/LoginImage/googlelogin.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16,),
              Text(noticetext,style: TextStyle(fontSize: 14,fontFamily: 'PretendardRegular',color: Colors.black),),

            ],
          ),
        ),
      ),
    );
  }
}
