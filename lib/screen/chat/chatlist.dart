import 'package:flutter/material.dart';
import 'package:front/screen/alarm/alarm.dart';
import 'package:front/screen/chat/chatpage.dart';


import '../mainMap/mainPageMap.dart';

class chatlist extends StatefulWidget {
  const chatlist({Key? key,this.lastMessage}) : super(key: key);
  final ChatMessage? lastMessage;



  @override
  State<chatlist> createState() => _chatlistState();
}

class _chatlistState extends State<chatlist> {
  List<String> chatList = [
    "용산동에서 치맥 하실분~~!!",
    "산격동에서 축구한판 하실분~~!!",
  ];
  List<String> lastMessage = [
    "안녕하세요",
    "반갑습니다",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => MainPageMap()));
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text('참여한 대화방',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.black),),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => alarm()));              },
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
          final message = widget.lastMessage != null ? widget.lastMessage!.content : '';
          return ListTile(
            leading: CircleAvatar(
              child: Text(chatItem[0]),
            ),
            title: Text(chatItem),
            subtitle: Text(message),//이미지 넣어야함
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => ChatPage()));
            },
          );
        },
      ),
    );;
  }
}
