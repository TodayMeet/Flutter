import 'package:flutter/material.dart';

const Color buttonBlue = Color(0xFF4874EA);
//color: rgb(72,116,234);
const Color messageRed = Color(0xFFFF3D00);
const Color hinttextColor = Color(0xFFC8C8CB);
const String pwTitle = ' 2자 이상 12자 이하 영문, 숫자 특수기호만 입력 가능';
const String backarrow = 'assets/icons/backarrow.svg';
const String fowardarrow = 'assets/icons/fowardarrow.svg';
const String camera = 'assets/icons/detail/Camera.svg';
const Color textfieldColor = Color(0xFFF5F6FA);
const String visible = 'assets/icons/detail/Visibility.svg';
const String visibleOff = 'assets/icons/detail/Visibility_off.svg';
const String Camera = 'assets/icons/detail/Camera.svg';
TextStyle messageStyle = TextStyle(color: messageRed, fontSize: 12.0);


ButtonStyle CustomButtonStyle(Color backgroundColor, Color pressedColor, Color borderColor) {
  return ButtonStyle(
    elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return 0;
      }
      return 0.5;
    }),
    backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return pressedColor;
      }
      return backgroundColor;
    }),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        side: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
  );
}
