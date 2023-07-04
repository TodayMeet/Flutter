// 초대하기 버튼 팝업 페이지

// 최종 수정: 2023.6.27
// 작업자: 정해수 -> 김혁

// 컨테이너 크기 자동 조절

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      height: 284, //바텀바 크기
      width: double.infinity,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurStyle: BlurStyle.outer,
            blurRadius: 30,
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(24)
        )
      ),
      child: Column(
        children: [
          AppBar(
            elevation: 0,
            toolbarHeight: 50,
            backgroundColor: Colors.white,
            centerTitle: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24)
                )
            ),
            title: const Text(
              "초대하기",
              style: TextStyle(
                color: Color(0xFF1F2024),
                fontWeight: FontWeight.w700,
                fontSize: 18,
                letterSpacing: 0.09,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/close.svg",
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ), // 바텀 시트 제목, 나가기 버튼
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 170,
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: ListView(
                  children: friend.map((friend){
                    return Column(
                      children: [
                        SizedBox(
                          height:50,
                          child: CheckboxListTile(
                            contentPadding: const EdgeInsets.all(0),
                            activeColor: const Color(0xFF5881EB),
                            checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            title: StringText_letterspacing(friend['name'], 12, FontWeight.w400, Colors.black, -0.5),
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
                        ),
                        line(),
                      ],
                    );
                  }).toList(),
                ),
              ), // 초대 가능 리스트
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: total == 0 ? null : () {
                      showToast('친구 초대가 완료되었습니다.');
                      total = 0;
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      shadowColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
                      backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFF0F1F5)),
                      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                      ),
                    ),
                    child: StringText_letterspacing('초대하기', 14, FontWeight.w700, const Color(0xFFA8A8B2), -0.5),
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
  return const Divider(
    color: Color(0xffEBEBEB),
    thickness: 1.0,
    height: 1,
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