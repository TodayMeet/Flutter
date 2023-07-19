// 계정 설정
//
// 남재혁
// 최종수정일 2023.05.14
//추후 작업예정사항
// 화면 전체 수정
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front/screen/dialog/dialoglist.dart';
import 'package:front/screen/profile/hostEvent.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:front/screen/login/Phone_ij.dart';
import 'package:front/screen/login/favorite.dart';

import 'package:front/screen/profile/termsofUse.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'login.dart';
import 'dart:io';
import 'dart:convert';
import '../../data/designconst/constants.dart';

import '../../model/UI/widget/button/CameraButton.dart';
import '../../model/UI/widget/button/blueButton.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';
import '../../model/UI/widget/text/textfieldTitle.dart';
import '../profile/privatePolicy.dart';
import 'login.dart';

class registerProfile extends StatefulWidget {
  final String email;
  final String password;
  registerProfile({required this.email, required this.password});

  @override
  _registerProfileState createState() => _registerProfileState();
}

class _registerProfileState extends State<registerProfile> {

  final _idController1 = TextEditingController();
  File? showImageFile;
  XFile? imageFile;
  bool isimageFileNull = true;
  DateTime now = DateTime.now();
  DateTime? _selectedDate;
  bool isChecked = false;
  bool isChecked1 = false;
  String username = '';
  bool isDuplicateUsername = false;
  bool isJoinSuccess = false;
  List<String> _labels = ['선택안함', '남자', '여자'];
  List<bool> _selections = [false, false, false];
  int selectedValue =0;
  int userNo=0;
  int? gender;
  String? birth;
  // File defaultImage = Image.file('assets/images/LoginImage/test.png');


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
      print('중복. 상태 침드: ${response.statusCode}');
      print(username);
      print(url);
      setState(() {
        isDuplicateUsername = true;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();

    imageFile = await picker.pickImage(source: source);
    if (imageFile != null) {
      final file = File(imageFile!.path);
      setState(() {
        isimageFileNull = false;
        showImageFile = file;
      });
      print('--------------------------------------이미지 파일 선택 -----------------------------------------');
    }
  }

  Future<void> join() async {
    MultipartFile? imagefile;
    if(imageFile != null){
      imagefile = await MultipartFile.fromFile(imageFile!.path, contentType: MediaType('image', 'jpg'));
    }else{
      imagefile = null;
    }

    Dio dio = Dio();

    dio.options.contentType = 'multipart/form-data';
    FormData formData = FormData.fromMap({
      'username': username,
      'password': widget.password,
      'email': widget.email,
      'gender': gender,
      'birth':birth,
      'files':imagefile
    });

    final response = await dio.post(
      'http://todaymeet.shop:8080/joinB',
      data: formData,
    );

    if (response.statusCode == 200) {
      // 성공 처리
      debugPrint('------------------- 회원가입 완료 --------------------');
      setState(() {
        isJoinSuccess = true;
      });
    } else {
      // 실패 처리
      debugPrint('------------------- 회원가입 실패 -------------------');
      setState(() {
        isJoinSuccess = false;
      });
    }

  }
  Future<int> sendCredentialsToServer() async {
    final url = Uri.parse('http://todaymeet.shop:8080/loginB');
    final requestData = {
      'email': widget.email,
      'password': widget.password,
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.post(
      url,
      body: jsonData,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      // 성공적으로 서버로 전송됨
      print('로그인 성공');

      final userNo1 = jsonDecode(response.body);
      print('로그인 userNo : ${userNo1}');
      return userNo1;
    }
    else {
      print('로그인 안되는듯');
      print('로그인 실패. 상태 코드: ${response.statusCode}');
      return userNo;
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
        birth = DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS').format(_selectedDate!);
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
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: (MediaQuery.of(context).size.width - 138) / 2),
                width: MediaQuery.of(context).size.width,
                height: 122,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Stack(
                  children: [
                    CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 50,
                  backgroundImage:
                  showImageFile != null ? FileImage(showImageFile!) : null,
                  child: showImageFile == null
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


                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CameraButton(
                        onPressed: () {
                          _pickImage(ImageSource.gallery);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // ImagePicker

              SizedBox(height: 32.0),

              textfieldTitle(title: '닉네임', star: true), //닉네임 *
              SizedBox(height: 8.0),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Color(0xFF333333)),
                  ),
                  child: TextField(
                    autofocus: true,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10), // 최대 길이 제한
                      FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9가-힣]+$')), // 허용할 문자 패턴
                    ],
                    controller: _idController1,
                    onChanged: (value) {
                      username = _idController1.text;
                      usernameDuplicate();
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 16.0,
                      ),
                      hintText: '2자 이상 10자 이하 한글,영문,숫자만 입력 가능합니다.',
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

              textfieldTitle(
                title: ' 2자 이상 10 자 이하 한글, 영문, 숫자만 입력 가능합니다.',
                star: true,
                reverse: true,
              ),
              textfieldTitle(
                  title:
                  isDuplicateUsername
                      ? ' 중복된 닉네임이 존재합니다.'
                      : ' ',
                  star: isDuplicateUsername,
                  reverse: isDuplicateUsername),
              SizedBox(height: 8.0),
              // Text(
              //   convertIsDuplicateToString(isDuplicateUsername),
              //   style: TextStyle(color: Colors.red),
              // ),

              SizedBox(height: 32.0),
              textfieldTitle(title: '성별(선택)', star: false),
              SizedBox(
                height: 8.0,
              ),
              ToggleButtons(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFF4F4F4F),
                fillColor: Color(0xFF4F4F4F),
                selectedColor: Colors.white,
                splashColor: Colors.transparent,
                borderColor: Color(0xFF4F4F4F),
                children: List<Widget>.generate(_labels.length, (int index) {
                  return Container(
                    width: (MediaQuery.of(context).size.width - 53) / 3,
                    height: 46,
                    child: Center(
                      child: Text(
                        _labels[index],
                        style: TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.w700),
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
                    selectedValue = index;
                    gender = selectedValue;
                  });
                },
              ),

              SizedBox(
                height: 32,
              ),

              textfieldTitle(title: '생년월일(선택)', star: false), //생년월일 선택 텍스트
              SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
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
                      style:
                          TextStyle(fontSize: 13.0, color: Color(0xFF1F2024)),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: SvgPicture.asset(
                          'assets/icons/calendar.svg',
                          width: 24.0,
                          height: 24.0,
                        )),
                  ],
                ),
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
                          VisualDensity.compact,
                    ), //체크박스
                    Text(
                      '[필수] 이용약관 동의',
                      style:
                          TextStyle(fontSize: 14.0, color: Color(0xFF8F9098)),
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
              SizedBox(
                height: 12.0,
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 24,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(

                      child: Checkbox(
                        value: isChecked1,
                        onChanged: (value) {
                          setState(() {
                            isChecked1 = value!;
                          });
                        },
                        activeColor: Colors.black,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
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

              SizedBox(
                height: 24.0,
              ),
        blueButton(
          buttonText: '회원가입',

          onPressed: () async {
            if (!isChecked || !isChecked1) {
              onebutton.checkEssentialDialog(context);
            } else if (username.length == 0) {
              onebutton.noInputNameDialog(context);
            } else if (username.length < 2) {
              onebutton.oneWordNameDialog(context);
            } else {
              await join();
              await sendCredentialsToServer();
              userNo = await sendCredentialsToServer();
              print('userno: $userNo');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => favorite(userNo: userNo)
              ),
              );
            }
          },
        ),

        ],
          ),
        ),
      ),
    );
  }
}

// class signupButton extends StatelessWidget {
//   const signupButton({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return blueButton(
//       buttonText: '회원가입',
//       onPressed: () {
//         if (!isChecked || !isChecked1) {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text('알림'),
//                 content: Text('이용약관 및 개인정보처리방침에 동의해주세요.'),
//                 actions: [
//                   TextButton(
//                     child: Text('확인'),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               );
//             },
//           );
//         } else {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => favorite()),
//           );
//         }
//       },
//     );
//   }
// }

// String? validateInput(String value) {
//   if (username.length < 2) {
//     return '2자 이상 입력해주세요.';
//   }
//   if (value.length > 10) {
//     return '10자 이하로 입력해주세요.';
//   }
//   if (!RegExp(r'^[a-zA-Z0-9가-힣]+$').hasMatch(value)) {
//     return '한글, 영문, 숫자만 입력 가능합니다.';
//   }
//   return null; // 유효한 입력값인 경우 null 반환
// }

//