import 'package:flutter/material.dart';
import 'login.dart';

class LoginFailPhoneij extends StatefulWidget {
  const LoginFailPhoneij({Key? key}) : super(key: key);

  @override
  State<LoginFailPhoneij> createState() => _LoginFailPhoneijState();
}

class _LoginFailPhoneijState extends State<LoginFailPhoneij> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
          child: Container(
        alignment: Alignment.center,
        width: 380,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text("\n"),
            Text(
              '인증번호가 올바르지 않습니다.\n다시 시도해주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
            Text("\n "),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => login()),
                );
              },
              child: Text('확인'),
            ),
          ],
        ),
      )),
    );
  }
}
