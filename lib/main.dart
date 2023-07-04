import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screen/search/searchMain.dart';
import 'screen/mainMap/mainPageMap.dart';
import 'screen/setting/registerMeeting.dart';
import 'screen/profile/profileMain.dart';
import 'screen/chat/chatlist.dart';

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
      theme: ThemeData(fontFamily: 'Pretendard'),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: MediaQuery(
            // 폰트 사이즈 일정하게 하기
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: child!,
          ),
        );
      },
      home: MainPage(),
    );
  }
}

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  int _selectedIndex = 0;

  void screenTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          // 메인 화면
          Navigator(
            onGenerateRoute: (settings){
              return MaterialPageRoute(
                  builder: (context) => const MainPageMap(),
                  settings: settings
              );
            },
          ),

          // 탐색 화면
          Navigator(
            onGenerateRoute: (settings){
              return MaterialPageRoute(
                  builder: (context) => const SearchMain(),
                  settings: settings
              );
            },
          ),

          // 건수 등록 화면
          Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                  builder: (context) => const RegisterMeeting(),
                  settings: settings,
              );
            },
          ),

          // 알림 화면
          Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => const chatlist(),
                settings: settings,
              );
            },
          ),

          // 내 정보 화면
          Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => const profileMain(),
                settings: settings,
              );
            },
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          // 메인 화면
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/Bottombar/Bottombar_first.png",
              scale: 4,
            ),
            label: 'Home'
          ),

          // 탐색 화면
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/Bottombar/Bottombar_second.png",
                scale: 4,
              ),
              label: 'Search'
          ),

          // 건수 등록 화면
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/Bottombar/Bottombar_center.png",
                scale: 4,
              ),
              label: 'Register'
          ),

          // 알림 화면
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/Bottombar/Bottombar_third.png",
                scale: 4,
              ),
              label: 'Alarm'
          ),

          // 내 정보 화면
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/Bottombar/Bottombar_fourth.png",
                scale: 4,
              ),
              label: 'MyInformation'
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: screenTapped,
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
