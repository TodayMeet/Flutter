import 'package:flutter/material.dart';
import 'package:front/screen/mainList/Loading_to_mainListBoard.dart';
import 'screen/setting/setFilter.dart';
import 'screen/mainMap/mainPageMap.dart';
import 'package:front/screen/login/start.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      builder: (context, child) {
        return MediaQuery(      // 폰트 사이즈 일정하게 하기
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
      home: MainPage(),
    );
  } 
}

class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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