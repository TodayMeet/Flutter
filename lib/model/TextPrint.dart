//문자열, 정수 Text 출력 클래스

// 최종 수정: 2023.5.9
// 작업자: 정해수

import 'package:flutter/material.dart';

Widget StringText(String string, double size, String font, Color color) {
  return Text(string,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: font,
    ),
  );
} //문자열 출력

Widget IntText(num, double size, String font, Color color) {
  return Text('$num',
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: font,
    ),
  );
} //정수 출력