// 모임 상세정보 로딩 페이지

// 최종 수정: 2023.6.27
// 작업자: 정해수

import 'package:flutter/material.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/screen/mainList/ListDetail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../model/showtoast.dart';

class Loading_to_ListDetail extends StatefulWidget {
  const Loading_to_ListDetail({Key? key,
    required this.meetNo,
    required this.userNo,
  }) : super(key: key);

  final int meetNo;
  final int userNo;

  @override
  State<Loading_to_ListDetail> createState() => _LoadingState();
}

class _LoadingState extends State<Loading_to_ListDetail> {
  var meetData;
  late int meetNo;
  late int userNo;

  @override
  void initState() {
    super.initState();
    getData();
  }

  //meetNo로 서버에 meetList 데이터 요청
  void getData() async {
    meetNo = widget.meetNo;
    userNo = widget.userNo;

    try {
      final url = Uri.parse('http://todaymeet.shop:8080/meet/detail/$meetNo');
      var postBody =
      {
        "userNo": userNo
      };

      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(postBody),
      );

      if (response.statusCode == 200) {
        meetData = jsonDecode(utf8.decode(response.bodyBytes));

        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => ListDetail(meetData: meetData,))
        );
      } else {
        print('Data download failed!');
        showToast('Data download failed!');
        Navigator.pop(context);
      }
    } catch (e) {
      print('There was a problem with the internet connection.');
      showToast('There was a problem with the internet connection.');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StringText('건수 정보 불러오는 중...', 24, FontWeight.w700, Colors.black),
      ),
    );
  }
}