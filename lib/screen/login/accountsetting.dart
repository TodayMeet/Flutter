import 'package:flutter/material.dart';

class accountsetting extends StatefulWidget {
  @override
  _accountsettingState createState() => _accountsettingState();
}

class _accountsettingState extends State<accountsetting> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('계정설정'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '아이디(이메일)',
              style: TextStyle(fontSize: 17),
            ),
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                hintText: '아이디를 입력하세요',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 13,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            Text(
              '* 이메일 주소는 "@"와 "."을 최소 하나 이상 포함되어야합니다.',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              '* 이미 가입된 이메일 주소입니다.',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 17.0),
            Text(
              '비밀번호',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '*2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 13,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            Text(
              '*2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 16.0),
            Text(
              '비밀번호 확인',
              style: TextStyle(fontSize: 17),
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '*2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 13,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            Text(
              '*2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 32.0),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 8.0,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => accountsetting()),
                    ),
                  );
                },
                child: Text('다음'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
