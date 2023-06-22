import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/screen/profile/profileMain.dart';

class pwChange extends StatefulWidget {
  const pwChange({Key? key}) : super(key: key);

  @override
  State<pwChange> createState() => _pwChangeState();
}

class _pwChangeState extends State<pwChange> {
  final _currentpwController = TextEditingController();
  final _changepwController = TextEditingController();
  final _confirmpwController = TextEditingController();
  Color _starcolor = Color(0xffFF4910);
  Color _messagecolor = Color(0xffFF3D00);
  Color _hinttextcolor = Color(0xFFC8C8CB);
  Color _textfieldcolor = Color(0xFFF5F6FA);
  bool obscureText1 = true;
  bool obscureText2 = true;
  bool obscureText3 = true;
  Color _iconcolor = Color(0xffD0D0D0);

  @override
  void dispose() {
    _currentpwController.dispose();
    _changepwController.dispose();
    _confirmpwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String appbarText = '비밀번호 변경';
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Color(0xFFE3E3E3),
            height: 1.0,
          ),
        ),
        leading: IconButton(
            iconSize: 14.93,
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => profileMain()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF2F2F2F),
            )),
        //leading아이콘 혹시나 필요하면

        title: Text(
          appbarText,
          style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontFamily: 'PretendardBold'),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      '현재 비밀번호 ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      '* ',
                      style: TextStyle(
                          color: _starcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ],
                ), //현재 비밀번호 *
                SizedBox(height: 8.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    obscureText:obscureText1,
                    controller: _currentpwController,
                    decoration: InputDecoration(
                      hintText: '2자 이상 12자 이하 영문,숫자,특수기호만 입력가능',
                      hintStyle: TextStyle(fontSize: 13.0,color: _hinttextcolor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,
                      fillColor: Color(0xFFF5F6FA),
                      suffixIcon: IconButton(
                        onPressed: () {
                          obscureText1 = !obscureText1;
                        },
                        icon: Icon(
                          obscureText1 ? Icons.visibility : Icons.visibility_off,
                          color: _iconcolor,
                        ),
                      ),
                    ),
                  ),
                ),
                //텍스트필드
                SizedBox(height: 8.0),
                Text(
                  '* 2자 이상 12자 이하 영문, 숫자 특수기호만 입력 가능',
                  style: TextStyle(color: _messagecolor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      '새 비밀번호 ',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      '* ',
                      style: TextStyle(
                          color: _starcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ],
                ), //현재 비밀번호 *
                SizedBox(height: 8.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    obscureText:obscureText1,
                    controller: _changepwController,
                    decoration: InputDecoration(
                      hintText: '2자 이상 12자 이하 영문,숫자,특수기호만 입력가능',
                      hintStyle: TextStyle(fontSize: 13.0,color: _hinttextcolor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,
                      fillColor: Color(0xFFF5F6FA),
                      suffixIcon: IconButton(
                        onPressed: () {
                          obscureText1 = !obscureText1;
                        },
                        icon: Icon(
                          obscureText1 ? Icons.visibility : Icons.visibility_off,
                          color: _iconcolor,
                        ),
                      ),
                    ),
                  ),
                ),
                //텍스트필드
                SizedBox(height: 8.0),
                Text(
                  '* 2자 이상 12자 이하 영문, 숫자 특수기호만 입력 가능',
                  style: TextStyle(color: _messagecolor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      '새 비밀번호 확인 ',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      '* ',
                      style: TextStyle(
                          color: _starcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ],
                ), //현재 비밀번호 *
                SizedBox(height: 8.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    obscureText:obscureText3,
                    controller: _confirmpwController,
                    decoration: InputDecoration(
                      hintText: '2자 이상 12자 이하 영문,숫자,특수기호만 입력가능',
                      hintStyle: TextStyle(fontSize: 13.0,color: _hinttextcolor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,
                      fillColor: Color(0xFFF5F6FA),
                      suffixIcon: IconButton(
                        onPressed: () {
                          obscureText3 = !obscureText3;
                        },
                        icon: Icon(
                          obscureText3 ? Icons.visibility : Icons.visibility_off,
                          color: _iconcolor,
                        ),
                      ),
                    ),
                  ),
                ),
                //텍스트필드
                SizedBox(height: 8.0),
                Text(
                  '* 2자 이상 12자 이하 영문, 숫자 특수기호만 입력 가능',
                  style: TextStyle(color: _messagecolor),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 17.0),
            child: Center(
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
          ),//변경 버튼
        ],
      ),
    );
  }
}
