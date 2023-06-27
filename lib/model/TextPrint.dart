//문자열, 정수 Text 출력 클래스

// 최종 수정: 2023.5.9
// 작업자: 정해수

import 'package:flutter/material.dart';

Widget StringText(String string, double size, FontWeight fontweight, Color color) {
  return Text(string,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: fontweight,
    ),
  );
} //문자열 출력

Widget IntText(int num, double size, FontWeight fontweight, Color color) {
  return Text('$num',
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: fontweight,
    ),
  );
} //정수 출력

Widget StringText_letterspacing(String string, double size, FontWeight fontweight, Color color, double space) {
  return Text(string,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: fontweight,
      letterSpacing: space,
    ),
  );
} //문자열 출력

Widget IntText_letterspacing(int num, double size, FontWeight fontweight, Color color, double space) {
  return Text('$num',
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: fontweight,
      letterSpacing: space,
    ),
  );
} //정수 출력
