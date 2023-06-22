import 'package:flutter/material.dart';
import 'package:front/screen/alarm/alarm.dart';
import 'package:front/screen/chat/chatpage.dart';

import '../../model/bottomBar.dart';
import '../mainMap/mainPageMap.dart';
import '../profile/profileMain.dart';

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
    String appbarText = '참여한 대화방';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        toolbarHeight: 50,
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color : Color(0xFFE3E3E3), // 테두리 선의 색상
            height: 1.0, // 테두리 선의 높이
          ),
        ),
        leading: IconButton(
            iconSize: 14.93,
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => profileMain()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF2F2F2F),
            )),


        title: Text(appbarText,
          style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.w700,fontFamily: 'Pretendard'),
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
      bottomNavigationBar: const BottomAppBar(child: BottomBar()),
    );
    ;
  }
}
