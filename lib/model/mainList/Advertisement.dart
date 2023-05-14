//광고 배너 컨테이너

// 최종 수정: 2023.5.13
// 작업자: 정해수

import 'package:flutter/material.dart';

Widget Advertisement(String string) {
  return InkWell(
    child: Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
      width: 327,
      height: 144,
      decoration: BoxDecoration(
        color: Color(0xffF7F8FA),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(child: Text(string)),
    ),
    onTap: (){

    }, // -> 외부 광고 페이지
  );
}