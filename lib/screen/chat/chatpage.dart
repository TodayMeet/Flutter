import 'package:bubble/bubble.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/data/designconst/constants.dart';
import 'package:front/model/UI/widget/button/svgButton.dart';
import 'package:front/model/UI/widget/button/xeiconButton.dart';
import 'package:front/model/UI/widget/customAppBar.dart';

import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as badges;

//sddddddd
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class ChatMessage extends StatelessWidget {
  final String content;
  final bool isSentByMe;
  final String time;
  const ChatMessage({
    required this.content,
    required this.isSentByMe,
    required this.time,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment:
        isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isSentByMe==true)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(formatTime(), style: TextStyle(fontSize: 10,),),
            ),
          Bubble(
            margin: BubbleEdges.symmetric(vertical: 10.0),
            // padding: EdgeInsets.all(10),
            elevation: 0,
            stick: true,
            nip: isSentByMe ? BubbleNip.rightTop : BubbleNip.leftTop,
            color: isSentByMe ? Colors.yellow : Colors.white,
            child: Text(content, style: TextStyle(color: Colors.black, fontSize: 15,),softWrap: true, overflow: TextOverflow.visible,),),

          if (isSentByMe==false)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(formatTime(), style: TextStyle(fontSize: 10,),),
            ),
        ],
      ),
    );
  }

  String formatTime() {
    final now = DateTime.now();
    final formattedTime = DateFormat('aa hh:mm').format(now);
    final timeSuffix = now.hour >= 12 ? '오후' : '오전';
    final replacedTime =
    formattedTime.replaceAll('AM', '오전').replaceAll('PM', '오후');
    return replacedTime;
  }//시간 형식 지정
}

class _ChatPageState extends State<ChatPage> {
  final String appbarText = '오늘 같이 놀 사람~!';

  final List<ChatMessage> messages = <ChatMessage>[];
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Map>users=[
    {'image' : 'assets/images/User_Picture/User_pic_sample1.png','name' : '개굴개굴'},
    {'image' : 'assets/images/User_Picture/User_pic_sample1.png','name' : '꺄르르'},
    {'image' : 'assets/images/User_Picture/User_pic_sample1.png','name' : '보라돌이'},
    {'image' : 'assets/images/User_Picture/User_pic_sample1.png','name' : '오늘만산다'},
    {'image' : 'assets/images/User_Picture/User_pic_sample1.png','name' : '심심해'},
    {'image' : 'assets/images/User_Picture/User_pic_sample1.png','name' : '건수없나'},
    {'image' : 'assets/images/User_Picture/User_pic_sample1.png','name' : '요기어때'},
    {'image' : 'assets/images/User_Picture/User_pic_sample1.png','name' : '곰돌이푸'},
  ];
  bool isFollow = false;
  void _sendMessage() {
    if (textEditingController.text.isNotEmpty) {
      setState(() {
        ChatMessage message = ChatMessage(
          content: textEditingController.text,
          isSentByMe: true,
          time: DateTime.now().toString(),
        );
        messages.add(message);
        textEditingController.clear();
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 1),
            curve: Curves.easeInOut,
          );
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    messages.add(
      ChatMessage(
        content: '안녕하세요!',
        isSentByMe: false,
        time: DateTime.now().toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ChatMessage? lastMessages;
    if (messages.isNotEmpty) {
      lastMessages = messages.last;
    }
    if (lastMessages != null) {
      String lastMessagesContent = lastMessages.content;
      bool lastMessagesIsSentByMe = lastMessages.isSentByMe;
      String lastMessagesTime = lastMessages.time;
    } else {}

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
            title: appbarText,
            leadingWidget: SvgButton(imagePath: backarrow, onPressed: (){
              Navigator.pop(context);
            }),
            actionWidget: badges.Badge(
              badgeStyle: badges.BadgeStyle(
                badgeColor: Color(0xFFB3261E),
              ),
              position: badges.BadgePosition.topEnd(top: 5, end: 7.7),
              badgeContent: Center(child: Text(users.length.toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: 'Roboto'),)),
              child: Center(child: xeiconButton(text: '', onPressed: (){Scaffold.of(context).openEndDrawer();})),
            )
          // xeiconButton(text: '', onPressed: (){Scaffold.of(context).openEndDrawer();}),
        ),
        endDrawer: Drawer(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('참여자',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                    Spacer(),
                    SizedBox(width: 8,),
                    Text(users.length.toString()+ '명',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Color(0xFF757575)),),
                  ],
                ),
              ),
              Column(
                children: users.map((users){
                  return ListTile(
                    leading: Container(
                      child: Image.asset(users['image'],
                      width: 26,
                      height: 26,),
                    ),
                    title: Text(users['name'],style: TextStyle(fontSize: 12.0),),
                    // trailing: Container(
                    //   // width: users['isFollow'] ? 56 : 76,
                    //   // height: 30,
                    //   child: ElevatedButton(
                    //       onPressed: (){}, ),
                    // ),


                  );
                }).toList(),
              ),

            ],
          ),
        ),
        body: Container(
          color: Color(0xFFD3DDE7),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return messages[index];
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                ),
              ),
              Container(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                          width: MediaQuery.of(context).size.width-86,
                          height: 46,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            color: Color(0xFFF5F6FA),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: TextField(
                              controller: textEditingController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '메시지를 입력해주세요.',
                                hintStyle: TextStyle(fontSize: 13,color: Color(0xFFC8C8CB)),

                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Container(
                            width: 56,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () {
                                _sendMessage();
                              },
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    // 버튼 눌려있을때는 높이 0으로 해놓고
                                    return 0;
                                  }
                                  return 0.5; // 이건 디폴트
                                }),
                                backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    // 버튼이 눌려 있을 때의 배경색
                                    //color: rgb(72,116,234);
                                    return Color(0xFF345FB2); //
                                  }
                                  return buttonBlue; // 기본 배경색
                                }),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                              ),
                              child: Text(
                                '전송',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 13),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}



// Container(
// width: MediaQuery.of(context).size.width-86,
// height: 46,
// decoration: BoxDecoration(
// border: Border.all(color: Colors.transparent),
// color: Color(0xFFF5F6FA),
// borderRadius: BorderRadius.circular(10.0),
// ),
// child: Padding(
// padding:
// const EdgeInsets.symmetric(horizontal: 16.0),
// child: TextField(
// textAlignVertical: TextAlignVertical.center,
// controller: textEditingController,
// decoration: InputDecoration(
// border: InputBorder.none,
// hintText: '메시지를 입력해주세요.',
// hintStyle: TextStyle(fontSize: 13,color: Color(0xFFC8C8CB)),
//
// ),
// ),
// ),
// ),