import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:front/screen/profile/profileMain.dart';
import 'package:intl/intl.dart';
import '../../data/designconst/constants.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';
import 'notice.dart';

// import 'mainListView.dart';

class noticeList extends StatefulWidget {
  const noticeList({Key? key}) : super(key: key);

  @override
  State<noticeList> createState() => _noticeListState();
}

class _noticeListState extends State<noticeList> {
  String question = '';
  String answer = '';
  int faqno = 0;
  List<Map> result = [];
  List<Map> finalresult = [];


  int noticeNo=0;
  String title = '';
  String image = '';
  String time='';
  DateFormat timeformat = DateFormat("yyyy.MM.dd");


  Future<void> noticeLoad() async {
    final url = Uri.parse('http://todaymeet.shop:8080/notice/list');
    final requestData = {
      'question' : question,
      'answer' : answer,
      'noticeno' : noticeNo
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url,
      // body: jsonData,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(utf8.decode(response.bodyBytes));
      List<Map<String, dynamic>> mappedList = result.cast<Map<String, dynamic>>().toList();
      mappedList.forEach((item) {
        item["index"] = mappedList.length-item['noticeNo'];
      });

      setState(() {
        finalresult = mappedList;

      });
      print(finalresult);
    }
  } //서버로 전송


  @override
  void initState() {
    super.initState();
    noticeLoad();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed: () {
            // noticeLoad();
            Navigator.pop(context);
          },
        ),
        title: '공지사항',
      ),
      body: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          itemCount: finalresult.length,
          itemBuilder: (BuildContext context, int index) {
            final notices = finalresult[finalresult.length-1 - index];
            DateTime writeTime = DateTime.parse(notices['time']);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => notice(noticeNo: notices['noticeNo']),
                    ),
                  );

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Row(
                    children: [
                      notices['image']==null
                      ? Container(alignment: Alignment.center, width: 50, height: 50, decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFFF5F6FA),), child: SvgPicture.asset('assets/icons/Image.svg'),)
                      : CircleAvatar(radius: 25, backgroundImage: NetworkImage(notices['image']),),
                      SizedBox(width: 16,),
                      Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          SizedBox(height:20.0,child: Text('${notices['title']}', style: TextStyle(color: Colors.black, fontSize: 14.0),)),
                          SizedBox(height: 4,),
                          Text('${timeformat.format(writeTime)}', style: TextStyle(color: Color(0xFF71727A), fontSize: 12,fontFamily: 'Inter'),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

    );
  }
}


