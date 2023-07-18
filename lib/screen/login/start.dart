// 시작 화면
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/userNo.dart';
import '../../main.dart';
import 'login.dart';

const storage = FlutterSecureStorage();

class Start extends StatefulWidget {
  @override
  _Start createState() => _Start();
}

class _Start extends State<Start> {
  // List<dynamic> data = [];

  String? userInfo = '';

  @override
  void initState() {
    super.initState();

    //비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        _asyncMethod();
      });
    });
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오기
    //(데이터가 없을때는 null을 반환을 합니다.)
    userInfo = await storage.read(key: "login");
    print(userInfo);

    //user의 정보가 있다면 서버를 통해 userNo 받아 오고 메인 페이지로 가기
    if (userInfo != null) {
      print('------------------------------자동 로그인------------------------------');
      final url = Uri.parse('http://todaymeet.shop:8080/loginB');
      final requestData = {
        'email': userInfo!.split(" ")[1],
        'password': userInfo!.split(" ")[3],
      };
      final jsonData = jsonEncode(requestData);
      final response = await http.post(
        url,
        body: jsonData,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        print('로그인 성공');
        final userNo = jsonDecode(response.body);
        print("userNo : ");
        print(userNo);
        UserNo.myuserNo = userNo;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (builder)=>MyAppPage())
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (builder)=>login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: startContent(),
    );
  }
}

//startContent - 내부 내용 수록
class startContent extends StatelessWidget {
  const startContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Spacer(),
          startImage(),
          Spacer(),
          startCompanyName(),
          SizedBox(
            height: 52,
          ),
        ]),
      ),
    );
  }
}

//startImage : 로고 이미지 출력하는 부분
class startImage extends StatelessWidget {
  const startImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      width: 121,
      height: 84,
      child: Image.asset('assets/images/LoginImage/logoimage.png'),
    );
  }
}

//startCompanyName : 반듯한 컴퍼니 출력한느 부분
class startCompanyName extends StatelessWidget {
  const startCompanyName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'ⓒbandeuthan',
      style: TextStyle(
          color: Color(0xFF626262), fontSize: 12.0, fontFamily: 'xeicon'),
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

// @override
// void initState() {
//   super.initState();
//   Timer(Duration(seconds: 2), () {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => login(),
//       ),
//     );
//   });
//   // fetchData();
// }
