// 초대하기 버튼 팝업 페이지

// 최종 수정: 2023.6.2
// 작업자: 정해수

// 컨테이너 크기 자동 조절

import 'package:flutter/material.dart';
import 'package:front/model/TextPrint.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

int total = 0;

class Invitaiton extends ConsumerStatefulWidget {
  const Invitaiton({Key? key,
    required this.userNo,
    required this.meetNo,
    required this.userLimit,
    required this.curUserNum,
  }) : super(key: key);

  final int userNo;
  final int meetNo;
  final int userLimit;
  final int curUserNum;

  @override
  _InvitaitonState createState() => _InvitaitonState();
}

class _InvitaitonState extends ConsumerState<Invitaiton> {
  List<Map> friend = [
    {'name': "친구 1", 'image': 'assets/images/User_Picture/User_pic_null.png','ischecked': false},
    {'name': '친구 2', 'image': 'assets/images/User_Picture/User_pic_null.png','ischecked': false},
    {'name': '친구 3', 'image': 'assets/images/User_Picture/User_pic_null.png','ischecked': false},
    {'name': '친구 4', 'image': 'assets/images/User_Picture/User_pic_null.png','ischecked': false},
    {'name': '친구 5', 'image': 'assets/images/User_Picture/User_pic_null.png','ischecked': false},
  ];

  @override
  void initState() {
    super.initState();
    total = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2, //바텀바 크기
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
                height: MediaQuery.of(context).size.height / 3,
                child: ListView(
                  children: friend.map((friend){
                    return Column(
                      children: [
                        CheckboxListTile(
                          checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          title: StringText(friend['name'], 12, 'PretendardRegular', Colors.black),
                          secondary: Image.asset('assets/images/User_Picture/User_pic_null.png',
                              width: 26, height: 26),
                          value: friend['ischecked'],
                          onChanged: (value) {
                            setState(() {
                              if(total >= widget.userLimit - widget.curUserNum && value!) {
                                showToast('남은 모집 인원수보다 많이 초대할 수 없습니다');
                              } else {
                                friend['ischecked'] = value!;
                                friend['ischecked'] ? total++ : total--;
                              }
                            });
                          },
                        ),
                        line(),
                      ],
                    );
                  }).toList(),
                ),
              ), // 초대 가능 리스트
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: total == 0 ? null : () {
                      showToast('친구 초대가 완료되었습니다.');
                      total = 0;
                      Navigator.pop(context);
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

Widget line() {
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