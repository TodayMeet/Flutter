// 휴대폰인증
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'accountsetting.dart';


import 'signup.dart';

class Phone_ij extends StatefulWidget {
  @override
  State<Phone_ij> createState() => _Phone_ijState();
}

class _Phone_ijState extends State<Phone_ij> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => login(),
              ),
            );
            },
          ),
          middle: Text('휴대전화 번호 인증'),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
            ),
            child: Row(children: [
              Text(
                "휴대전화번호",
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                "*",
                style: TextStyle(
                  color: Colors.red,
                ),
              )
            ]),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              border: Border.all(
                width: 1.0,
                color: Colors.red,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      labelText: '휴대전화번호를 입력해주세요',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => accountsetting(),
                      ),
                    );

                    // 버튼이 클릭되었을 때 수행할 작업
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(20), // 오른쪽 위와 아래 모서리 둥글기 설정
                      ),
                    ),
                  ),
                  child: Text('버튼'),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              border: Border.all(
                width: 1.0,
                color: Colors.red,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      labelText: '휴대전화번호를 입력해주세요',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signup(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(10), // 오른쪽 위와 아래 모서리 둥글기 설정
                      ),
                    ),
                  ),
                  child: Text('버튼'),
                ),
              ],
            ),
          )
        ]));
  }
}
