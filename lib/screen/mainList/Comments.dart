// 댓글 페이지

// 최종 수정: 2023.7.3
// 작업자: 정해수 -> 김혁

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:front/data/Comment.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/model/mainList/CommentContainer.dart';
import '../../data/userNo.dart';
import '../../model/showtoast.dart';

StateProvider replyProvider = StateProvider<int>((ref)=>-1);
GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();
late FocusNode textFieldFocusNode;

class Comments extends ConsumerStatefulWidget {
  const Comments({Key? key, required this.meetNo}) : super(key: key);

  final int meetNo;

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends ConsumerState<Comments> {
  RefreshController refreshController = RefreshController(initialRefresh: true);
  late TextEditingController textEditingController = TextEditingController();

  List<Comment> comments = []; //서버에서 받아온 리스트
  List<Comment> sortedComments = []; //정렬된 리스트
  String Content = '';

  @override
  void initState() {
    super.initState();
    textFieldFocusNode = FocusNode();
  }

  @override
  void dispose() {
    textFieldFocusNode.dispose();
    super.dispose();
  }

  //댓글 데이터 불러오기
  Future<int> getCommentData() async {
    try {
      final url =
          Uri.parse('http://todaymeet.shop:8080/meet/comment/${widget.meetNo}');

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var commentData = jsonDecode(utf8.decode(response.bodyBytes));
        comments.clear();
        commentData
            .forEach((element) => comments.add(Comment.fromJson(element)));
        return 1;
      } else {
        print('Data download failed!');
        showToast('Data download failed!');
        return 0;
      }
    } catch (e) {
      print('There was a problem with the internet connection.');
      showToast('There was a problem with the internet connection.');
      return 0;
    }
  }

  // 댓글 추가
  Future<void> addComment(int commentNo) async {
    try {
      final url = Uri.parse('http://todaymeet.shop:8080/meetcommentadd');
      var postBody = {
        "meetNo": widget.meetNo,
        "user": {"userNo": UserNo.myuserNo},
        "parentNo": commentNo,
        "content": Content
      };
      print(postBody);

      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(postBody),
      );
      if (response.statusCode == 200) {
        print(response.body);
        await refreshController.requestRefresh();
      } else {
        print('Data update failed! : ${response.statusCode}');
        showToast('Data update failed!');
      }
    } catch (e) {
      print('There was a problem with the internet connection.');
      showToast('There was a problem with the internet connection.');
    }
  }

  //대댓글 정렬
  List<Comment> sortComments(List<Comment> comments) {
    List<Comment> temp = [];

    for (int i = 0; i < comments.length; i++) {
      if (comments[i].parentNo < 0) {
        //대댓글이 아니면
        temp.add(comments[i]);
        for (int j = i + 1; j < comments.length; j++) {
          if (comments[i].meetCommentNo == comments[j].parentNo) {
            temp.add(comments[j]);
          }
        }
      }
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    sortedComments = sortComments(comments);

    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 0,
            title: const Text(
              "댓글",
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black),
            ),
            backgroundColor: Colors.white,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.black,
                icon: SvgPicture.asset("assets/icons/back_icon.svg")),
          ),
          body: Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 0),
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  onRefresh: () async {
                    int complete = await getCommentData();
                    if (complete == 1) {
                      showToast("새로고침 완료");
                    } else {
                      showToast("새로고침 실패");
                    }
                    setState(() {});
                    refreshController.refreshCompleted();
                  },
                  controller: refreshController,
                  child: ListView(
                    children: comments
                        .asMap()
                        .entries
                        .map((c) {
                      return Column(
                        children: [
                          CommentContainer(context, c.value, c.key, ref, false),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
          bottomSheet: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 8,
                    offset: Offset(0, -4),
                    blurStyle: BlurStyle.outer)
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
                      focusNode: textFieldFocusNode,
                      controller: textEditingController,
                      onChanged: (text) {
                        setState(() {
                          Content = text;
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
                const SizedBox(
                  width: 4,
                ),
                SizedBox(
                  width: 56,
                  height: 46,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                          Color(0xFF4874EA)
                        )
                      ),
                      onPressed: () {
                        if(Content != "") {
                          print(Content);
                          addComment(ref.watch(replyProvider.notifier).state);
                          setState(() {
                            textEditingController.text = "";
                            FocusScope.of(context).unfocus();
                          });
                        }
                      },
                      child: StringText_letterspacing(
                          '전송', 13, FontWeight.w700, Colors.white, -0.5)),
                ),
              ],
            ),
          )),
    );
  }
}