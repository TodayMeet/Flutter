// 댓글 페이지

// 최종 수정: 2023.6.8
// 작업자: 정해수

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/data/Comment.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/model/mainList/CommentContainer.dart';

import '../../data/meetList_Provider.dart';

class Comments extends ConsumerStatefulWidget {
  const Comments({Key? key,
    required this.Data
  }) : super(key: key);

  final dynamic Data;

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends ConsumerState<Comments> {
  List<Comment> comments = []; //서버에서 받아온 리스트
  List<Comment> sortedComments = []; //정렬된 리스트

  @override
  void initState() {
    super.initState();
    upLoadData(widget.Data);
  }
  
  void upLoadData(dynamic commentData) {
    commentData.forEach((element) => comments.add(Comment.fromJson(element)));
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
        title: const Text("댓글",
          style: TextStyle(
              fontFamily: 'PretendardBold',
              color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
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
      bottomSheet: Material(
          elevation: 30,
          child: SizedBox(
            width: double.maxFinite,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffF5F6FA),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                            color: Color(0xffF5F6FA),
                          ),
                        ),
                        hintText: '댓글을 작성해주세요',
                      ),
                    ),
                  ),
                  const SizedBox(width: 4,),
                  ButtonTheme(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                      child: ElevatedButton(
                          onPressed: () {},
                          child: StringText('전송', 13, 'PretendardBold', Colors.white)
                      ),
                  ),
                ],
              ),
            ),
          ),
    )
    );
  }
}