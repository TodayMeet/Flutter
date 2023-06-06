import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/screen/chat/chatlist.dart';
import 'package:intl/intl.dart';

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
    return Row(
      mainAxisAlignment:
          isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          child: Text(
            formatTime(),
            style: TextStyle(fontSize: 10),
          ),
        ),
        Container(
          alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: isSentByMe ? Colors.yellow : Colors.white,
            ),
            child: Text(
              content,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  String formatTime() {
    final now = DateTime.now();
    final formattedTime = DateFormat('aa hh:mm').format(now);
    final timeSuffix = now.hour >= 12 ? '오후' : '오전';
    final replacedTime =
        formattedTime.replaceAll('AM', '오전').replaceAll('PM', '오후');
    return replacedTime;
  }
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> messages = <ChatMessage>[];
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
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
            duration: Duration(milliseconds: 100),
            curve: Curves.easeInOut,
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ChatMessage? lastMessage;
    if (messages.isNotEmpty) {
      lastMessage = messages.last;
    }
    if (lastMessage != null) {
      String lastMessageContent = lastMessage.content;
      bool lastMessageIsSentByMe = lastMessage.isSentByMe;
      String lastMessageTime = lastMessage.time;
    } else {}

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => chatlist(lastMessage: lastMessage),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          '용산동에서 치맥한잔 하실분',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
        centerTitle: true,
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '참여자',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '8명',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
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
                separatorBuilder: (context, index) => SizedBox(height: 8),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            color: Color(0xFFF5F6FA),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                              controller: textEditingController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '메시지 입력',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Container(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              _sendMessage();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              primary: Color(0xFF4874EA),
                            ),
                            child: Text(
                              '전송',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13),
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
    );
  }
}
