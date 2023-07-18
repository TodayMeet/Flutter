import 'package:flutter/material.dart';
import 'package:front/data/userNo.dart';
import 'package:front/screen/alarm/alarm.dart';
import 'package:front/screen/mainList/Loading_to_ListDetail.dart';
import 'package:http/http.dart';
import 'dart:convert';

import '../../model/showtoast.dart';
import '../../screen/profile/userProfile.dart';
import '../../screen/mainList/Comments.dart';

Widget alarmMessage(int index, String value) {
  switch (index) {
    // 다른 유저가 나를 팔로우 했을 때
    case 1:
      return Text.rich(
        TextSpan(
          text: "$value님",
          style: const TextStyle(
            color: Color(0xFF1F2024),
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: -0.5,
          ),
          children: const [
            TextSpan(
                text: "이 나를 팔로우 합니다.",
                style: TextStyle(fontWeight: FontWeight.w400))
          ],
        ),
      );

    // 내가 팔로우한 유저가 건수를 등록했을 때
    case 2:
      return Text.rich(
        TextSpan(
          text: "$value님",
          style: const TextStyle(
            color: Color(0xFF1F2024),
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: -0.5,
          ),
          children: const [
            TextSpan(
                text: "이 새로운 건수를 등록하였습니다.",
                style: TextStyle(fontWeight: FontWeight.w400))
          ],
        ),
      );

    // 설정된 위치에 관심 카테고리에 새로운 건수가 등록된 경우
    case 3:
      return Text.rich(
        TextSpan(
          text: "새로운 건수가 ",
          style: const TextStyle(
            color: Color(0xFF1F2024),
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: -0.5,
          ),
          children: [
            TextSpan(
                text: "$value건",
                style: const TextStyle(fontWeight: FontWeight.w700)),
            const TextSpan(
              text: " 등록하였습니다.",
            ),
          ],
        ),
      );

    // 건수 참가 승인이 된 경우
    case 4:
      return Text.rich(
        TextSpan(
          text: value,
          style: const TextStyle(
            color: Color(0xFF1F2024),
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: -0.5,
          ),
          children: const [
            TextSpan(
                text: " 참가가 승인되었습니다.",
                style: TextStyle(fontWeight: FontWeight.w400))
          ],
        ),
      );

    // 건수 참가 거절이 된 경우
    case 5:
      return Text.rich(
        TextSpan(
          text: value,
          style: const TextStyle(
            color: Color(0xFF1F2024),
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: -0.5,
          ),
          children: const [
            TextSpan(
                text: " 참가가 거절되었습니다.",
                style: TextStyle(fontWeight: FontWeight.w400))
          ],
        ),
      );

    // 내가 등록한 또는 참여한 건수에 댓글이 달린 경우
    case 6:
      return Text.rich(
        TextSpan(
          text: value,
          style: const TextStyle(
            color: Color(0xFF1F2024),
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: -0.5,
          ),
          children: const [
            TextSpan(
                text: "에 새로운 댓글이 달렸습니다.",
                style: TextStyle(fontWeight: FontWeight.w400))
          ],
        ),
      );

    // 유저가 참여 요청을 했을 때(참여방식이 '확인 후 승인')
    case 7:
      return Text.rich(
        TextSpan(
          text: value,
          style: const TextStyle(
            color: Color(0xFF1F2024),
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: -0.5,
          ),
          children: const [
            TextSpan(
                text: " 참가 요청을 했습니다.",
                style: TextStyle(fontWeight: FontWeight.w400))
          ],
        ),
      );

    default:
      return const Text(
        "알림 오류",
        style: TextStyle(
          color: Color(0xFF1F2024),
          fontWeight: FontWeight.w700,
          fontSize: 14,
          letterSpacing: -0.5,
        ),
      );
  }
}

/*Widget textMessage(bool bold, String message){
  if(bold == true){
    return Text(
      overflow: TextOverflow.visible,
      message,
      style: const TextStyle(
        color: Color(0xFF1F2024),
        fontWeight: FontWeight.w700,
        fontSize: 14,
        letterSpacing: -0.5,
      ),
    );
  }else{
    return Text(
      message,
      style: const TextStyle(
        color: Color(0xFF1F2024),
        fontWeight: FontWeight.w400,
        fontSize: 14,
        letterSpacing: -0.5,
      ),
    );
  }
}*/

void pageTransition(BuildContext context, int index, int? userNumber,
    int? meetNumber, String name, bool processed) {
  // 참가 승인
  Future<void> approvalPositive () async {
    try{
      final url = Uri.parse("http://todaymeet.shop:8080/approval/ok");
      var postBody = {
        "meet":{
          "meetNo":meetNumber
        },
        "user":{
          "userNo":userNumber
        }
      };

      Response response = await post(
          url,
          headers: {'Content-Type' : 'application/json'},
          body: json.encode(postBody),
      );

      if (response.statusCode == 200){
        print(response);
      }else{
        print("서버 통신 오류");
        showToast("서버 통신 오류");
      }
    }catch(e){
      print("참가 승인 오류");
      showToast("참가 승인 오류");
    }
  }

  // 참가 승인
  Future<void> approvalNegative () async {
    try{
      final url = Uri.parse("http://todaymeet.shop:8080/approval/not");
      var postBody = {
        "meet":{
          "meetNo":meetNumber
        },
        "user":{
          "userNo":userNumber
        }
      };

      Response response = await post(
        url,
        headers: {'Content-Type' : 'application/json'},
        body: json.encode(postBody),
      );

      if (response.statusCode == 200){
        print(response);
      }else{
        print("서버 통신 오류");
        showToast("서버 통신 오류");
      }
    }catch(e){
      print("참가 승인 오류");
      showToast("참가 승인 오류");
    }
  }

  switch (index) {
    // 다른 유저가 나를 팔로우 했을 때
    case 1:
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => userProfile(userNo: 1,)));
      break;

    // 내가 팔로우한 유저가 건수를 등록했을 때
    case 2:
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Loading_to_ListDetail(
                  meetNo: meetNumber!, userNo: UserNo.myuserNo)));
      break;

    // 설정된 위치에 관심 카테고리에 새로운 건수가 등록된 경우
    case 3:
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => userProfile(userNo: 1,)));
      break;

    // 건수 참가 승인이 된 경우
    case 4:
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Loading_to_ListDetail(
                  meetNo: meetNumber!, userNo: UserNo.myuserNo)));
      break;

    // 건수 참가 거절이 된 경우
    case 5:
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Loading_to_ListDetail(
                  meetNo: meetNumber!, userNo: UserNo.myuserNo)));
      break;

    // 내가 등록한 또는 참여한 건수에 댓글이 달린 경우
    case 6:
      Navigator.push(
          context,
          MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => Comments(meetNo: meetNumber!)));
      break;

    // 유저가 참여 요청을 했을 때(참여방식이 '확인 후 승인')
    case 7:
      if(processed == true){
        showToast("참가 승인 여부를 결정한 알림입니다.");
      }else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: ((context) {
              return Container(
                width: 320,
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 30,
                    offset: Offset(0, 8),
                  ),
                ]),
                child: AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 36.0),
                          child: Text(
                            "$name님이 창가 요청을 했습니다\n"
                                "참가를 승인 하시겠습니까",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              letterSpacing: -0.5,
                              height: 1.4,
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Color(0xFFDADADA), width: 1))),
                          child: Row(
                            children: [
                              // 승인 버튼
                              SizedBox(
                                width: 160,
                                height: 56,
                                child: TextButton(
                                    style: const ButtonStyle(
                                      backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Color(0xFF4874EA)),
                                      shape: MaterialStatePropertyAll<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                  Radius.circular(16)))),
                                    ),
                                    onPressed: () async {
                                      // 참가 승인 요청
                                      await approvalPositive();
                                      alarmrefreshController.requestRefresh();
                                      Navigator.pop(context);
                                    },
                                    child: const Text("승인",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ))),
                              ),

                              // 거절 버튼
                              SizedBox(
                                width: 160,
                                height: 56,
                                child: TextButton(
                                    style: const ButtonStyle(
                                      backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.white),
                                      shape: MaterialStatePropertyAll<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                  Radius.circular(16)))),
                                    ),
                                    onPressed: () async {
                                      // 참가 승인 거부
                                      await approvalNegative();
                                      alarmrefreshController.requestRefresh();
                                      Navigator.pop(context);
                                    },
                                    child: const Text("거절",
                                        style: TextStyle(
                                          color: Color(0xFF4874EA),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ))),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              );
            }));
      }
      break;

    default:
      return;
  }
}
