// 휴대폰인증
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정

import 'dart:convert';


import 'package:flutter/services.dart';
import 'package:front/model/UI/widget/text/textfieldTitle.dart';

import '../../data/designconst/constants.dart';
import '../../model/UI/widget/button/blueButton.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';
import '../../screen/dialog/dialoglist.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../profile/profileMain.dart';
import 'login.dart';
import 'accountsetting.dart';
import 'dart:async';


class Phone_ij extends StatefulWidget {
  @override
  State<Phone_ij> createState() => _Phone_ijState();
}

class _Phone_ijState extends State<Phone_ij> {


  final TextEditingController _textEditingController = TextEditingController();
  String _text2 = '';
  String _text3 = '';
  int _countdown = 180;
  bool _isCountdownStarted = false;
  bool isCodeSend = false;
  String phoneNumber = '';
  String apvNum = '';
  bool isDupicate = true;




  Future<void> phonenumDuplicate() async {
    final url = Uri.parse('http://todaymeet.shop:8080/phone/${phoneNumber}');
    final requestData = {
      'phoneNumber': phoneNumber,
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url,
      // headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {

      print('전송잘됨');
      print(phoneNumber);
      // print(url);
      // print(response.body);
      // final responseData = jsonDecode(response.body);
      if (response.body == 'phone number duplicate!!') {
        print('중복');
        print(phoneNumber);
        isCodeSend = false;
      } else {
        print('중복아님============================================');
        print(phoneNumber);
        isCodeSend = true;

      }
    } else {
      isCodeSend=false;
      print('전송 자체가 안됨. 상태 침드: ${response.statusCode}');
      print(phoneNumber);

    }
  }

  void startCountdown() {
    _isCountdownStarted = true;
    if (_isCountdownStarted) {

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
          title: '휴대전화 번호 인증',
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(children: [
            textfieldTitle(title: '휴대전화번호', star: true),
            SizedBox(height: 8,),
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
                      autofocus: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        NumberFormatter(), //숫자에 다시 넣어서
                        LengthLimitingTextInputFormatter(13) //010-1234-1234 이거 13자리
                      ],
                      onChanged: (value) {
                        setState(() {
                          _text2 = value;
                        });
                        phoneNumber = _text2;
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
                  Container(
                    width: 110,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () {
                        phonenumDuplicate();
                        if(isCodeSend){
                          _isCountdownStarted=false;
                          startCountdown();
                        }else{
                          onebutton.alreadyphoneDialog(context);
                        }

                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return 0;
                          }
                          return 0.5; // 이건 디폴트
                        }),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(12.0)),
                          ),
                        ),
                        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                        backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            // 버튼이 눌려 있을 때의 배경색
                            //color: rgb(72,116,234);
                            return Colors.black54; //
                          }
                          return Colors.black; // 기본 배경색
                        }),
                      ),

                      // style: ElevatedButton.styleFrom(
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.horizontal(
                      //       right: Radius.circular(8.0),
                      //     ),
                      //   ),
                      //   fixedSize: Size(107, 46),
                      //   backgroundColor: Colors.black,
                      // ),
                      child: Text(
                        '인증번호 요청',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
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
                        fontSize: 10.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(width: 13.0),

                  Container(
                    width: 110,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () {

                        if(_countdown==0){
                          onebutton.inputTimeOverDialog(context);
                        }else{
                          onebutton.certificationSuccessDialog(context);
                        }
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            // 버튼 눌려있을때는 높이 0으로 해놓고
                            return 0;
                          }
                          return 0.5; // 이건 디폴트
                        }),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(12.0)),
                          ),
                        ),
                        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                        backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            // 버튼이 눌려 있을 때의 배경색
                            //color: rgb(72,116,234);
                            return Colors.black54; //
                          }
                          return Colors.black; // 기본 배경색
                        }),
                      ),
                      child: Text(
                        '확인',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            blueButton(buttonText: '다음', onPressed: (){
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


class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex <= 3) {
        if (nonZeroIndex % 3 == 0 && nonZeroIndex != text.length) {
          buffer.write('-'); // Add double spaces.
        }
      } else {
        if (nonZeroIndex % 7 == 0 &&
            nonZeroIndex != text.length &&
            nonZeroIndex > 4) {
          buffer.write('-');
        }
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}