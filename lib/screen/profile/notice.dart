import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/data/designconst/constants.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/model/UI/widget/button/svgButton.dart';
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

  //공지사항 내용 불러오기
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

        // String으로 불러온 형식 변환
        final originalFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ");
        final parsedDateTime = originalFormat.parse(time);
        final newFormat = DateFormat("yyyy.MM.dd HH:mm");
        final newDateTimeString = newFormat.format(parsedDateTime);
        time = newDateTimeString;
        
        //이미지를 리스트에 저장
        images = List<String>.from(result["images"]);
      });
    }
  } //서버로 전송

  // 처음 시작할때 정보를 받아옴
  @override
  void initState() {
    noticeContentLoad();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
            imagePath: backarrow,
            onPressed: (){
             Navigator.pop(context);
            }),
        title: '공지사항',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: TextStyle(fontSize: 18,),),
              SizedBox(height: 4,),
              Text(time ,style: TextStyle(fontSize: 14,color: Color(0xFF71727A)),),
              SizedBox(height: 16,),
              _buildImageWidget(context,images),
              SizedBox(height: 16,),
              Text(content,style: TextStyle(fontSize: 14,color: Colors.black),),
            ],
          ),
        ),
      ),
    );
  }
}


Widget _buildImageWidget(BuildContext context,List<String> images) {
  // 이미지가 없을때
  if (images.isEmpty) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 240,
      color: Color(0xFFF5F6FA), child: Center(child: SvgPicture.asset('assets/icons/Image.svg', width: 71, height: 70),
      ),
    );
  } 
  //이미지가 하나뿐일때
  else if (images.length == 1) {
    return Image.network(images[0], fit: BoxFit.cover,);
  } 
  // 이미지가 두개 이상일때
  else {
    List<Widget> imageWidgets = images.map((imageUrl) => Image.network(imageUrl, fit: BoxFit.cover,),).toList();
    return CarouselSlider(
      items: imageWidgets, options: CarouselOptions(autoPlay: false,enlargeCenterPage: true,viewportFraction: 1.0,enableInfiniteScroll: false),
    );
  }
}
