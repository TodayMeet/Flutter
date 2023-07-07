import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'screen/mainMap/mainPageMap.dart';
import 'screen/mainList/mainListBoard.dart';
import 'screen/setting/setlocation.dart';
import 'screen/setting/setFilter.dart';
import 'screen/search/searchingBox.dart';
import 'screen/search/searchMain.dart';
import 'screen/setting/registerMeeting.dart';
import 'screen/profile/profileMain.dart';
import 'screen/alarm/alarm.dart';
import 'routes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final navigatorKeys = [
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
];

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  int _selectedIndex = 0;

  void screenTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      home: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            if(navigatorKeys[_selectedIndex].currentState!.canPop()){
              navigatorKeys[_selectedIndex].currentState!.pop();
            } else {
              if(_selectedIndex != 0){
                setState(() {
                  _selectedIndex = 0;
                });
              } else {
                SystemNavigator.pop();
              }
            }
            return false;
          },
          child: IndexedStack(
            index: _selectedIndex,
            children: <Widget>[
              // 메인 화면
              Navigator(
                key: navigatorKeys[0],
                onGenerateRoute: (settings) {
                  if (settings.name == Routes.boardPageRoute) {
                    return MaterialPageRoute(
                      builder: (context) => const MainListBoard(),
                      settings: settings,
                    );
                  } else if (settings.name == Routes.setLocationPageRoute) {
                    return MaterialPageRoute(
                        builder: (context) => LocationPage(),
                        settings: settings);
                  } else if (settings.name == Routes.filterPageRoute) {
                    return MaterialPageRoute(
                        builder: (context) => const Filter(),
                        settings: settings);
                  }
                  return MaterialPageRoute(
                    builder: (context) => const MainPageMap(),
                    settings: settings,
                  );
                },
              ),

              // 탐색 화면
              Navigator(
                key: navigatorKeys[1],
                onGenerateRoute: (settings) {
                  if (settings.name == Routes.searchBoxRoute) {
                    return MaterialPageRoute(
                      builder: (context) => searchBox(context),
                      settings: settings,
                    );
                  }
                  return MaterialPageRoute(
                      builder: (context) => searchMain(context),
                      settings: settings);
                },
              ),

              // 건수 등록 화면
              Navigator(
                key: navigatorKeys[2],
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => const RegisterMeeting(),
                    settings: settings,
                  );
                },
              ),

              // 알림 화면
              Navigator(
                key: navigatorKeys[3],
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => const alarm(),
                    settings: settings,
                  );
                },
              ),

              // 내 정보 화면
              Navigator(
                key: navigatorKeys[4],
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => const profileMain(),
                    settings: settings,
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: /*BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          onTap: screenTapped,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/Bottombar/home.svg",),
              label: "home",
            ),

            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/Bottombar/search.svg",),
              label: "search",
            ),

            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/Bottombar/register.svg",),
              label: "register",
            ),

            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/Bottombar/alarm.svg",),
              label: "alarm",
            ),

            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/Bottombar/my_information.svg",),
              label: "profile",
            ),
          ],
        ),*/

            Container(
          decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.08),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -4),
                  blurRadius: 8,
                  color: Color.fromRGBO(255, 255, 255, 0.1),
                  blurStyle: BlurStyle.outer,
                )
              ]),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 48,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: IconButton(
                  icon: SvgPicture.asset(
                    "assets/images/Bottombar/home.svg",
                    colorFilter: ColorFilter.mode(
                        _selectedIndex == 0
                            ? const Color(0xFF5E5F68)
                            : const Color(0xFFAEAFB3),
                        BlendMode.srcIn),
                  ),
                  onPressed: () {
                    screenTapped(0);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: IconButton(
                  icon: SvgPicture.asset(
                    "assets/images/Bottombar/search.svg",
                    colorFilter: ColorFilter.mode(
                        _selectedIndex == 1
                            ? const Color(0xFF5E5F68)
                            : const Color(0xFFAEAFB3),
                        BlendMode.srcIn),
                  ),
                  onPressed: () {
                    screenTapped(1);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: IconButton(
                  icon: SvgPicture.asset(
                      "assets/images/Bottombar/register.svg"),
                  onPressed: () {
                    screenTapped(2);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: IconButton(
                  icon: SvgPicture.asset(
                    "assets/images/Bottombar/alarm.svg",
                    colorFilter: ColorFilter.mode(
                        _selectedIndex == 3
                            ? const Color(0xFF5E5F68)
                            : const Color(0xFFAEAFB3),
                        BlendMode.srcIn),
                  ),
                  onPressed: () {
                    screenTapped(3);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: IconButton(
                  icon: SvgPicture.asset(
                    "assets/images/Bottombar/my_information.svg",
                    colorFilter: ColorFilter.mode(
                        _selectedIndex == 4
                            ? const Color(0xFF5E5F68)
                            : const Color(0xFFAEAFB3),
                        BlendMode.srcIn),
                  ),
                  onPressed: () {
                    screenTapped(4);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget searchBox(BuildContext context){
  return const SearchBox();
}

Widget searchMain(BuildContext context){
  return const SearchMain();
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
