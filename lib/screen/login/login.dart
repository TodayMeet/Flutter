
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:front/screen/login/start.dart';

import '../../data/designconst/constants.dart';

import '../../data/userNo.dart';
import '../../screen/dialog/dialoglist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../main.dart';
import 'package:front/screen/login/pwFind.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Phone_ij.dart';
import 'package:front/screen/mainMap/mainPageMap.dart';
import 'idFind.dart';
import 'pwFind.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}//login statefulwidget

class _loginState extends State<login> {
  String _text = '';
  String _text1 = '';
  String email = '';
  String password = '';
  bool obscureText = true;
  // String loginresult2 = '';
  final regex = RegExp(r'^[a-zA-Z@,.]+$');
  bool idformat = true;
  bool pwformat = true;
  String? token = '';

  Future<void> getToken() async {
    // String? token;

    if(defaultTargetPlatform == TargetPlatform.iOS ||defaultTargetPlatform == TargetPlatform.macOS||defaultTargetPlatform == TargetPlatform.android) {
      debugPrint("===================token=======================================");
      token = await FirebaseMessaging.instance.getToken();
    }
    else{
      token = await FirebaseMessaging.instance.getToken();
    }
    debugPrint("fcmToken : $token");// 이 토큰이 있어야 서버에서 알림을 보낼 수 있습니다.
  }

  Future<int> sendCredentialsToServer() async {
    final url = Uri.parse('http://todaymeet.shop:8080/loginB');
    final requestData = {
      'email': email,
      'password': password,
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
      // Get.to( MainPageMap(),arguments: userNo);
      await getToken();
      final sendToken = {
        'userNo' : userNo,
        'token' : token
      };
      final jsonData1 = jsonEncode(sendToken);
      final tokenurl = Uri.parse('http://todaymeet.shop:8080/fcm/token');
      final response1 = await http.post(
        tokenurl,
        body: jsonData1,
        headers: {'Content-Type': 'application/json'},
      );
      print(response1.body);

      if(response1.body=='success'){
        UserNo.myuserNo = userNo;

        await storage.write(
          key: "login",
          value: "id $email password $password",
        );
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppPage()));
      }
      return userNo;
    }else if(_text==null ){
      onebutton.noInputIDDialog(context);
      return 0;
    }

    else if(_text1 ==null){
      onebutton.noInputPwDialog(context);
      return 0;
    }
    else {
      print('로그인 실패. 상태 코드: ${response.statusCode}');
      onebutton.incorrectInputDialog(context);
      return 0;
    }
  } //서버로 전송

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              logoImage(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      height: 48.0,
                      child: TextField(
                        autofocus: false,
                        onChanged: (value) {
                          setState(() {
                            _text = value;
                          //   if (!regex.hasMatch(value)) {
                          //     idformat=false;
                          //   } 아이디가 형식에 맞지 않으면 또 다른 다이얼로그 출력
                          });
                          email = _text;
                        },
                        // textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: '아이디',
                          hintStyle: TextStyle(color: Color(0xFFD1D1D4),fontSize: 13.0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.0)),
                          filled: true,
                          fillColor: Color(0xFFF5F6FA),
                        ),
                      ),
                    ),//아이디 입력 텍스트 필드

                    SizedBox(height: 8.0,),

                    Container(
                      height: 48,
                      child: TextField(
                        obscureText: obscureText,
                        autofocus: false,
                        onChanged: (value) {
                          setState(() {
                            _text1 = value;
                          });
                          password = _text1;
                        },
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: '비밀번호',
                          hintStyle: TextStyle(color: Color(0xFFD1D1D4),fontSize: 13.0,fontFamily: 'Inter'),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.0)),
                          filled: true,
                          fillColor: Color(0xFFF5F6FA),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: SvgPicture.asset(
                              obscureText
                              ?   'assets/icons/detail/Visibility.svg'
                              :   'assets/icons/detail/Visibility_off.svg',
                              color: Color(0xFFD0D0D0),
                            )

                          ),
                        ),
                      ),
                    ),//비밀번호 입력 텍스트 필드

                    idpwfind(findtextColor: Color(0xFFB7B7B7)),//아이디찾기 | 비밀번호찾기

                    SizedBox(height: 24.0,),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 56.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      sendCredentialsToServer();


                    },
                    child: Text(
                      '로그인',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    style: CustomButtonStyle(Colors.black, Colors.black87, Colors.transparent),
                  ),
                ),//로그인

                    SizedBox(height: 24.0,),

                    divideLine(),//로그인 - 카카오로그인 사이 구분선
                    SizedBox(height:  24.0),

                    kakaologinbutton(),//카카오 로그인
                    SizedBox(height: 12.0,),

                    naverloginbutton(),//네이버 로그인
                    SizedBox(height: 12.0,),

                    googleloginbutton(),//구글 로그인
                    SizedBox(height: 12.0,),
                    signupbutton(),//회원가입 버튼
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class divideLine extends StatelessWidget {
  const divideLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1.0, // 선의 높이
      color: Colors.grey.withOpacity(0.5), // 희미한 선의 색상
    );
  }
}

// class loginButton extends StatelessWidget {
//   const loginButton({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       height: 56.0,
//       child: ElevatedButton(
//         onPressed: () {
//           sendCredentialsToServer();
//         },
//         child: Text(
//           '로그인',
//           style:
//               TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//         ),
//         style: CustomButtonStyle(Colors.black, Colors.black87, Colors.transparent),
//       ),
//     );
//   }
// }

class googleloginbutton extends StatelessWidget {
  const googleloginbutton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 56.0,
      child: ElevatedButton(
        onPressed: () {
          // sendCredentialsToServer();

        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/LoginImage/google.svg',width: 24,height: 24,fit: BoxFit.cover,),
              SizedBox(width: 8.0,),
              Text('구글 로그인', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: Color(0xFF333333)),),
            ],
          ),
        ),
        style: CustomButtonStyle(Colors.white,Color(0xFFF0F0F0),Color(0xFFCBCBCB)),
      ),
    );
  }
}

class naverloginbutton extends StatelessWidget {
  const naverloginbutton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 56.0,
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('',style: TextStyle(fontSize: 24.0,fontFamily: 'xeicon',color: Color(0xFFFFFFFF)),),
            SizedBox(width: 5.5,),
            Text(
              '네이버 로그인',
              style:
              TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,color: Color(0xFFFFFFFF)),
            ),
          ],
        ),
        // style: ElevatedButton.styleFrom(
        //   elevation: 0,
        //   primary: Color(0xFF02C63C),
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(12.0),
        //   ),
        // ),
        style: CustomButtonStyle(Color(0xFF02C63C), Color(0xFF01B237), Colors.transparent),

      ),
    );
  }
}

class kakaologinbutton extends StatelessWidget {
  const kakaologinbutton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 56.0,
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('',style: TextStyle(fontSize: 24.0,fontFamily: 'xeicon',color: Color(0xFF070E04)),),
            SizedBox(width: 8,),
            Text(
              '카카오톡 로그인',
              style:
              TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700,color: Color(0xFF070E04)),
            ),
          ],
        ),
        style: CustomButtonStyle(Color(0xFFFFE711), Color(0xFFF7E000), Colors.transparent),
      ),
    );
  }
}

class signupbutton extends StatelessWidget {
  const signupbutton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 56.0,
      child: Center(
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Phone_ij(),
              ),
            );
          },
          child: Text(
            '회원가입',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: Color(0xFF71727A),
            ),
          ),
          style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return 0;
              }
              return 0;
            }),
            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.white;
              }
              return Colors.white;
            }),
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          ),
        ),
      ),
    );
  }
}

class idpwfind extends StatelessWidget {
  const idpwfind({
    super.key,
    required this.findtextColor,
  });

  final Color findtextColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => idFind()),
            );
          },
          child: Text(
            '아이디찾기',
            style: TextStyle(
              fontSize: 12.0,
              color: findtextColor,
            ),
          ),
        ),
        Text(
          "|",
          style: TextStyle(
            fontSize: 12.0,
            color: findtextColor,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pwFind()),
            );
          },
          child: Text(
            '비밀번호 찾기',
            style: TextStyle(
              fontSize: 12.0,
              color: findtextColor,
            ),
          ),
        ),
      ],
    );
  }
}

class logoImage extends StatelessWidget {
  const logoImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Container(
        width: 375,
        height: 334,
        child: Center(
          child: SvgPicture.asset(
            "assets/images/LoginImage/logoimage.svg",
            width: 121,
            height: 84,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}// loginState class

// 로그인 성공시 email, userpassword 저장
void saveLoginCredentials(String email, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email);
  await prefs.setString('password', password);
}// 서버로 email, password 보내는 함수

void _login_fail_pwnone(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: const Text('비밀번호를 입력해주세요'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('확인'),
        ),
      ],
    ),
  );
}//비밀번호 확인 팝업

// class MyController extends GetxController {
//   var userNo = 0;
//
//   // void increment() {
//   //   count++;
//   //   update(); // 상태 변경을 알리기 위해 update()를 호출합니다.
//   // }
// }