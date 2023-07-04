// 댓글 container

// 최종 수정: 2023.6.27
// 작업자: 정해수 -> 김혁

// 추가 작업해야 할 사항
// 채팅방 입장 연결

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:front/data/Comment.dart';
import 'package:front/model/TextPrint.dart';

Widget CommentContainer(BuildContext context, Comment comment, int key) {
  if(comment.parentNo < 0) { //대댓이 아니면
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: Column(
        children: [
          line(key),
          const SizedBox(height: 12),
          commentBox(comment, context),
        ],
      ),
    );
  } else {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
                'assets/icons/detail/comment_reply.svg'
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: commentBox(comment, context),
            ),
          ],
        ),
      ],
    );
  }
}

Widget commentBox(Comment comment, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //사용자 아이콘
              ClipOval(
                child: Image.network(
                  comment.userProfileImage,
                  fit: BoxFit.fill,
                  width: 26,
                  height: 26,
                ),
              ),
              const SizedBox(width: 10,),

              StringText(comment.username, 12, FontWeight.w400, Colors.black),
            ],
          ), //사용자 아이콘
          InkWell(
              onTap: (){
                reporting(context);
              },
              child: SvgPicture.asset(
                "assets/icons/detail/report.svg"
              )
          ),  //신고하기 아이콘
        ],
     ),
      const SizedBox(height: 10,),
      Container(child: StringText_letterspacing(comment.content, 12, FontWeight.w400, Colors.black, -0.5)),

      const SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StringText_letterspacing(DateFormat('yyyy.MM.dd hh:mm').format(comment.createDate), 12, FontWeight.w400, const Color(0xff9F9F9F), -0.5),
          InkWell(
            onTap: () {},
            child: StringText_letterspacing('답글쓰기', 12, FontWeight.w400, Colors.black, -0.5),
          ),
        ],
      ),
      const SizedBox(height: 12),
    ],
  );
}

void reporting(BuildContext context){
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    context: context,
    builder: (BuildContext context){
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
                      letterSpacing: 0.09
                  )
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      "assets/icons/close.svg",
                      width: 20,
                      height: 20,
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),

            // 폭력성 버튼
            reportButton("폭력성", context),

            // 선정성 버튼
            reportButton("선정성", context),

            // 광고성 버튼
            reportButton("광고성", context),

            // 사기성 버튼
            reportButton("사기성", context),
          ],
        ),
      );
    }
  );
}

Widget reportButton(String str, BuildContext context){
  return SizedBox(
    height: 50,
    child: TextButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
        padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.only(top: 15, bottom: 13),
        ),
      ),
      onPressed: (){
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: ((context){
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.white,
              shadowColor: const Color(0x1A000000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: SizedBox(
                width: 320,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 36),
                      child: Text("신고하시겠습니까?",
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
                            color: Color(0xFFDADADA),
                            width: 1
                          )
                        )
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 160,
                            height: 56,
                            child: TextButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(
                                      Color(0xFF4874EA)
                                  ),
                                  shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(16)
                                      )
                                    )
                                  ),
                                ),
                                onPressed: (){
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text("네",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    )
                                )
                            ),
                          ),

                          // 아니오 버튼
                          SizedBox(
                            width: 160,
                            height: 56,
                            child: TextButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(
                                        Colors.white
                                    ),
                                  shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(16)
                                          )
                                      )
                                  ),
                                ),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: const Text("아니오",
                                    style: TextStyle(
                                      color: Color(0xFF4874EA),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    )
                                )
                            ),
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
      },
      child: Center(
        child: Text(str,
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

Widget line(int key) {
  if(key != 0) {
    return const Divider(
      color: Color(0xffEBEBEB),
      thickness: 1.0,
      height: 1,
    );
  } else {
    return const SizedBox();
  }
}