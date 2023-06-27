// 계정 설정
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정
import 'dart:convert';

import 'package:front/screen/profile/profileMain.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:front/screen/login/favorite.dart';

import 'package:front/screen/profile/termsofUse.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import '../../model/profile/CustomAppBar.dart';
import '../../model/svgbutton/svgbutton.dart';

class profileEdit extends StatefulWidget {
  const profileEdit({Key? key}) : super(key: key);
  // profileEdit({required this.email, required this.password});

  @override
  _profileEditState createState() => _profileEditState();
}

class _profileEditState extends State<profileEdit> {
  final _idController1 = TextEditingController();
  File? _imageFile;
  int _selectedSegment = 0;
  DateTime? _selectedDate;
  bool isChecked = false;
  bool isChecked1 = false;
  String username = '';
  bool isDuplicateUsername = false;
  bool isJoinSuccess = false;
  String appbarText = '프로필 수정';
  Color hinttextColor = Color(0xFFC8C8CB);
  Color _myRed = Color(0xFF3D00);
  Color dateboxColor = Color(0xFFEDEDED);
  Color calendarColor = Color(0xFF49454F);
  Color dateColor = Color(0xFF1F2024);
  String backarrow = 'assets/images/ProfileImage/backarrow.svg';

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
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed:() {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profileMain()));},
        ),
        title: appbarText,
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
                ),//
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
                      color: _myRed,
                      fontSize: 14.0,
                    ),
                  )
                ]),
              ),//닉네임 *
              SizedBox(height: 8.0),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Color(0xFF333333)),
                  ),
                  child: TextField(
                    controller: _idController1,
                    onChanged: (value) {
                      username = _idController1.text;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 16.0,
                      ),
                      hintText: '아이디를 입력하세요',
                      hintStyle: TextStyle(
                        color: hinttextColor,
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
                style: TextStyle(color: _myRed),
              ),
              // Text(
              //   convertIsDuplicateToString(isDuplicateUsername),
              //   style: TextStyle(color: Colors.red),
              // ),
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
              ),//segmentedbutton
              SizedBox(
                height: 32,
              ),
              Text(
                '생년월일(선택)',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ), //생년월일 선택 텍스트
              SizedBox(height: 8,),
              Container(
                decoration: BoxDecoration(
                  color: dateboxColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Text(
                      _selectedDate != null
                          ? ' ${_selectedDate!.toString().substring(0, 10)}'
                          : '   0000-00-00',
                      style: TextStyle(fontSize: 13.0,color: dateColor),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: Icon(
                          Icons.today,
                          color: calendarColor,
                        )),
                  ],
                ),
              ), //선택한 생년월일 표시 박스
              Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    child: CupertinoButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    profileMain()));
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
                      ), //저장 텍스트
                    ), // 저장 버튼
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
