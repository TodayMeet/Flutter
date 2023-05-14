// 로그인 화면
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// sns 로그인 추가 디자인 수정
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/screen/login/pwFind.dart';
import 'Phone_ij.dart';
import 'package:front/screen/mainMap/mainPageMap.dart';
import 'idFind.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  String _text = '';
  String _text1 = '';


    // 비밀번호 찾기 버튼을 눌렀을 때 실행할 코드 작성


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Image.asset(
                "assets/images/LoginImage/logoimage.png",
                width: 180,
                height: 180,
                fit: BoxFit.cover,
              ),
              Image.asset("assets/images/LoginImage/titleimage.png"),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 10.0),
                child: TextField(
                  autofocus: true,
                  onChanged: (value) {
                    setState(() {
                      _text = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: '임시아이디 ghwmfap1234@naver.com',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 10.0),
                child: TextField(
                  obscureText: true,
                  autofocus: true,
                  onChanged: (value) {
                    setState(() {
                      _text1 = value;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: '임시비밀번호 asdf12345',
                      border: OutlineInputBorder()),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => idFind()),
                      );
                    },
                    child: Text(
                      '아이디 찾기',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text("|"),
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => pwFind()),
                      );
                    },
                    child: Text(
                      '비밀번호 찾기',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(327, 56)), // 변경할 크기를 지정합니다.
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_text == '') {
                        _login_fail_idnone(context);
                      } else if (_text1 == '') {
                        _login_fail_pwnone(context);
                      } else if (_text1 != 'asdf12345' ||
                          _text != 'ghwmfap1234@naver.com') {
                        _login_fail_incorrect(context);
                      } else {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPageMap()),
                        );
                      }
                    },
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPageMap()),
                    );
                  },
                  child: Image.asset(
                    'assets/images/LoginImage/kakao_login_large_wide.png',
                    width: 327,
                    height: 56,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                padding: const EdgeInsets.symmetric(vertical: 4.0),
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
              TextButton(
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
                    fontSize: 15,
                    color: Colors.black,
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

void _login_fail_idnone(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: const Text('아이디를 입력해주세요'),
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

void _backto_login(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: const Text('뒤로가기를 하실 경우 입력된 내용이 삭제됩니다.\n 이전화면으로 이동 하시겠습니까?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('확인'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('취소'),
        ),
      ],
    ),
  );
}
void _login_fail_alrephone(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: const Text('이미 가입된 휴대전화번호 입니다.'),
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
