// // 계정 설정
// //
// // 남재혁
// // 최종수정일 2023.05.14
// //추후 작업예정사항
// // 화면 전체 수정
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:front/screen/login/Phone_ij.dart';
// import 'package:front/screen/login/favorite.dart';
// import 'package:front/screen/profile/privatePolicy.dart';
// import 'package:front/screen/profile/termsofUse.dart';
// import 'package:image_picker/image_picker.dart';
// // import 'login.dart';
// import 'dart:io';
//
// class registerProfile1 extends StatefulWidget {
//   final String email;
//   final String password;
//   registerProfile1({required this.email, required this.password});
//
//   @override
//   _registerProfile1State createState() => _registerProfile1State();
// }
//
// class _registerProfile1State extends State<registerProfile1> {
//
//   final _idController1 = TextEditingController();
//   File? _imageFile;
//   int _selectedSegment = 0;
//   DateTime? _selectedDate;
//   bool isChecked = false;
//   bool isChecked1 = false;
//   String username = '';
//   bool isDuplicateUsername = false;
//   bool isJoinSuccess = false;
//
//   String convertIsDuplicateToString(bool isDuplicateUsername) {
//     return isDuplicateUsername
//         ? '* 중복된 닉네임이 존재합니다.'
//         : '                             ';
//   }
//
//   Future<void> usernameDuplicate() async {
//     final url = Uri.parse('http://todaymeet.shop:8080/username/${username}');
//     final requestData = {
//       'username': username,
//     };
//     final jsonData = jsonEncode(requestData);
//     final response = await http.get(
//       url,
//       // headers: {'Content-Type': 'application/json'},
//     );
//     if (response.statusCode == 200) {
//       print('전송잘됨');
//       print(username);
//       print(url);
//       print(response.body);
//       setState(() {
//         isDuplicateUsername = false;
//       });
//     } else {
//       print('전송 자체가 안됨. 상태 침드: ${response.statusCode}');
//       print(username);
//       print(url);
//       setState(() {
//         isDuplicateUsername = true;
//       });
//     }
//   }
//
//   Future<void> join() async {
//     final url1 = Uri.parse('http://todaymeet.shop:8080/join');
//     final requestData = {
//       'username': username,
//       'password' : widget.password,
//       'email': widget.email,
//     };
//     final jsonData = jsonEncode(requestData);
//     final response = await http.post(
//       url1,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonData,
//     );
//     if (response.statusCode == 200) {
//       print('전송잘됨');
//       print(username);
//       print(url1);
//       print(response.body);
//       print(response);
//       setState(() {
//         isJoinSuccess = true;
//       });
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => favorite()),
//       );
//     } else {
//       print('전송 자체가 안됨. 상태 코드: ${response.statusCode}');
//       print(username);
//       print(widget.password);
//       print(widget.email);
//       print(url1);
//       print(jsonData);
//       print(response.body);
//       setState(() {
//         isJoinSuccess = true;
//       });
//
//     }
//   }
//   @override
//   Future<void> _pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: source);
//     if (pickedImage != null) {
//       setState(() {
//         _imageFile = File(pickedImage.path);
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _idController1.dispose();
//
//     super.dispose();
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//     );
//
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 1.0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//             size: 25,
//           ),
//           onPressed: () {
//             // _backto_prev(context);
//           },
//         ),
//         centerTitle: true,
//         title: Text(
//           '프로필 등록',
//           style: TextStyle(
//               fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 8.0),
//               Center(
//                 child: CircleAvatar(
//                   backgroundColor: Colors.grey,
//                   radius: 50,
//                   backgroundImage:
//                   _imageFile != null ? FileImage(_imageFile!) : null,
//                   child: _imageFile == null
//                       ? IconButton(
//                     icon: Icon(
//                       Icons.camera_alt,
//                       color: Colors.black,
//                     ),
//                     onPressed: () {
//                       _pickImage(ImageSource.gallery);
//                     },
//                   )
//                       : null,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 0,
//                 ),
//                 child: Row(children: [
//                   Text(
//                     "닉네임",
//                     style: TextStyle(
//                       fontSize: 17.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     "*",
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontSize: 17.0,
//                     ),
//                   )
//                 ]),
//               ),
//               SizedBox(height: 8.0),
//               Center(
//                 child: Container(
//                   width: 360,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0),
//                     border: Border.all(color: Colors.grey),
//                   ),
//                   child: TextField(
//                     controller: _idController1,
//                     onChanged: (value) {
//                       username = _idController1.text;
//                       usernameDuplicate();
//                       print(isDuplicateUsername);
//                       print(username);
//                       // usernameDuplicate();
//                     },
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.symmetric(
//                         vertical: 16.0,
//                         horizontal: 12.0,
//                       ),
//                       hintText: '아이디를 입력하세요',
//                       hintStyle: TextStyle(
//                         color: Colors.grey[400],
//                         fontSize: 13,
//                       ),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 '* 2자 이상 10 자 이하 한글, 영문, 숫자만 입력 가능합니다.',
//                 style: TextStyle(color: Colors.red),
//               ),
//               Text(
//                 convertIsDuplicateToString(isDuplicateUsername),
//                 style: TextStyle(color: Colors.red),
//               ),
//               SizedBox(height: 24.0),
//               Text(
//                 '성별(선택)',
//                 style: TextStyle(
//                   fontSize: 17.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Container(
//                 width: 360,
//                 height: 50,
//                 child: CupertinoSegmentedControl(
//                   children: {
//                     0: Text('선택안함'),
//                     1: Text('남자'),
//                     2: Text('여자'),
//                   },
//                   onValueChanged: (value) {
//                     setState(() {
//                       _selectedSegment = value as int;
//                     });
//                   },
//                   groupValue: _selectedSegment,
//                   borderColor: Colors.black,
//                   selectedColor: Colors.black,
//                   unselectedColor: Colors.white,
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Text(
//                 '생년월일(선택)',
//                 style: TextStyle(
//                   fontSize: 17.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xFFEDEDED),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: Row(
//                   children: [
//                     Text(
//                       _selectedDate != null
//                           ? ' ${_selectedDate!.toString().substring(0, 10)}'
//                           : '   0000-00-00',
//                     ),
//                     Spacer(),
//                     IconButton(
//                         onPressed: () {
//                           _selectDate(context);
//                         },
//                         icon: Icon(
//                           Icons.today,
//                           color: Colors.black,
//                         )),
//                   ],
//                 ),
//               ),
//               Spacer(),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: isChecked,
//                     onChanged: (value) {
//                       setState(() {
//                         isChecked = value!;
//                       });
//                     },
//                     activeColor: Colors.black,
//                   ),
//                   Text(
//                     '[필수] 이용약관 동의',
//                     style: TextStyle(
//                         fontSize: 17.0,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF8F9098)),
//                   ),
//                   Spacer(),
//                   IconButton(
//                     icon: Icon(
//                       Icons.arrow_forward_ios,
//                       color: Color(0xFF8F9098), // Set the desired color here
//                       size: 12,
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => privatePolicy()));
//                     },
//                   ),
//                 ],
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Row(
//                   children: [
//                     Checkbox(
//                       value: isChecked1,
//                       onChanged: (value) {
//                         setState(() {
//                           isChecked1 = value!;
//                         });
//                       },
//                       activeColor: Colors.black,
//                     ),
//                     Text(
//                       '[필수] 개인정보처리방침 동의',
//                       style: TextStyle(
//                         fontSize: 17.0,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF8F9098),
//                       ),
//                     ),
//                     Spacer(),
//                     IconButton(
//                       icon: Icon(
//                         Icons.arrow_forward_ios,
//                         color: Color(0xFF8F9098), // Set the desired color here
//                         size: 12,
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => termsofUse()));
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 56,
//                     child: CupertinoButton(
//                       onPressed: () {
//                         if (isChecked == false || isChecked1 == false) {
//                           _notAgree(context);
//                         } else if (isDuplicateUsername) {
//                           _checkUsername(context);
//                         } else {
//                           join();
//
//                         }
//                       },
//                       minSize: 0,
//                       padding: EdgeInsets.symmetric(),
//                       color: CupertinoDynamicColor.resolve(
//                         CupertinoColors.systemBlue,
//                         context,
//                       ).withAlpha(0xFF4874EA),
//                       borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                       child: Text(
//                         '저장',
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 24,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _backto_prev(BuildContext context) {
//     showCupertinoModalPopup<void>(
//       context: context,
//       builder: (BuildContext context) => CupertinoAlertDialog(
//         content: const Text('뒤로가기를 하실 경우 입력된 내용이 삭제됩니다.\n 이전화면으로 이동 하시겠습니까?'),
//         actions: <CupertinoDialogAction>[
//           CupertinoDialogAction(
//             isDefaultAction: true,
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.pop(context);
//             },
//             child: const Text('확인'),
//           ),
//           CupertinoDialogAction(
//             isDefaultAction: true,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('취소'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _notAgree(BuildContext context) {
//     showCupertinoModalPopup<void>(
//       context: context,
//       builder: (BuildContext context) => CupertinoAlertDialog(
//         content: const Text('동의항목에 체크해주세요'),
//         actions: <CupertinoDialogAction>[
//           CupertinoDialogAction(
//             isDefaultAction: true,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('확인'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _checkUsername(BuildContext context) {
//     showCupertinoModalPopup<void>(
//       context: context,
//       builder: (BuildContext context) => CupertinoAlertDialog(
//         content: const Text('닉네임을 확인해주세요'),
//         actions: <CupertinoDialogAction>[
//           CupertinoDialogAction(
//             isDefaultAction: true,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('확인'),
//           ),
//         ],
//       ),
//     );
//   }
// }
