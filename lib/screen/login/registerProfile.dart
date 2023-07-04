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

import 'package:front/screen/profile/termsofUse.dart';
import 'package:image_picker/image_picker.dart';
// import 'login.dart';
import 'dart:io';

import '../../data/designconst/constants.dart';


import '../../model/UI/widget/button/blueButton.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';
import 'login.dart';

class registerProfile extends StatefulWidget {
  // final String email;
  // final String password;
  // registerProfile({required this.email, required this.password});

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
      // 'password' : widget.password,
      // 'email': widget.email,
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
      // print(widget.password);
      // print(widget.email);
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          leadingWidget: SvgButton(
            imagePath: backarrow,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => login()));
            },
          ),
          title: '프로필 등록',
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(24.0, 0, 24.0, 24),
          child: Column(
            children: [
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
              ), //imagepicker
              SizedBox(height: 32,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      "닉네임",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      " *",
                      style: messageStyle
                    )
                  ]), //닉네임*
                  SizedBox(height: 8.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Color(0xFF333333)),
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
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                        hintText: '아이디를 입력하세요',
                        hintStyle: TextStyle(
                          color: textfieldColor,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '* 2자 이상 10 자 이하 한글, 영문, 숫자만 입력 가능합니다.',
                    style: messageStyle,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    convertIsDuplicateToString(isDuplicateUsername),
                    style: messageStyle,
                  ),
                ],
              ), //닉네임 입력
              SizedBox(height: 32,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '성별(선택)',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ToggleButtons(
                      children: [
                        Text('선택안함'),
                        Text('남자'),
                        Text('여자'),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          _selectedSegment = index;
                        });
                      },
                      isSelected: [
                        _selectedSegment == 0,
                        _selectedSegment == 1,
                        _selectedSegment == 2,
                      ],
                      color: Colors.black,
                      selectedColor: Colors.white,
                      fillColor: Colors.black,
                      borderColor: Colors.black,
                      selectedBorderColor: Colors.black,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ],
              ), //togglebutton
              SizedBox(height: 32,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '생년월일(선택)',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ), //생년월일 선택 텍스트
                  SizedBox(height: 8.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEDEDED),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      children: [
                        Text(
                          _selectedDate != null
                              ? ' ${_selectedDate!.toString().substring(0, 10)}'
                              : '   0000-00-00',
                          style:
                              TextStyle(fontSize: 13, color: Color(0xFF1F2024)),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          icon: Icon(
                            Icons.today,
                            color: Color(0xFF49454F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ), //선택한 생년월일 표시 박스
              Spacer(), //생년월일 박스 - 이용약관 동의 사이 여백

              Container(
                width: MediaQuery.of(context).size.width,
                height: 24,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      activeColor: Colors.black,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      // 크기를 컨테이너에 맞추기 위해 추가
                      visualDensity:
                          VisualDensity.compact, // 밀도를 조정하여 크기를 조절할 수도 있음
                    ), //체크박스
                    Text(
                      '[필수] 이용약관 동의',
                      style: TextStyle(fontSize: 14.0, color: Color(0xFF8F9098)),
                    ), //필수이용약관동의 텍스트
                    Spacer(), // 동의 - 화살표 사이 공간
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF8F9098),
                        size: 12,
                      ), //화살표 아이콘
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => privatePolicy()));
                      },
                    ), //화살표 버튼
                  ],
                ),
              ), //[필수]이용약관 동의 Row
              SizedBox(height: 12.0,),


              Container(
                width: MediaQuery.of(context).size.width,
                height: 24,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isChecked1,
                      onChanged: (value) {
                        setState(() {
                          isChecked1 = value!;
                        });
                      },
                      activeColor: Colors.black,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      // 크기를 컨테이너에 맞추기 위해 추가
                      visualDensity: VisualDensity.compact,
                    ), //체크박스
                    Text(
                      '[필수] 개인정보처리방침 동의',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF8F9098),
                      ),
                    ), //[필수] 개인정보처리방침 동의 텍스트
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
                ), //row로 정렬
              ), // 개인정보처리방침 row담은 container

              SizedBox(height: 24.0,),
              signupButton(), // 임시로 다음 페이지로 넘어가게} )
            ],
          ),
        ),
      ),
    );
  }
}

class signupButton extends StatelessWidget {
  const signupButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return blueButton(
        buttonText: '회원가입',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => favorite()));
        });
  }
}
