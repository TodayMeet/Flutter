// 댓글 container

// 최종 수정: 2023.7.19
// 작업자: 정해수 -> 김혁

// 추가 작업 해야 할 사항
// 댓글 수정, 삭제
// 게시판 답글쓰기 버튼 클릭 시 입력창 포커스 및 스낵바 출력 필요

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/screen/mainList/Comments.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import '../../data/userNo.dart';
import 'package:front/data/Comment.dart';
import 'package:front/model/TextPrint.dart';

// 댓글, 대댓글 구분하는 위젯
Widget CommentContainer(
    BuildContext context, Comment comment, int key, WidgetRef ref, bool commentSummary) {
  if (comment.parentNo < 0) {
    //대댓이 아닐 경우
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: Column(
        children: [
          line(key),
          const SizedBox(height: 12),
          commentBox(comment, context, ref, commentSummary),
        ],
      ),
    );
  } else {
    // 대댓글일 경우
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/icons/detail/comment_reply.svg'),

            const SizedBox(width: 5),
            Expanded(
              child: commentBox(comment, context, ref, commentSummary),
            ),
          ],
        ),
      ],
    );
  }
}

Widget commentBox(Comment comment, BuildContext context, WidgetRef ref, bool commentSummary) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 사용자 데이터
          Row(
            children: [
              // 사용자 아이콘
              ClipOval(
                child: Image.network(
                  comment.userProfileImage,
                  fit: BoxFit.fill,
                  width: 26,
                  height: 26,
                ),
              ),
              const SizedBox(width: 10),

              // 사용자 이름
              StringText(comment.username, 12, FontWeight.w400, Colors.black),
            ],
          ),

          // 신고하기 아이콘
          InkWell(
              onTap: () {
                reporting(context, comment.meetCommentNo);
              },
              child: SvgPicture.asset(
                  "assets/icons/detail/report.svg"
              )
          ),
        ],
      ),

      const SizedBox(height: 10),
      // 댓글 내용
      Container(
          child: StringText_letterspacing(
              comment.content, 12, FontWeight.w400, Colors.black, -0.5)),

      const SizedBox(height: 10),
      // 댓글 작성 시간 및 답글 쓰기 or 수정, 삭제
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StringText_letterspacing(
              DateFormat('yyyy.MM.dd hh:mm').format(comment.createDate),
              12,
              FontWeight.w400,
              const Color(0xff9F9F9F),
              -0.5),

          // 댓글 작성자가 본인인지 확인
          UserNo.myuserNo == comment.userNo
              ? IntrinsicHeight(
                child: Row(
                    children: [
                      // 수정 버튼
                      InkWell(
                        onTap: () {},
                        child: const Text("수정",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                letterSpacing: -0.5)),
                      ),

                      const SizedBox(width: 10),
                      const VerticalDivider(
                        color: Color(0xFFDBDBDB),
                        width: 1,
                        thickness: 1,
                      ),
                      const SizedBox(width: 10),

                      // 삭제 버튼
                      InkWell(
                        onTap: () {},
                        child: const Text("삭제",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                letterSpacing: -0.5)),
                      ),
                    ],
                  ),
              )
              // 답글 쓰기
              : InkWell(
                  onTap: () {
                    if (commentSummary == true) {           // 게시판 댓글 - textfield 활성화 및 snackbar 출력 필요
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Comments(
                            meetNo: comment.meetNo,
                          )
                        )
                      );

                      // 대댓글 번호 변경
                      ref.read(replyProvider.notifier).state = comment.meetCommentNo;
                    }
                    else {                                  // 댓글 화면
                      // 대댓글 번호 변경
                      ref.read(replyProvider.notifier).state = comment.meetCommentNo;

                      // textfield 활성화
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(textFieldFocusNode);

                      // SnackBar 출력
                      scaffoldKey.currentState?.hideCurrentSnackBar();
                      showsnackbar(context, comment, ref);
                    }
                  },
                  child: StringText_letterspacing(
                      '답글쓰기', 12, FontWeight.w400, Colors.black, -0.5),
                ),
        ],
      ),

      const SizedBox(height: 12),
    ],
  );
}

// 답글 쓰기 누를 시 보이는 스낵바 출력
void showsnackbar(BuildContext context, Comment comment, WidgetRef ref){
  scaffoldKey.currentState?.showSnackBar(SnackBar(
    content: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF313033),
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.3),
                blurStyle: BlurStyle.outer,
                blurRadius: 3,
                offset: Offset(0, 1)),
            BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.15),
                blurStyle: BlurStyle.outer,
                blurRadius: 8,
                spreadRadius: 3,
                offset: Offset(0, 4))
          ],
        ),
        padding: const EdgeInsets.only(left: 16),
        height: 48,
        width: 344,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${comment.username} 님께 댓글을 남기는 중',
                style: const TextStyle(
                    color: Color(0xFFF4EFF4),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: -0.5)),
            IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .hideCurrentSnackBar();
                  ref.read(replyProvider.notifier).state = -1;
                },
                icon: SvgPicture.asset(
                    "assets/icons/detail/snackbar_close.svg"))
          ],
        )),
    duration: const Duration(seconds: 3),
    padding: const EdgeInsets.all(0),
    backgroundColor: const Color(0xFF313033),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4)),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.fromLTRB(16, 0, 16, 91),

  ));
}

// 신고하기 기능
void reporting(BuildContext context, int meetcommentNo) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Column(
            children: [
              // 신고하기 제목 창
              AppBar(
                toolbarHeight: 50,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                centerTitle: true,
                title: const Text('신고하기',
                    style: TextStyle(
                        color: Color(0xFF1F2024),
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: 0.09)),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/close.svg",
                        width: 20,
                        height: 20,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),

              // 폭력성 버튼
              reportButton("폭력성", context, meetcommentNo, 1),

              // 선정성 버튼
              reportButton("선정성", context, meetcommentNo, 2),

              // 광고성 버튼
              reportButton("광고성", context, meetcommentNo, 3),

              // 사기성 버튼
              reportButton("사기성", context, meetcommentNo, 4),
            ],
          ),
        );
      });
}

// 신고하기 버튼
Widget reportButton(String str, BuildContext context, int meetCommentNo, int type) {

  // 서버로 신고 push
  Future<void> pushReport() async {
    try {
      final url = Uri.parse("http://todaymeet.shop:8080/reports");
      var postbody = {
        "userNo":UserNo.myuserNo,
        "meetcommentNo":meetCommentNo,
        "type":type
      };

      Response response = await post(
        url,
        headers: {"Content-Type":"application/json"},
        body: json.encode(postbody)
      );

      if(response.statusCode == 200){
        debugPrint('------------------신고 완료------------------');
      }else{
        debugPrint('------------------신고 서버 실패------------------');
      }
    } catch(e) {
      debugPrint('------------------신고 실패------------------');
    }
  }

  return SizedBox(
    height: 50,
    child: TextButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
        padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.only(top: 15, bottom: 13),
        ),
      ),
      onPressed: () {
        // 버튼 클릭 시 보이는 dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: ((context) {
            return Container(
              width: 320,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 30,
                    offset: Offset(0, 8),
                  )
                ]
              ),
              child: AlertDialog(
                contentPadding: EdgeInsets.zero,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 36),
                      child: Text(
                        "신고하시겠습니까?",
                        style: TextStyle(
                          color: Color(0xFF1F2024),
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          letterSpacing: 0.09,
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
                          // 네 버튼
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
                                  pushReport();
                                  Navigator.pop(context);
                                },
                                child: const Text("네",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ))),
                          ),

                          // 아니오 버튼
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
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("아니오",
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
                ),
              ),
            );
          }),
        );
        Navigator.pop(context);
      },
      child: Center(
        child: Text(
          str,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            letterSpacing: -0.5,
          ),
        ),
      ),
    ),
  );
}

// 구분선
Widget line(int key) {
  if (key != 0) {
    return const Divider(
      color: Color(0xffEBEBEB),
      thickness: 1.0,
      height: 1,
    );
  } else {
    return const SizedBox();
  }
}
