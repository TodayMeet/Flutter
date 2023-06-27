// 댓글 페이지

// 최종 수정: 2023.6.8
// 작업자: 정해수

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/data/Comment.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/model/mainList/CommentContainer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data/dummy_meetList.dart';
import '../../model/mainList/Invitation.dart';

class Comments extends ConsumerStatefulWidget {
  const Comments({Key? key,
    required this.Data,
    required this.meetNo
  }) : super(key: key);

  final dynamic Data;
  final int meetNo;

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends ConsumerState<Comments> {
  List<Comment> comments = []; //서버에서 받아온 리스트
  List<Comment> sortedComments = []; //정렬된 리스트
  String Content = '';

  @override
  void initState() {
    super.initState();
    upLoadData(widget.Data);
  }
  
  void upLoadData(dynamic commentData) {
    commentData.forEach((element) => comments.add(Comment.fromJson(element)));
  }

  void updateData() async {
    try {
      final url = Uri.parse('http://todaymeet.shop:8080/meet/comment/${widget.meetNo}');

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var commentData = jsonDecode(utf8.decode(response.bodyBytes));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Comments(Data: commentData, meetNo: widget.meetNo,),
          ),
        );
      } else {
        print('Data download failed!');
        showToast('Data download failed!');
      }
    } catch (e) {
      print('There was a problem with the internet connection.');
      showToast('There was a problem with the internet connection.');
    }
  } // 댓글 화면 새로고침

  Future<void> addComment() async {
    try {
      final url = Uri.parse('http://todaymeet.shop:8080/meetcommentadd');
      var postBody =
      {
        "meetNo": widget.meetNo,
        "user": {
          "userNo": tempUser['userNo']
        },
        "parentNo":-1,
        "content": Content
      };

      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(postBody),
      );
      if (response.statusCode == 200) {
        print(response.body);
        updateData();
      } else {
        print('Data update failed! : ${response.statusCode}');
        showToast('Data update failed!');
      }
    } catch (e) {
      print('There was a problem with the internet connection.');
      showToast('There was a problem with the internet connection.');
    }
  }

  List<Comment> sortComments(List<Comment> comments) {
    List<Comment> temp = [];

    for(int i = 0; i < comments.length; i++) {
      if(comments[i].parentNo < 0){ //대댓글이 아니면
        temp.add(comments[i]);
        for(int j = i + 1; j < comments.length; j++) {
          if(comments[i].meetCommentNo == comments[j].parentNo) {
            temp.add(comments[j]);
          }
        }
      }
    }
    return temp;
  } //대댓글 정렬

  @override
  Widget build(BuildContext context) {
    sortedComments = sortComments(comments);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: const Text("댓글",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            icon: SvgPicture.asset(
              "assets/icons/back_icon.svg"
            )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          children: comments.asMap().entries.map((c) {
              return Column(
                children: [
                  CommentContainer(context, c.value, c.key),
                ],
              );
            }).toList(),
        ),
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 8,
              offset: Offset(0, -4),
              blurStyle: BlurStyle.outer
            )
          ],
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 46,
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      Content = text;
                      print(Content);
                    });
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    filled: true,
                    fillColor: Color(0xffF5F6FA),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        color: Color(0xffF5F6FA),
                      ),
                    ),
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Color(0xFFC8C8CB),
                      letterSpacing: -0.5,
                    ),
                    hintText: '댓글을 작성해주세요.',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4,),
            SizedBox(
              width: 56,
              height: 46,
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                    )
                  ),
                  onPressed: () {
                    addComment();
                  },
                  child: StringText_letterspacing('전송', 13, FontWeight.w700, Colors.white, -0.5)
              ),
            ),
          ],
        ),
      )
    );
  }
}