// 휴대폰인증
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정

import 'dart:convert';
import 'package:front/model/profile/bluebutton.dart';

import '../../data/designconst/constants.dart';
import '../../model/dialogEx/dialoglist.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/profile/CustomAppBar.dart';
import '../../model/svgbutton/svgbutton.dart';
import '../profile/profileMain.dart';
import 'login.dart';
import 'accountsetting.dart';
import 'dart:async';

import 'signup.dart';

class Phone_ij extends StatefulWidget {
  @override
  State<Phone_ij> createState() => _Phone_ijState();
}

class _Phone_ijState extends State<Phone_ij> {
  String backarrow = 'assets/images/ProfileImage/backarrow.svg';
  String appbarText = '휴대전화 번호 인증';
  final TextEditingController _textEditingController = TextEditingController();
  String _text2 = '';
  String _text3 = '';
  int _countdown = 180;
  bool _isCountdownStarted = false;
  bool _ijSuccess = false;
  String phoneNumber = '';
  String apvNum = '';
  String buttonText = '다음';



  Future<void> phonenumDuplicate() async {
    final url = Uri.parse('http://todaymeet.shop:8080/phone/${phoneNumber}');
    // final requestData = {
    //   'phoneNumber': phoneNumber,
    // };
    // final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url,
      // headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      print('전송잘됨');
      print(phoneNumber);
      print(url);
      print(response.body);
      // final responseData = jsonDecode(response.body);
      if (response.body == 'phone number duplicate!!') {
        print("asdf");
        onebutton.alreadyphoneDialog(context);
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => accountsetting()));
      }
    } else {
      print('전송 자체가 안됨. 상태 침드: ${response.statusCode}');
      onebutton.alreadyphoneDialog(context);
    }
  }

  void startCountdown() {
    if (!_isCountdownStarted) {
      _isCountdownStarted = true;
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdown > 0) {
            _countdown--;
          } else {
            timer.cancel();
            _isCountdownStarted = false;
          }
        });
      });
    }
  }

  void resetCountdown() {
    setState(() {
      _isCountdownStarted = false;
      _countdown = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _countdown ~/ 60;
    int seconds = _countdown % 60;
    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
        appBar: CustomAppBar(
          leadingWidget: SvgButton(
            imagePath: backarrow,
            onPressed:() {
              twobutton.backtoLoginDialog(context);
            }),
          title: appbarText,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(children: [
            Row(children: [
              Text(
                "휴대전화번호",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "*",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              )
            ]),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              decoration: BoxDecoration(
                color: textfieldColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _text2 = value;
                        });
                      },
                      style: TextStyle(fontSize: 13.0),
                      decoration: InputDecoration(

                        hintText: '휴대전화번호를 입력해주세요',
                        hintStyle: TextStyle(color: hinttextColor, fontSize: 13.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (!_isCountdownStarted) {
                        startCountdown();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(8.0),
                        ),
                      ),
                      fixedSize: Size(107, 46),
                      backgroundColor: Colors.black,
                    ),
                    child: Text(
                      '인증번호 요청',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),



            SizedBox(height: 10.0),

            Container(
              padding: EdgeInsets.only(left: 16.0),
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              decoration: BoxDecoration(
                color: textfieldColor,
                borderRadius: BorderRadius.circular(10.0),

              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _text3 = value;
                        });
                      },
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: '인증번호',
                        hintStyle: TextStyle(color: hinttextColor,fontSize: 13.0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: 13.0),
                  Text(
                    '$minutes:${seconds.toString().padLeft(2, '0')}',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(width: 13.0),
                  ElevatedButton(

                    onPressed: () {
                      onebutton.certificationSuccessDialog(context);
                      //인증번호 틀리면 -> _login_fail_incorrectij
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(9),
                        ),
                      ),
                      fixedSize: Size(107, 46),
                      backgroundColor: Colors.black,
                    ),
                    child: Text(
                      '확인',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            blueButton(buttonText: buttonText, onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => accountsetting(),
                ),
              );
            },)

          ]),
        ));
  }
}
