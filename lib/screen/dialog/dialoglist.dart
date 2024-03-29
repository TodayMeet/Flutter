import 'dart:convert';

import 'package:front/screen/profile/profileMain.dart';

import '../login/start.dart';
import 'package:flutter/material.dart';
import '../../data/userNo.dart';
import '../../model/UI/widget/dialog/customDialogOneButton.dart';
import '../../model/UI/widget/dialog/customDialogTwoButton.dart';
import '../../screen/login/login.dart';
import 'package:http/http.dart' as http;

Future<void> secessionFunction() async {
  final url = Uri.parse('http://todaymeet.shop:8080/delete-userno/${UserNo.myuserNo}');

  final requestData = {
    'userNo': UserNo.myuserNo,
  };
  final jsonData = jsonEncode(requestData);
  final response2 = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
  );
  if (response2.statusCode == 200) {

    final responseData2 = jsonDecode(response2.body);
    print(responseData2);
  } else {
    print('asdffsdf');
  }
}



class twobutton {
  static void logoutDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogTwoButton(

        message: '로그아웃 하시겠습니까?',
        leftButtonText: '취소',
        rightButtonText: '확인',
        onLeftPressed: () {
          Navigator.pop(context);
        },
        onRightPressed: () {
          storage.delete(key: "login");
          print('------------------------------자동 로그인 삭제------------------------------');
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => login()),
                  (route) => false);
        },
      ),
    );
  }
  static void showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogTwoButton(

        message: '신고하시겠습니까?',
        messageFontWeight: FontWeight.w700,
        leftButtonText: '취소',
        rightButtonText: '확인',
        onLeftPressed: () {
          Navigator.pop(context);
        },
        onRightPressed: () {
          Navigator.pop(context);

        },
      ),
    );
  }
  static void inviteDialog(BuildContext context,String host){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogTwoButton(

        message: host + ' 님이 참가 요청을 했습니다. \n참가를 승인하시겠습니까?',

        leftButtonText: '취소',
        rightButtonText: '확인',
        onLeftPressed: () {
          Navigator.pop(context);
        },
        onRightPressed: () {
          Navigator.pop(context);

        },
      ),
    );
  }
  static void secessionDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogTwoButton(
        title: '탈퇴신청',
        titleFontWeight: FontWeight.w700,
        message: '탈퇴 후 서비스 이용이 불가능 합니다.\n 탈퇴하시겠습니까?',
        leftButtonText: '취소',
        rightButtonText: '확인',
        onLeftPressed: () {
          Navigator.pop(context);
        },
        onRightPressed: () {
          secessionFunction();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => login()),
                  (route) => false);


        },
      ),
    );
  } // db에 요청하는거라
  static void backtoLoginDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogTwoButton(
        message: '뒤로가기를 하실경우 입력된 내용이 삭제됩니다.\n 이전화면으로 이동 하시겠습니까?',

        leftButtonText: '취소',
        rightButtonText: '확인',
        onLeftPressed: () {
          Navigator.pop(context);
        },
        onRightPressed: () {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => login()),
                  (route) => false);
        },
      ),
    );
  }
}

class onebutton{
  static void incorrectInputDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '입력하신 아이디 또는 비밀번호가 일치하지 않습니다.\n확인 후 다시 입력해 주세요.',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  } //아이디 비밀번호 잘못입력
  static void noInputIDDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '아이디를 입력해주세요',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  } //아이디 입력x
  static void noInputPwDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '비밀번호를 입력해주세요',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  } //비밀번호 입력x
  static void alreadyphoneDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '이미 가입된 휴대전화번호입니다..',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  }// 이미 가입된 휴대전화번호
  static void inputTimeOverDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '입력시간이 초과되었습니다.',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  } //입력시간초과
  static void certificationSuccessDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '휴대전화번호 인증이 완료되었습니다.',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  } //인증성공
  static void certificationFailDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '휴대전화번호 인증을 완료해주세요',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  } //휴대전화번호 인증을 완료해주세요
  static void incorrectCertificationDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '인증번호가 올바르지 않습니다.\n다시 확인해주세요.',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  } //인증번호 틀림
  static void notmemberDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '가입되지 않은 휴대전화번호입니다.\n회원가입을 해주세요.',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  } //가입되지 않은 휴대전화번호
  static void overFiveDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '5개 이하로 선택해주세요',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  } //관심사 5개 이상 선택했을 경우
  static void over200Dialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '200자 내로 입력해주세요',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  } //200자 이상 입력했을때
  static void over500Dialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '500자 내로 입력해주세요',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  } //500자 이상 입력했을때
  static void questionConfirmDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '문의 접수되었습니다.',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);

        },

      ),
    );
  } //문의 접수되었습니다.
  static void checkEssentialDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '필수동의항목에 체크해주세요.',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  } //필수항목 동의 안함
  static void idisEmailDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '아이디를 이메일 형식으로 입력해주세요.',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  }
  static void oneWordNameDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '2자 이상 입력해주세요.',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  }
  static void tenWordNameDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '10자 이하로 입력해주세요.',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  }
  static void KoEnNumDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '한글 영문 숫자만 입력 가능합니다.',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  }
  static void emailDuplicateCheckDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '이메일 중복여부를 확인해주세요.',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  } //이메일 중복 여부를 확인해주세요
  static void noInputNameDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '닉네임은 필수 입력사항입니다.',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  } //닉네임은 필수 입력사항입니다.
  static void pwChangeDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '비밀번호가 변경되었습니다.',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pop(context);
        },

      ),
    );
  } //비밀번호 변경되었습니다.
  static void favoriteChangeDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogOneButton(
        message: '관심사가 변경되었습니다.',
        buttonText: '확인',
        onButtonPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => profileMain()),
                  (route) => false);

        },

      ),
    );
  } //관심사가 변경되었습니다.

}