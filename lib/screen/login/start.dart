

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        print('유저넘버유저언머뷰저넘버유저넘버?${userNo}');
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
          //여백
          Spacer(),
          
          // 이미지 출력 - svg,png 둘다 깨짐 
          Container(
              padding: EdgeInsets.zero,
              width: 121,
              height: 84,
              child: SvgPicture.asset('assets/images/LoginImage/logoimage.svg')
          ),
          
          //여백
          Spacer(),
          
          //회사 이름 출력
          Text('ⓒbandeuthan', style: TextStyle(color: Color(0xFF626262), fontSize: 12.0, fontFamily: 'xeicon'),),
          
          //여백
          SizedBox(height: 52,),
        ]),
      ),
    );
  }
}





void saveLoginCredentials(String username, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', username);
  await prefs.setString('password', password);
}

