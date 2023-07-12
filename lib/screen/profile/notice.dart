import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/data/designconst/constants.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/model/UI/widget/button/svgButton.dart';
import 'package:front/screen/profile/noticeList.dart';
import 'package:intl/intl.dart';

import '../../model/UI/widget/customAppBar.dart';





class notice extends StatefulWidget {
  final int noticeNo;
  notice({required this.noticeNo});
  // const notice({Key? key}) : super(key: key);

  @override
  State<notice> createState() => _noticeState();
}

class _noticeState extends State<notice> {
  String title = '';
  List<String> images = [];
  String time = '';
  String content = ''' ''';




  Future<void> noticeContentLoad() async {
    final url = Uri.parse('http://todaymeet.shop:8080/notice/detail?noticeNo=${widget.noticeNo}');
    final requestData = {
      'noticeNo' : widget.noticeNo,
      'title' : title,
      'content' : content,
      'images' : images,
      'time' : time
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      // final result = jsonDecode(response.body);
      final result = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        title = result["title"];
        content = result["content"];
        time = result["time"];
        images = List<String>.from(result["images"]);
      });
    }
  } //서버로 전송

  @override
  void initState() {
    noticeContentLoad();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    DateFormat timeformat = DateFormat("yyyy.MM.dd HH:mm");
    DateTime t1 = DateTime.parse(time);
    String t2 = timeformat.format(t1);

    String appbarText = '공지사항';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
            imagePath: backarrow,
            onPressed: (){
              print(t1);
              print(timeformat.format(t1));
              // Navigator.pop(context);
            }),


        title: appbarText,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(title,style: TextStyle(fontSize: 18,),),
              SizedBox(height: 4,),
              Text('${t2}',style: TextStyle(fontSize: 14,color: Color(0xFF71727A)),),
              SizedBox(height: 16,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 240,
                color: Color(0xFFF5F6FA),
                child: Center(child: SvgPicture.asset('assets/icons/Image.svg',width: 71,height: 70,))
              ),
              SizedBox(height: 16,),
              Text(content,style: TextStyle(fontSize: 14,color: Colors.black),),

            ],
          ),
        ),
      ),
    );
  }
}
