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
import 'package:shared_preferences/shared_preferences.dart';

class Start extends StatefulWidget {
  @override
  _Start createState() => _Start();
}

class _Start extends State<Start> {
  List<dynamic> data = [];
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
    // fetchData();
  }
  // Future<void> fetchData() async {
  //   final response = await http.get(Uri.parse('http://todaymeet.shop:8080/loginB'));
  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body);
  //     setState(() {
  //       data = jsonResponse;
  //     });
  //   } else {
  //     print('데이터 가져오기 실패. 상태 코드: ${response.statusCode}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Spacer(),
        Image.asset(
          'assets/images/LoginImage/logoimage.png',
          // width: 100,
          // height: 56,
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

void saveLoginCredentials(String username, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', username);
  await prefs.setString('password', password);
}

// Future<bool> tryAutoLogin() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String username = prefs.getString('username');
//   String password = prefs.getString('password');
//
//   // 저장된 로그인 정보가 있는 경우
//   if (username != null && password != null) {
//     // 서버로 로그인 요청을 보내고 성공 여부를 확인합니다.
//     bool loginSuccess = await login(username, password);
//
//     if (loginSuccess) {
//       // 로그인 성공 시 필요한 작업을 수행합니다.
//       return true;
//     } else {
//       // 저장된 로그인 정보는 있지만, 서버에서 로그인 실패한 경우
//       // 저장된 로그인 정보를 삭제합니다.
//       await clearLoginCredentials();
//       return false;
//     }
//   } else {
//     // 저장된 로그인 정보가 없는 경우
//     return false;
//   }
// }

// void _startdataload() async {
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
//

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
