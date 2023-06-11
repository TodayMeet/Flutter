import 'package:flutter/material.dart';
import 'package:front/screen/alarm/alarm.dart';
import 'package:front/screen/chat/chatpage.dart';

import '../mainMap/mainPageMap.dart';

class chatlist extends StatefulWidget {
  const chatlist({Key? key, this.lastMessages}) : super(key: key);
  final ChatMessage? lastMessages;

  @override
  State<chatlist> createState() => _chatlistState();
}

class _chatlistState extends State<chatlist> {
  List<String> chatList = [
    "스터디 모임 모집합니다.",
    "오늘 같이 놀 사람!",
  ];
  List<String> lastMessages = [
    "안녕하세요",
    "오늘 같이 한 잔 하실분 구해요~!",
  ];
  List<String> profileTestImage = [
    "assets/images/List_Image/List_image_sample1.png",
    "assets/images/List_Image/List_image_sample2.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainPageMap()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          '참여한 대화방',
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => alarm()));
              },
              icon: Icon(
                Icons.notifications_none,
                color: Colors.black,
              ))
        ],
      ),
      body: ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          final chatItem = chatList[index];
          final message =
              widget.lastMessages != null ? widget.lastMessages!.content : '';
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
                child: ClipOval(child: Image.asset(profileTestImage[index],fit: BoxFit.cover,))
                // Image.asset('assets/images/avatar.png'),
                ),
            title: Text(chatItem),
            subtitle: Text(lastMessages[index]), //이미지 넣어야함
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatPage()));
            },
          );
        },
      ),
    );
    ;
  }
}
