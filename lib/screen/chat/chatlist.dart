import 'package:flutter/material.dart';
import 'package:front/data/designconst/constants.dart';
import 'package:front/model/UI/widget/button/svgButton.dart';
import 'package:front/model/UI/widget/customAppBar.dart';
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:CustomAppBar(
        title: '참여한 대화방',
        automaticallyImplyLeading: false,
        actionWidget: SvgButton(imagePath: 'assets/icons/detail/alarm.svg',
            onPressed: ()
            {Navigator.push(context,
                MaterialPageRoute(builder: (context) => alarm()));}

        ),


      ),



      // actionWidget: actions[
      // IconButton(
      //     onPressed: () {
      //       Navigator.push(
      //           context, MaterialPageRoute(builder: (context) => alarm()));
      //     },
      //     icon: Icon(
      //       Icons.notifications_none,
      //       color: Colors.black,
      //     ))
      // ],





      // actions: [
      //   IconButton(
      //       onPressed: () {
      //         Navigator.push(
      //             context, MaterialPageRoute(builder: (context) => alarm()));
      //       },
      //       icon: Icon(
      //         Icons.notifications_none,
      //         color: Colors.black,
      //       ))
      // ],profileTestImage[index]
      body: ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          final chatItem = chatList[index];
          final message =
              widget.lastMessages != null ? widget.lastMessages!.content : '';
          return ListTile(
            leading: Container(
              padding: EdgeInsets.zero,
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image:AssetImage(profileTestImage[index]), fit: BoxFit.cover),
              ),
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
