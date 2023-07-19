

import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/model/UI/widget/button/blueButton.dart';
import 'package:front/model/UI/widget/text/textfieldTitle.dart';
import 'package:front/screen/profile/profileMain.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../data/designconst/constants.dart';
import '../../model/UI/widget/button/CameraButton.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';



class profileEdit extends StatefulWidget {
  const profileEdit({Key? key}) : super(key: key);
  // profileEdit({required this.email, required this.password});

  @override
  _profileEditState createState() => _profileEditState();
}

class _profileEditState extends State<profileEdit> {
  final _idController1 = TextEditingController();
  File? _imageFile;
  DateTime? _selectedDate;
  String username = '';
  bool isDuplicateUsername = false;
  bool isJoinSuccess = false;
  List<String> _labels = ['선택안함','남자','여자'];
  List<bool> _selections = [false, false, false];

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
            Navigator.pop(context);},
        ),
        title: '프로필 수정',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 16,horizontal: (MediaQuery.of(context).size.width-138)/2),
                width: MediaQuery.of(context).size.width,
                height: 122,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Stack(
                  children: [
                    // 동그라미
                    Align(
                      alignment :Alignment.center,
                      child: Container(
                        padding: EdgeInsets.zero,
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image:AssetImage('assets/images/LoginImage/test.png'), fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    // ImagePicker
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CameraButton(onPressed: (){
                        _pickImage(ImageSource.gallery);
                      },
                      ),
                    ),
                  ],
                ),
              ),
              // ImagePicker

              SizedBox(height: 32.0),

              textfieldTitle(title: '닉네임', star: true),//닉네임 *
              SizedBox(height: 8.0),
              Center(
                child: Container(
                  padding: EdgeInsets.zero,
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
              textfieldTitle(title: '2자 이상 10 자 이하 한글, 영문, 숫자만 입력 가능합니다.', star: true,reverse: true,),
              SizedBox(height: 8.0),
              // Text(
              //   convertIsDuplicateToString(isDuplicateUsername),
              //   style: TextStyle(color: Colors.red),
              // ),

              SizedBox(height: 32.0),

              textfieldTitle(title: '성별(선택)', star: false),
              SizedBox(height: 8.0,),
              ToggleButtons(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFF4F4F4F),
                fillColor: Color(0xFF4F4F4F),
                selectedColor: Colors.white,
                splashColor: Colors.transparent,
                borderColor: Color(0xFF4F4F4F),
                children: List<Widget>.generate(_labels.length, (int index) {
                  return Container(
                    width: (MediaQuery.of(context).size.width-53)/3,
                    height: 46,
                    child: Center(
                      child: Text(
                        _labels[index],
                        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700),
                      ),
                    ),
                  );
                }),
                isSelected: _selections,
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < _selections.length; i++) {
                      _selections[i] = (i == index);
                    }
                  });
                },
              ),

              SizedBox(height: 32,),

              textfieldTitle(title: '생년월일(선택)', star: false), //생년월일 선택 텍스트
              SizedBox(height: 8,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 12.0),
                height: 46,
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
                      style: TextStyle(fontSize: 13.0,color: Color(0xFF1F2024)),
                    ),
                    Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: SvgPicture.asset('assets/icons/calendar.svg',width: 24.0,height: 24.0,)),
                  ],
                ),
              ), //선택한 생년월일 표시 박스
              Spacer(),


              blueButton(buttonText: '저장', onPressed: (){
                Navigator.pop(context);
              })
            ],
          ),
        ),
      ),
    );
  }

}
