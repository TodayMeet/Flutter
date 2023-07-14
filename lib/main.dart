import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
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
import 'screen/login/start.dart';
import 'routes.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // firebase_options import 후 options 지정을 해줘야 init이 정상적으로 진행됨
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // setting 함수
  await setupFlutterNotifications();
  
  // 세로화면 고정
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: MyApp()));
}

// 필요 변수
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false; // 셋팅여부 판단 flag

/// 셋팅 메소드
Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.high,
  );

  //debugPrint(channel as String?);
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // iOS foreground notification 권한
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // IOS background 권한 체킹 , 요청
  // await FirebaseMessaging.instance.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // ); // ios 권한설정을 하지 않았기 때문에 문제발생 이후 권한설정을 하면 해당 주석을 삭제하기
  //debugPrint("5");

  // 토큰 요청
  getToken();

  // 셋팅flag 설정
  isFlutterLocalNotificationsInitialized = true;
}

Future<void> getToken() async {
  String? token;

  if (defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.android) {
    debugPrint(
        "===================token=======================================");
    token = await FirebaseMessaging.instance.getToken();
  } else {
    token = await FirebaseMessaging.instance.getToken();
  }
  debugPrint("fcmToken : $token"); // 이 토큰이 있어야 서버에서 알림을 보낼 수 있습니다.
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // foreground 수신처리
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    // background 수신처리
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
      home: Start(),
    );
  }
}

final navigatorKeys = [
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
];

class MyAppPage extends ConsumerStatefulWidget {
  const MyAppPage({super.key});

  @override
  MyAppPageState createState() => MyAppPageState();
}

class MyAppPageState extends ConsumerState<MyAppPage> {
  int _selectedIndex = 0;

  void screenTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            if (navigatorKeys[_selectedIndex].currentState!.canPop()) {
              navigatorKeys[_selectedIndex].currentState!.pop();
            } else {
              if (_selectedIndex != 0) {
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
                        builder: (context) => LocationPage(), settings: settings);
                  } else if (settings.name == Routes.filterPageRoute) {
                    return MaterialPageRoute(
                        builder: (context) => const Filter(), settings: settings);
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
        bottomNavigationBar: Container(
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
                  icon: SvgPicture.asset("assets/images/Bottombar/register.svg"),
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

/// fcm 배경 처리 (종료되어있거나, 백그라운드에 경우)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //debugPrint("1");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //debugPrint("2");
  await setupFlutterNotifications(); // 셋팅 메소드
  //showFlutterNotification(message);  // 로컬노티
  //debugPrint("3");
}

/// fcm 전경 처리 - 로컬 알림 보이기
void showFlutterNotification(RemoteMessage message) {
  debugPrint("---------------------------------------------");

  //debugPrint(data.keys as String?);
  RemoteNotification? notification = message.notification;
  debugPrint(notification!.title); // title
  debugPrint(notification.body); // body
  Map<String, dynamic> data = message.data;
  if (data['type'].toString() == "1") {
    debugPrint("--------------------------- type Chat");
  } else {
    debugPrint("--------------------------- type Notifi");
    alarmrefreshController.requestRefresh();
  }
  data.forEach((key, value) {
    debugPrint('Key: $key, Value: $value');
  });

  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    // 웹이 아니면서 안드로이드이고, 알림이 있는경우
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

Widget searchBox(BuildContext context) {
  return const SearchBox();
}

Widget searchMain(BuildContext context) {
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
      axisDirection: axisDirection,
      color: Colors.transparent,
      showLeading: false,
      showTrailing: false,
      child: child,
    );
  }
}
