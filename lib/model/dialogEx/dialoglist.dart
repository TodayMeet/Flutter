import 'package:flutter/material.dart';

import '../../screen/login/accountsetting.dart';
import '../../screen/login/login.dart';
import 'CustomDialog.dart';




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
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => login()),
                  (route) => false);
          Navigator.pop(context);
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
  }
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
  }
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
  }
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
  }
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
  }
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
  }
  static void overFive(BuildContext context){
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
  }
}