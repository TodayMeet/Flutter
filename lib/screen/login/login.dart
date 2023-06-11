// 로그인 화면
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// sns 로그인 추가 디자인 수정
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
}

class _loginState extends State<login> {
  String _text = '';
  String _text1 = '';
  String username = '';
  String password = '';
  bool obscureText = true;
  String loginresult2 = 'ㅗ';
  Future<void> sendCredentialsToServer() async {
    final url = Uri.parse('http://todaymeet.shop:8080/loginB');
    final requestData = {
      'username': username,
      'password': password,
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.post(
      url,
      body: jsonData,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      // 성공적으로 서버로 전송됨
      print('로그인 성공');
      final responseData = jsonDecode(response.body);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPageMap()));
    } else {
      print('로그인 실패. 상태 코드: ${response.statusCode}');
      _login_fail_incorrect(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 125.50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.asset(
                  "assets/images/LoginImage/logoimage.png",
                  width: 100,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.asset(
                  "assets/images/LoginImage/titleimage.png",
                  width: 121,
                  height: 26.54,
                ),
              ),
              SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  height: 48.0,
                  child: TextField(
                    autofocus: true,
                    onChanged: (value) {
                      setState(() {
                        _text = value;
                      });
                      username = _text;
                    },
                    decoration: InputDecoration(
                      // labelText: '임시 아이디 :m',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,
                      fillColor: Color(0xFFF5F6FA),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                child: SizedBox(
                  height: 48,
                  child: TextField(
                    obscureText: obscureText,
                    autofocus: true,
                    onChanged: (value) {
                      setState(() {
                        _text1 = value;
                      });
                      password = _text1;
                    },
                    decoration: InputDecoration(
                      // labelText: '임시 비밀번호:et',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,
                      fillColor: Color(0xFFF5F6FA),
                      suffixIcon: IconButton(
                        onPressed: () {
                          obscureText = !obscureText;
                        },
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
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
                      '아이디 찾기',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF71727A),
                      ),
                    ),
                  ),
                  Text(
                    "|",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF71727A),
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
                        color: Color(0xFF71727A),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 6.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 56.0,
                  child: ElevatedButton(
                    onPressed: () {
                      sendCredentialsToServer();
                    },
                    child: Text(
                      '로그인',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 18.0, horizontal: 24.0),
                child: Divider(
                  height: 1.0, // 선의 높이
                  color: Colors.grey.withOpacity(0.5), // 희미한 선의 색상
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPageMap()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0),
                    child: Image.asset(
                      'assets/images/LoginImage/kakao_login_large_wide.png',
                      width: MediaQuery.of(context).size.width,
                      height: 56,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainPageMap()),
                      );
                    },
                    child: Image.asset(
                      'assets/images/LoginImage/naverlogin.png',
                      width: 327,
                      height: 56,
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainPageMap()),
                      );
                    },
                    child: Image.asset(
                      'assets/images/LoginImage/googlelogin.png',
                      width: 327,
                      height: 56,
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 24.0),
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
                      fontSize: 14,
                      color: Color(0xFF71727A),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 로그인 성공시 username, userpassword 저장
void saveLoginCredentials(String username, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', username);
  await prefs.setString('password', password);
}

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
}

void _login_fail_incorrect(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: const Text('입력하신 아이디 또는 비밀번호가 일치하지 않습니다.\n 확인 후 다시 입력해주세요.'),
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
}
//
// void _backto_login(BuildContext context) {
//   showCupertinoModalPopup<void>(
//     context: context,
//     builder: (BuildContext context) => CupertinoAlertDialog(
//       content: const Text('뒤로가기를 하실 경우 입력된 내용이 삭제됩니다.\n 이전화면으로 이동 하시겠습니까?'),
//       actions: <CupertinoDialogAction>[
//         CupertinoDialogAction(
//           isDefaultAction: true,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('확인'),
//         ),
//         CupertinoDialogAction(
//           isDefaultAction: true,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('취소'),
//         ),
//       ],
//     ),
//   );
// }
//
// void _login_fail_alrephone(BuildContext context) {
//   showCupertinoModalPopup<void>(
//     context: context,
//     builder: (BuildContext context) => CupertinoAlertDialog(
//       content: const Text('이미 가입된 휴대전화번호 입니다.'),
//       actions: <CupertinoDialogAction>[
//         CupertinoDialogAction(
//           isDefaultAction: true,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('확인'),
//         ),
//       ],
//     ),
//   );
// }
