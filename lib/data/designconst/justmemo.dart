// // Navigator.push(
// // context,
// // MaterialPageRoute(
// // builder: (context) => item['goto']),
// // );
// // 로그아웃
// //
// // import 'package:flutter/material.dart';
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //           body: Stack(
// //             children: [
// //               // 사각형
// //               Container(
// //                 width: 200,
// //                 height: 200,
// //                 decoration: BoxDecoration(
// //                   color: Colors.grey[300],
// //                   borderRadius: BorderRadius.circular(8),
// //                 ),
// //                 child: Stack(
// //                   children: [
// //                     // 동그라미
// //                     Positioned(
// //                       top: 0,
// //                       right: 0,
// //                       child: Container(
// //                         width: 200,
// //                         height: 200,
// //                         decoration: BoxDecoration(
// //                           shape: BoxShape.circle,
// //                           color: Colors.blue,
// //                         ),
// //                       ),
// //                     ),
// //                     // ImagePicker
// //                     Positioned(
// //                       bottom: 0,
// //                       right: 0,
// //                       child: IconButton(
// //                         icon: Icon(Icons.image),
// //                         onPressed: () {
// //                           // ImagePicker를 실행할 동작
// //                         },
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           )
// //
// //
// //       ),
// //     );
// //   }
// // }
//
//
//
// // Container(
// // padding: EdgeInsets.symmetric(vertical: 16.0),
// // child: Center(
// // child: CircleAvatar(
// // backgroundColor: Colors.grey,
// // radius: 45,
// // backgroundImage:
// // _imageFile != null ? FileImage(_imageFile!) : null,
// // child: _imageFile == null
// // ? IconButton(
// // icon: Icon(
// // Icons.camera_alt,
// // color: Colors.black,
// // ),
// // onPressed: () {
// // _pickImage(ImageSource.gallery);
// // },
// // )
// //     : null,
// // ),
// // ),
// // ),
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:front/screen/chat/chatlist.dart';
// import 'package:intl/intl.dart';
//
// import '../profile/profileMain.dart';
//
// class ChatPage extends StatefulWidget {
//   const ChatPage({Key? key}) : super(key: key);
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }
//
// class ChatMessage extends StatelessWidget {
//   final String content;
//   final bool isSentByMe;
//   final String time;
//   const ChatMessage({
//     required this.content,
//     required this.isSentByMe,
//     required this.time,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment:
//       isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: [
//         Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Text(
//               formatTime(),
//               style: TextStyle(fontSize: 10,),
//             ),
//           ],
//         ),
//         Container(
//           alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
//           child: Container(
//             padding: EdgeInsets.all(8.0),
//             margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               color: isSentByMe ? Colors.yellow : Colors.white,
//             ),
//             child: Text(
//               content,
//               style: TextStyle(color: Colors.black, fontSize: 15),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   String formatTime() {
//     final now = DateTime.now();
//     final formattedTime = DateFormat('aa hh:mm').format(now);
//     final timeSuffix = now.hour >= 12 ? '오후' : '오전';
//     final replacedTime =
//     formattedTime.replaceAll('AM', '오전').replaceAll('PM', '오후');
//     return replacedTime;
//   }//시간 형식 지정
// }
//
// class _ChatPageState extends State<ChatPage> {
//   final String appbarText = '오늘 같이 놀 사람~!';
//   final List<ChatMessage> messages = <ChatMessage>[];
//   TextEditingController textEditingController = TextEditingController();
//   ScrollController scrollController = ScrollController();
//   void _sendMessage() {
//     if (textEditingController.text.isNotEmpty) {
//       setState(() {
//         ChatMessage message = ChatMessage(
//           content: textEditingController.text,
//           isSentByMe: true,
//           time: DateTime.now().toString(),
//         );
//         messages.add(message);
//         textEditingController.clear();
//         WidgetsBinding.instance!.addPostFrameCallback((_) {
//           scrollController.animateTo(
//             scrollController.position.maxScrollExtent,
//             duration: Duration(milliseconds: 100),
//             curve: Curves.easeInOut,
//           );
//         });
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ChatMessage? lastMessages;
//     if (messages.isNotEmpty) {
//       lastMessages = messages.last;
//     }
//     if (lastMessages != null) {
//       String lastMessagesContent = lastMessages.content;
//       bool lastMessagesIsSentByMe = lastMessages.isSentByMe;
//       String lastMessagesTime = lastMessages.time;
//     } else {}
//
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         toolbarHeight: 50,
//         backgroundColor: Color(0xFFFFFFFF),
//         elevation: 0,
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(1.0),
//           child: Container(
//             color : Color(0xFFE3E3E3),
//             height: 1.0,
//           ),
//         ),
//         leading: IconButton(
//             iconSize: 14.93,
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => profileMain()));
//             },
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: Color(0xFF2F2F2F),
//             )),
//         //leading아이콘 혹시나 필요하면
//
//         title: Text(appbarText,
//           style: TextStyle(fontSize: 16.0,color: Colors.black,fontFamily: 'PretendardBold'),
//         ),
//         centerTitle: true,
//
//         actions: [
//           Builder(
//             builder: (BuildContext context) {
//               return IconButton(
//                 icon: Icon(
//                   Icons.person,
//                   color: Colors.black,
//                 ),
//                 onPressed: () {
//                   Scaffold.of(context).openEndDrawer();
//                 },
//               );
//             },
//           ),
//         ],
//
//       ),
//       endDrawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             SizedBox(
//               height: 50,
//             ),
//             Padding(
//               padding:
//               const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '참여자',
//                     style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     '8명',
//                     style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.person),
//               title: Text('개굴개굴'),
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         color: Color(0xFFD3DDE7),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.separated(
//                 controller: scrollController,
//                 itemCount: messages.length,
//                 itemBuilder: (context, index) {
//                   return messages[index];
//                 },
//                 separatorBuilder: (context, index) => SizedBox(height: 5),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(0),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 70,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.transparent),
//                   color: Colors.white,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.transparent),
//                             color: Color(0xFFF5F6FA),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           child: Padding(
//                             padding:
//                             const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: TextField(
//                               controller: textEditingController,
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: '메시지를 입력해주세요.',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 4.0),
//                         child: Container(
//                           height: 50,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               _sendMessage();
//                             },
//                             style: ElevatedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               primary: Color(0xFF4874EA),
//                             ),
//                             child: Text(
//                               '전송',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w600, fontSize: 13),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }