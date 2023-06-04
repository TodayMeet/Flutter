// 시작 화면
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정

import 'package:flutter/material.dart';
import 'dart:async';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Start extends StatefulWidget {
  @override
  _Start createState() => _Start();
}

class _Start extends State<Start> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => login(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Spacer(),
        Image.asset(
          'assets/images/LoginImage/logoimage.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 127.0),
          child: Image.asset(
            'assets/images/LoginImage/titleimage.png',
            fit: BoxFit.contain,
          ),
        ),
        Spacer(),
        Text("ⓒbandeuthan"),
        SizedBox(
          height: 52,
        ),
      ])),
    );
  }
}


// void _registerMeet() async {
//   final url = Uri.parse("http://todaymeet.shop:8080/meet/add");
//   final Map<String, dynamic> jsonData = {
//     'category':{
//       'categoryNo': meet.meetInfo.categoryNo
//     },
//     'address' : meet.meetInfo.address,
//     'lat' : meet.meetInfo.lat,
//     'lon' : meet.meetInfo.lon,
//     'time' : meet.meetInfo.time,
//     'age' : meet.meetInfo.age,
//     'peopleLimit' : meet.meetInfo.peopleLimit,
//     'fee' : meet.meetInfo.fee,
//     'title' : meet.meetInfo.title,
//     'content' : meet.meetInfo.content,
//     'approval' : meet.meetInfo.approval,
//     'user': {
//       'userNo' : 1
//     },
//   };
//
//   final response = await http.post(
//     url,
//     headers: {'Content-Type' : 'application/json'},
//     body: json.encode(jsonData),
//   );
//
//   if (response.statusCode == 200) {
//     print(json.decode(response.body));
//   } else {
//     throw Exception('Failed to post data');
//   }
// }



// Future<void> _registerMeet() async {
//   final url = Uri.parse("http://todaymeet.shop:8080/meet/add");
//   final Map<String, dynamic> jsonData = {
//     'category': {
//       'categoryNo': meet.meetInfo.categoryNo
//     },
//     'address': meet.meetInfo.address,
//     'lat': meet.meetInfo.lat,
//     'lon': meet.meetInfo.lon,
//     'time': meet.meetInfo.time,
//     'age': meet.meetInfo.age,
//     'peopleLimit': meet.meetInfo.peopleLimit,
//     'fee': meet.meetInfo.fee,
//     'title': meet.meetInfo.title,
//     'content': meet.meetInfo.content,
//     'approval': meet.meetInfo.approval,
//     'user': {
//       'userNo': await getUserNo() // userNo를 받는 함수를 호출하여 값을 가져옵니다.
//     },
//   };
//
//   final response = await http.post(
//     url,
//     headers: {'Content-Type': 'application/json'},
//     body: json.encode(jsonData),
//   );
//
//   if (response.statusCode == 200) {
//     print(json.decode(response.body));
//   } else {
//     throw Exception('Failed to post data');
//   }
// }
//
// Future<int> getUserNo() async {
//   final userNoResponse = await http.get(Uri.parse("http://todaymeet.shop:8080/meet/add"));
//   if (userNoResponse.statusCode == 200) {
//     final userData = json.decode(userNoResponse.body);
//     return userData['userNo'];
//   } else {
//     throw Exception('Failed to get userNo');
//   }
// }
