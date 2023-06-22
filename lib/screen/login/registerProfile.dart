// 계정 설정
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:front/screen/login/Phone_ij.dart';
import 'package:front/screen/login/favorite.dart';
import 'package:front/screen/profile/privatePolicy.dart';
import 'package:front/screen/profile/termsofUse.dart';
import 'package:image_picker/image_picker.dart';
// import 'login.dart';
import 'dart:io';

class registerProfile extends StatefulWidget {
  final String email;
  final String password;
  registerProfile({required this.email, required this.password});

  @override
  _registerProfileState createState() => _registerProfileState();
}

class _registerProfileState extends State<registerProfile> {

  final _idController1 = TextEditingController();
  File? _imageFile;
  int _selectedSegment = 0;
  DateTime? _selectedDate;
  bool isChecked = false;
  bool isChecked1 = false;
  String username = '';
  bool isDuplicateUsername = false;
  bool isJoinSuccess = false;

  String convertIsDuplicateToString(bool isDuplicateUsername) {
    return isDuplicateUsername
        ? '* 중복된 닉네임이 존재합니다.'
        : '                             ';
  }

  Future<void> usernameDuplicate() async {
    final url = Uri.parse('http://todaymeet.shop:8080/username/${username}');
    final requestData = {
      'username': username,
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url,
      // headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      print('전송잘됨');
      print(username);
      print(url);
      print(response.body);
      setState(() {
        isDuplicateUsername = false;
      });
    } else {
      print('전송 자체가 안됨. 상태 침드: ${response.statusCode}');
      print(username);
      print(url);
      setState(() {
        isDuplicateUsername = true;
      });
    }
  }

  Future<void> join() async {
    final url1 = Uri.parse('http://todaymeet.shop:8080/join');
    final requestData = {
      'username': username,
      'password' : widget.password,
      'email': widget.email,
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.post(
      url1,
      headers: {'Content-Type': 'application/json'},
      body: jsonData,
    );
    if (response.statusCode == 200) {
      print('전송잘됨');
      print(username);
      print(url1);
      print(response.body);
      print(response);
      setState(() {
        isJoinSuccess = true;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => favorite()),
      );
    } else {
      print('전송 자체가 안됨. 상태 코드: ${response.statusCode}');
      print(username);
      print(widget.password);
      print(widget.email);
      print(url1);
      print(jsonData);
      print(response.body);
      setState(() {
        isJoinSuccess = true;
      });

    }
  }
  @override
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  void dispose() {
    _idController1.dispose();

    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          '프로필 등록',
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.0),
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 45,
                  backgroundImage:
                      _imageFile != null ? FileImage(_imageFile!) : null,
                  child: _imageFile == null
                      ? IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _pickImage(ImageSource.gallery);
                          },
                        )
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 0,
                ),
                child: Row(children: [
                  Text(
                    "닉네임",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " *",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                    ),
                  )
                ]),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Container(
                  width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextField(
                    controller: _idController1,
                    onChanged: (value) {
                      username = _idController1.text;
                      usernameDuplicate();
                      print(isDuplicateUsername);
                      print(username);
                      // usernameDuplicate();
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 16.0,
                      ),
                      hintText: '아이디를 입력하세요',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 13,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '* 2자 이상 10 자 이하 한글, 영문, 숫자만 입력 가능합니다.',
                style: TextStyle(color: Colors.red),
              ),
              Text(
                convertIsDuplicateToString(isDuplicateUsername),
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 24.0),
              Text(
                '성별(선택)',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 360,
                height: 50,
                child: CupertinoSegmentedControl(
                  children: {
                    0: Text('선택안함'),
                    1: Text('남자'),
                    2: Text('여자'),
                  },
                  onValueChanged: (value) {
                    setState(() {
                      _selectedSegment = value as int;
                    });
                  },
                  groupValue: _selectedSegment,
                  borderColor: Colors.black,
                  selectedColor: Colors.black,
                  unselectedColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '생년월일(선택)',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),//생년월일 선택 텍스트
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Text(
                      _selectedDate != null
                          ? ' ${_selectedDate!.toString().substring(0, 10)}'
                          : '   0000-00-00',
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: Icon(
                          Icons.today,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),//선택한 생년월일 표시 박스
              Spacer(),//생년월일 박스 - 이용약관 동의 사이 여백
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    activeColor: Colors.black,
                  ),//체크박스
                  Text(
                    '[필수] 이용약관 동의',
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8F9098)),
                  ),//필수이용약관동의 텍스트
                  Spacer(),// 동의 - 화살표 사이 공간
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF8F9098),
                      size: 12,
                    ),//화살표 아이콘
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => privatePolicy()));
                    },
                  ),//화살표 버튼
                ],
              ),//[필수]이용약관 동의 Row
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Checkbox(
                      value: isChecked1,
                      onChanged: (value) {
                        setState(() {
                          isChecked1 = value!;
                        });
                      },
                      activeColor: Colors.black,
                    ),//체크박스
                    Text(
                      '[필수] 개인정보처리방침 동의',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8F9098),
                      ),
                    ),//[필수] 개인정보처리방침 동의 텍스트
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF8F9098), // Set the desired color here
                        size: 12,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => termsofUse()));
                      },
                    ),
                  ],
                ),//row로 정렬
              ),// 개인정보처리방침 row담은 container
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    child: CupertinoButton(
                      onPressed: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => favorite()));// 임시로 다음 페이지로 넘어가게
                      },
                      minSize: 0,
                      padding: EdgeInsets.symmetric(),
                      color: CupertinoDynamicColor.resolve(
                        CupertinoColors.systemBlue,
                        context,
                      ).withAlpha(0xFF4874EA),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      child: Text(
                        '저장',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),//저장 텍스트
                    ),// 저장 버튼
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),//저장과 마지막 화면간 여백 24로 설정
            ],
          ),
        ),
      ),
    );
  }

  void _backto_prev(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: const Text('뒤로가기를 하실 경우 입력된 내용이 삭제됩니다.\n 이전화면으로 이동 하시겠습니까?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('확인'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('취소'),
          ),
        ],
      ),
    );
  }// 뒤로가기로 전체 프로세스 취소 팝업 알림 함수

  void _notAgree(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: const Text('동의항목에 체크해주세요'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }// 동의항목에 체크하지 않았을때 띄우는 팝업

  void _checkUsername(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: const Text('닉네임을 확인해주세요'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }// 닉네임 중복일때 띄우는 팝업 알림
}
