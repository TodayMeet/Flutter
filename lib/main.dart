import 'package:flutter/material.dart';
import 'package:front/screen/login/login.dart';
import 'package:front/screen/mainList/Loading_to_mainListBoard.dart';
import 'package:front/screen/profile/profileMain.dart';
import 'package:get/get.dart';

import 'screen/setting/setFilter.dart';
import 'screen/mainMap/mainPageMap.dart';
import 'package:front/screen/login/start.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/data/designconst/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:front/screen/login/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';


void main() {

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Pretendard'
      ),
      builder: (context, child) {
        return MediaQuery(      // 폰트 사이즈 일정하게 하기
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },

      home: MainPage(),//나중에 Start로 설정
    );
  } 
}

class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Pretendard",
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Main Page'),
        ),
        body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('로그인'),
                  onPressed: (){

                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => Start()));
                  },
                ),
                ElevatedButton(
                  child: Text('필터'),
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => Filter()));
                  },
                ),
                ElevatedButton(
                  child: Text('메인페이지-지도'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => MainPageMap()));
                  }
                ),
                ElevatedButton(    
                  child: Text('게시판'),
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => Loading_to_mainListBoard()));
                  },
                ),

              ],
            )
        ),

      ),
    );
  }
}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context,
      Widget child,
      AxisDirection axisDirection,
      ) {
    return GlowingOverscrollIndicator(
      child: child,
      axisDirection: axisDirection,
      color: Colors.transparent,
      showLeading: false,
      showTrailing: false,
    );
  }
}

// 시작 화면
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정


class Start extends StatefulWidget {
  @override
  _Start createState() => _Start();
}

class _Start extends State<Start> {
  // List<dynamic> data = [];
  String imageLocation = 'assets/images/LoginImage/logoimage.svg';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
      width: 121,
      height: 84,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: SvgPicture.asset(
          "assets/images/LoginImage/logoimage.svg",
          fit: BoxFit.contain,
        ),
      ),
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
    return Text('ⓒbandeuthan',style: TextStyle(color: Color(0xFF626262),fontSize: 12.0,fontFamily: 'xeicon'),);
  }
}

