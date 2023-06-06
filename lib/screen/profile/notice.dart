import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:front/model/TextPrint.dart';




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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: Text(
          '공지사항',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600
          ),
        ),
        actions: null,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24,),
              Text(titletext,style: TextStyle(fontSize: 18),),
              SizedBox(height: 4,),
              Text(date,style: TextStyle(fontSize: 14,color: Color(0xFF71727A)),),
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
              Text(noticetext,style: TextStyle(fontSize: 14,color: Colors.black),),

            ],
          ),
        ),
      ),
    );
  }
}
