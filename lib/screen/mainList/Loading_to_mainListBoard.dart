// 모임 리스트 로딩 페이지

// 최종 수정: 2023.6.27
// 작업자: 정해수 -> 김혁

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:front/screen/mainList/mainListBoard.dart';
import '../../model/TextPrint.dart';

class Loading_to_mainListBoard extends StatefulWidget {
  const Loading_to_mainListBoard({Key? key}) : super(key: key);

  @override
  State<Loading_to_mainListBoard> createState() => _Loading_to_mainListBoardState();
}

class _Loading_to_mainListBoardState extends State<Loading_to_mainListBoard> {
  var meetListData;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      final url = Uri.parse('http://todaymeet.shop:8080/meet/list/대');
      var postBody =
      {
        "sort":'최신순',
        "page":0
      };

      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(postBody),
      );

      if (response.statusCode == 200) {
        meetListData = jsonDecode(utf8.decode(response.bodyBytes));

        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => MainListBoard(meetListData: meetListData,))
        );
      } else {
        print('Data download failed! : ${response.statusCode}');
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
        child: StringText(
            '건수 정보 불러오는 중...',
            24,
            FontWeight.w700,
            Colors.black),
      ),
    );
  }
}
