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
          const SizedBox(height: 16),
          commentBox(comment),
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
              child: commentBox(comment),
            ),
          ],
        ),
      ],
    );
  }
}

Widget commentBox(Comment comment) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.account_circle), //사용자 아이콘
              const SizedBox(width: 10,),
              StringText(comment.username, 12, FontWeight.w400, Colors.black),
            ],
          ), //사용자 아이콘
          InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                "assets/icons/detail/report.svg"
              )
          ),
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