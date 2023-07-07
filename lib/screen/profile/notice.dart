import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/screen/profile/noticeList.dart';

import '../../model/UI/widget/customAppBar.dart';





class notice extends StatefulWidget {
  // final int noticeN
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
      appBar: CustomAppBar(
        leadingWidget: IconButton(
          iconSize: 14.93,
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => noticeList()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF2F2F2F),
          ),
        ),
        title: appbarText,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(titletext,style: TextStyle(fontSize: 18,),),
              SizedBox(height: 4,),
              Text(date,style: TextStyle(fontSize: 14,color: Color(0xFF71727A)),),
              SizedBox(height: 16,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 240,
                color: Color(0xFFF5F6FA),
                child: Center(child: SvgPicture.asset('assets/icons/Image.svg',width: 71,height: 70,))
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
