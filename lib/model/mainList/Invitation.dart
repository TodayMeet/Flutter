// 초대하기 버튼 팝업 페이지

// 최종 수정: 2023.5.15
// 작업자: 정해수

// 컨테이너 크기 자동 조절

import 'package:flutter/material.dart';
import 'package:front/model/TextPrint.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Invitaiton extends ConsumerStatefulWidget {
  const Invitaiton({Key? key}) : super(key: key);

  @override
  _InvitaitonState createState() => _InvitaitonState();
}

class _InvitaitonState extends ConsumerState<Invitaiton> {
  bool _ischecked1 = false;
  bool _ischecked2 = false;
  bool _ischecked3 = false;
  bool _ischecked4 = false;
  bool _ischecked5 = false;
  int total = 0;

  Widget InvList(String name, Image image, bool check) {
    return CheckboxListTile(
      checkboxShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      title: StringText(name, 12, 'PretendardRegular', Colors.black),
      secondary: image,
      value: check,
      onChanged: (value) {
        setState(() {
          check = value!;
          check ? total++ : total--;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 300,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 50,),
              StringText('초대하기', 18, 'PretendardBold', Colors.black),
              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ), // 바텀 시트 제목, 나가기 버튼
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(24.0),
                height: 100,
                child: ListView(
                  children: [
                    CheckboxListTile(
                      checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      title: StringText('친구 1', 12, 'PretendardRegular', Colors.black),
                      secondary: Image.asset('assets/images/User_Picture/User_pic_null.png',
                          width: 26, height: 26),
                      value: _ischecked1,
                      onChanged: (value) {
                        setState(() {
                          _ischecked1 = value!;
                          _ischecked1 ? total++ : total--;
                        });
                      },
                    ),
                    Line(),
                    CheckboxListTile(
                      checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      title: StringText('친구 2', 12, 'PretendardRegular', Colors.black),
                      secondary: Image.asset('assets/images/User_Picture/User_pic_null.png',
                          width: 26, height: 26),
                      value: _ischecked2,
                      onChanged: (value) {
                        setState(() {
                          _ischecked2 = value!;
                          _ischecked2 ? total++ : total--;
                        });
                      },
                    ),
                    Line(),
                    CheckboxListTile(
                      checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      title: StringText('친구 3', 12, 'PretendardRegular', Colors.black),
                      secondary: Image.asset('assets/images/User_Picture/User_pic_null.png',
                          width: 26, height: 26),
                      value: _ischecked3,
                      onChanged: (value) {
                        setState(() {
                          _ischecked3 = value!;
                          _ischecked3 ? total++ : total--;
                        });
                      },
                    ),
                    Line(),
                    CheckboxListTile(
                      checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      title: StringText('친구 4', 12, 'PretendardRegular', Colors.black),
                      secondary: Image.asset('assets/images/User_Picture/User_pic_null.png',
                          width: 26, height: 26),
                      value: _ischecked4,
                      onChanged: (value) {
                        setState(() {
                          _ischecked4 = value!;
                          _ischecked4 ? total++ : total--;
                        });
                      },
                    ),
                    Line(),
                    CheckboxListTile(
                      checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      title: StringText('친구 5', 12, 'PretendardRegular', Colors.black),
                      secondary: Image.asset('assets/images/User_Picture/User_pic_null.png',
                          width: 26, height: 26),
                      value: _ischecked5,
                      onChanged: (value) {
                        setState(() {
                          _ischecked5 = value!;
                          _ischecked5 ? total++ : total--;
                        });
                      },
                    ),
                  ],
                ),
              ), // 초대 가능 리스트
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 14),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: total == 0 ? null : () {
                      showToast('친구 초대가 완료되었습니다.');
                    },

                    child: StringText('초대하기', 14, 'PretendardBold', Colors.white),
                  ),
                ),
              ), //초대하기 버튼
            ],
          ),
        ],
      ),
    );
  }
}

Widget Line() {
  return const Center(
    child: SizedBox(
      child: Divider(
        color: Color(0xffEBEBEB),
        thickness: 1.0,
      ),
    ),
  );
}

void showToast(String message) {
   Fluttertoast.showToast(
      msg: message,
      fontSize: 15,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM);
}