import 'package:flutter/material.dart';
import 'package:front/data/Comment.dart';
import 'package:front/model/TextPrint.dart';
import 'package:intl/intl.dart';

Widget CommentContainer(BuildContext context, Comment comment, int key) {
  if(comment.parentNo < 0) { //대댓이 아니면
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: Column(
        children: [
          line(key),
          commentBox(comment),
        ],
      ),
    );
  } else {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/Comments/Comment_reply.png', width: 24, height: 24),
        SizedBox(
          width: MediaQuery.of(context).size.width - 75,
          child: commentBox(comment),
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
              StringText(comment.username, 12, 'PretendardRegular', Colors.black),
            ],
          ), //사용자 아이콘
          InkWell(
              onTap: () {},
              child: Image.asset('assets/images/Comments/Comment_report.png', width: 24, height: 24)
          ),
        ],
      ),
      const SizedBox(height: 10,),
      Container(child: StringText(comment.content, 12, 'PretendardRegular', Colors.black)),
      const SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IntText(DateFormat('yyyy.MM.dd hh:mm').format(comment.createDate), 12, 'PretendardRegular', const Color(0xff9F9F9F)),
          InkWell(
            onTap: () {},
            child: StringText('답글쓰기', 12, 'PretendardBold', Colors.black),
          ),
        ],
      ),
      const SizedBox(height: 10,),
    ],
  );
}

Widget line(int key) {
  if(key != 0) {
    return const Center(
      child: SizedBox(
        child: Divider(
          color: Color(0xffEBEBEB),
          thickness: 1.0,
        ),
      ),
    );
  } else {
    return const SizedBox();
  }
}