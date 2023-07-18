// 채팅 페이지

// 최종 수정일 : 2023.7.17
// 작업자 : 김혁

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';

import '../../data/chat/chatMessage.dart';
import '../../data/chat/participant.dart';
import '../../data/chat/messageManagement.dart';
import '../../data/designconst/constants.dart';
import '../../data/userNo.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/button/xeiconButton.dart';
import '../../model/showtoast.dart';
import '../profile/userProfile.dart';

final chatMessageProvider = StateNotifierProvider((ref) => ChatMessageState());

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({required this.meetNo, required this.meetTitle, Key? key})
      : super(key: key);

  final int meetNo;
  final String meetTitle;

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends ConsumerState<ChatPage> {
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();

  List<ChatParticipant> users = [];
  // 참여자 정보
  // profileImage
  // userName
  // userNo
  // follow

  //List<ChattingMessage> messages = [];
  // 채팅 메시지
  // profileImage
  // userName
  // comment
  // time

  // 채팅 전송
  Future<void> _sendMessage() async {
    final message = ChattingMessage(
      userImage: null,
      name: null,
      content: textEditingController.text,
      isSentByMe: true,
      time: DateTime.now(),
    );

    ref.read(chatMessageProvider.notifier).addMessage(message);

    try {
      final url = Uri.parse('http://todaymeet.shop:8080/chat/add');
      var postbody = {
        "user": {
          "userNo": UserNo.myuserNo,
        },
        "meet": {"meetNo": widget.meetNo},
        "content": textEditingController.text
      };

      Response response = await post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(postbody),
      );

      if (response.statusCode == 200) {
        debugPrint('메세지 전송 완료');
      } else {
        debugPrint('서버 오류');
        showToast('서버 오류');
        return;
      }
    } catch (e) {
      debugPrint('메세지 전송 오류');
      showToast('메세지 전송 오류');
    }

    setState(() {
      textEditingController.clear();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  // 채팅 메세지 출력
  Future<void> getChatMessage() async {
    try {
      final url = Uri.parse("http://todaymeet.shop:8080/chat/${widget.meetNo}");

      Response response = await get(url);

      if (response.statusCode == 200) {
        var serverData = jsonDecode(utf8.decode(response.bodyBytes));
        debugPrint('-------------------채팅 메세지-------------------');
        print(serverData);
        List<ChatMessage> serverMessageData = [];
        serverData.forEach(
            (element) => serverMessageData.add(ChatMessage.fromJson(element)));

        ref.read(chatMessageProvider.notifier).clearMessage();

        for (int index = 0; index < serverMessageData.length; index++) {
          ref.read(chatMessageProvider.notifier).addMessage(ChattingMessage(
              userImage: serverMessageData[index].userProfileImage,
              name: serverMessageData[index].username,
              content: serverMessageData[index].content,
              isSentByMe: serverMessageData[index].userNo == UserNo.myuserNo,
              time: serverMessageData[index].time));
        }
      } else {
        debugPrint('채팅 메세지 서버 오류');
        showToast('채팅 메세지 서버 오류');
      }
    } catch (e) {
      debugPrint("채팅 메세지 출력 오류");
      showToast("채팅 메세지 출력 오류");
    }
  }

  // 참가자 리스트 받아오기
  Future<void> getParticipant() async {
    try {
      final url = Uri.parse("http://todaymeet.shop:8080/chat-participant");
      var postbody = {"userNo": UserNo.myuserNo, "meetNo": widget.meetNo};

      Response response = await post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(postbody),
      );

      if (response.statusCode == 200) {
        var serverData = jsonDecode(utf8.decode(response.bodyBytes));
        debugPrint('-------------------참가자 리스트-------------------');
        print(serverData);
        users.clear();
        serverData
            .forEach((element) => users.add(ChatParticipant.fromJson(element)));
      } else {
        debugPrint('참가자 리스트 서버 오류');
        showToast('참가자 리스트 서버 오류');
      }
    } catch (e) {
      debugPrint("참가자 리스트 오류");
      showToast("참가자 리스트 오류");
    }
  }

  // 채팅방 퇴장
  Future<void> exitChatting() async{
    try{
      final url = Uri.parse("http://todaymeet.shop:8080/chat/participant-remove");
      var postbody = {
        "meet":{
          "meetNo":widget.meetNo
        },
        "user":{
          "userNo":UserNo.myuserNo
        }
      };

      Response response = await post(
          url,
          headers: {"Content-Type":"application/json"},
          body: json.encode(postbody)
      );

      if(response.statusCode == 200){
        debugPrint(response.toString());
        debugPrint('---------------------채팅방 퇴장 완료--------------------');
      } else{
        debugPrint('채팅방 퇴장 서버 오류');
        showToast('채팅방 퇴장 서버 오류');
      }
    } catch(e){
      debugPrint('채팅방 참가 오류');
      showToast('채팅방 참가 오류');
    }
  }

  // 팔로우
  Future<void> addFollow(int followerNo) async {
    try{
      final url = Uri.parse("http://todaymeet.shop:8080/follow/add");
      var postbody = {
        "followerNo":UserNo.myuserNo,
        "followeeNo":followerNo
      };

      Response response = await post(
        url,
        headers: {"Content-Type":"application/json"},
        body: json.encode(postbody),
      );

      if(response.statusCode == 200){
        debugPrint("팔로우 성공");
        print(response);
      }else{
        debugPrint("팔로우 서버 실패");
        showToast("팔로우 서버 실패");
      }
    }catch(e){
      debugPrint("팔로우 오류");
      showToast('팔로우 오류');
    }
  }

  @override
  void initState() {
    super.initState();

    // foreground 수신처리
    FirebaseMessaging.onMessage.listen(livechatting);

    Future.delayed(Duration.zero, () async {
      await getChatMessage();
      await getParticipant();
      setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 1),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  /// 실시간 채팅 처리
  void livechatting(RemoteMessage message) async {
    debugPrint("---------------------------------------------");

    RemoteNotification? notification = message.notification;
    debugPrint(notification!.title); // title
    debugPrint(notification.body); // body
    Map<String, dynamic> data = message.data;
    if (data['type'].toString() == "1") {
      debugPrint("--------------------------- type Chat");

      if(data['comment'] == "입장하셨습니다." || data['comment'] == "퇴장하셨습니다."){
        data.forEach((key, value) {
          debugPrint('Key: $key, Value: $value');
        });
        await getParticipant();
        setState(() {});
      }else{
        ChattingMessage newMessage = ChattingMessage(
            userImage: data['profileImage'],
            name: data['username'],
            content: data['comment'],
            isSentByMe: false,
            time: DateTime.parse(data['time']));

        ref.read(chatMessageProvider.notifier).addMessage(newMessage);

        data.forEach((key, value) {
          debugPrint('Key: $key, Value: $value');
        });

        setState(() {});
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 1),
            curve: Curves.easeInOut,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessageProvider.notifier);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async{
          await exitChatting();
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
              toolbarHeight: 50,
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                widget.meetTitle,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              leading: SvgButton(
                imagePath: backarrow,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                badges.Badge(
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Color(0xFFB3261E),
                  ),
                  position: badges.BadgePosition.topEnd(top: 3, end: 8.301),
                  badgeContent: Center(
                      child: Text(
                    users.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: 'Roboto',
                    ),
                  )),
                  child: Center(
                    child: xeiconButton(
                      text: '',
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),
                  ),
                )
              ]
              // xeiconButton(text: '', onPressed: (){Scaffold.of(context).openEndDrawer();}),
              ),
          endDrawer: Drawer(
            shadowColor: Colors.transparent,
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '참여자',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5),
                      ),
                      const Spacer(),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${users.length.toString()}명',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF757575),
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: users.map((users) {
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 사용자 이미지, 이름
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          userProfile(userNo: users.userNo)));
                            },
                            child: Row(
                              children: [
                                // 사용자 이미지
                                ClipOval(
                                  child: Image.network(
                                    users.profileImage,
                                    height: 26,
                                    width: 26,
                                  ),
                                ),
                                const SizedBox(width: 10),

                                // 사용자 이름
                                Text(
                                  users.username,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // 팔로우
                          users.userNo == UserNo.myuserNo
                              // 나인 경우
                              ? Container(
                                  height: 30,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 12),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xFFD6D6DD),
                                  ),
                                  child: const Text(
                                    "나",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12),
                                  ),
                                )
                              : users.follow == true
                                  // 팔로우하고 있는 경우
                                  ? Container(
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: const Color(0xFFD6D6DD),
                                      ),
                                      child: const Text(
                                        "팔로우",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        await addFollow(users.userNo);
                                        await getParticipant();
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 30,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFF558F),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          children: [
                                            const Text(
                                              "팔로우",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            SvgPicture.asset(
                                              "assets/icons/add_person.svg",
                                              width: 16,
                                              height: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          body: Container(
            color: const Color(0xFFD3DDE7),
            child: Column(
              children: [
                const SizedBox(height: 12),

                // 대화 메세지 출력
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    itemCount: messages.getLength(),
                    itemBuilder: (context, index) {
                      return messages.getList(index);
                    },
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // 메세지 입력 창
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, 0.1),
                          offset: Offset(0, -4),
                          blurRadius: 8,
                          blurStyle: BlurStyle.outer,
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // 메시지 입력 창
                      Expanded(
                        child: SizedBox(
                          height: 46,
                          child: TextField(
                            controller: textEditingController,
                            maxLines: null,
                            maxLength: 50,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '메시지를 입력해주세요.',
                              hintStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFC8C8CB),
                                  letterSpacing: -0.5),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              filled: true,
                              fillColor: Color(0xffF5F6FA),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(
                                  color: Color(0xffF5F6FA),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(
                                  color: Color(0xffF5F6FA),
                                ),
                              ),
                              counterText: '',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),

                      // 전송 버튼
                      GestureDetector(
                        onTap: () async {
                          if (textEditingController.text.isNotEmpty) {
                            _sendMessage();
                          }
                        },
                        child: Container(
                            width: 56,
                            height: 46,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4874EA),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "전송",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.5,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}