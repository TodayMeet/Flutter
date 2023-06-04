import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/screen/profile/profileMain.dart';

class pwChange extends StatefulWidget {
  const pwChange({Key? key}) : super(key: key);

  @override
  State<pwChange> createState() => _pwChangeState();
}

class _pwChangeState extends State<pwChange> {
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
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          '비밀번호 변경',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: null,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.only(left: 3.0),
              child: Text(
                '현재 비밀번호',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Container(
                width: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: _idController,
                  decoration: InputDecoration(

                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 12.0,
                    ),
                    hintText: '2자 이상 12자 이하 영문, 숫자 특수기호만 입력 가능',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '* 2자 이상 12자 이하 영문, 숫자 특수기호만 입력 가능',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 24.0),
            Padding(
              padding: EdgeInsets.only(left: 3.0),
              child: Text(
                '새 비밀번호',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Container(
                width: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 12.0,
                    ),
                    hintText: '2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Text(
              '*2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 24.0),
            Padding(
              padding: EdgeInsets.only(left: 3.0),
              child: Text(
                '새 비밀번호 확인',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Container(
                width: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 12.0,
                    ),
                    hintText: '2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Text(
              '*비밀번호가 일치합니다.',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              '*비밀번호가 일치하지 않습니다.',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              '*2자 이상 12 자 이하 영문, 숫자, 특수기호만 입력 가능합니다.',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 32.0),
            Spacer(),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 56,
                child: CupertinoButton(
                  onPressed: () {
                    // 입력시간 초과 -> _login_fail_timeover
                    // 성공했으면 -> _login_success_phoneij
                    //인증번호 틀리면 -> _login_fail_incorrectij
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => profileMain()),
                    );
                  },
                  minSize: 0,
                  padding: EdgeInsets.symmetric(),
                  color: CupertinoDynamicColor.resolve(
                    CupertinoColors.systemBlue,
                    context,
                  ).withAlpha(0xFF4874EA),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  child: Text(
                    '저장',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
