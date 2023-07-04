//광고 배너 컨테이너

// 최종 수정: 2023.5.13
// 작업자: 정해수

import 'package:flutter/material.dart';
import '../showtoast.dart';

Widget Advertisement(String string) {
  return Column(
    children: [
      InkWell(
        child: Container(
          width: double.maxFinite,
          height: 144,
          decoration: BoxDecoration(
            color: const Color(0xffF7F8FA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child: Text(string)),
        ),
        onTap: (){
          showToast('외부 페이지로 이동합니다');
        }, // -> 외부 광고 페이지
      ),
      const SizedBox(height: 18,)
    ],
  );
}