// 모임 상세정보 로딩 페이지

// 최종 수정: 2023.6.5
// 작업자: 정해수

import 'package:flutter/material.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/screen/mainList/ListDetail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Loading extends StatefulWidget {
  const Loading({Key? key,
    required this.meetNo,
    required this.userNo,
  }) : super(key: key);

  final int meetNo;
  final int userNo;

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  var meetData;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {

    //meetNo로 서버에 meetList 데이터 요청
    try {
      http.Response jsonData = await http.get(Uri.parse('http://todaymeet.shop:8080/meet/detail/6'));
      if(jsonData.statusCode == 200) {

        meetData = jsonDecode(utf8.decode(jsonData.bodyBytes));

        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) =>ListDetail(meetData: meetData,))
        );
      } else {
        print('Data download failed!');
        await Future.delayed(const Duration(milliseconds: 1000));
        Navigator.pop(context);
      }
    } catch(e) {
      print('There was a problem with the internet connection.');
      await Future.delayed(const Duration(milliseconds: 1000));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StringText('건수 정보 불러오는 중...', 24, 'PretendardBold', Colors.black),
      ),
    );
  }
}
