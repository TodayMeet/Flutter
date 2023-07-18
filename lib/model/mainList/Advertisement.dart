//광고 배너 컨테이너

// 최종 수정: 2023.5.13
// 작업자: 정해수

import 'package:flutter/material.dart';

Widget Advertisement(String url) {
  return Column(
    children: [
      Container(
        width: double.maxFinite,
        height: 144,
        decoration: BoxDecoration(
          color: const Color(0xffF7F8FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            url,
            width: double.maxFinite,
            height: 144,
            fit: BoxFit.fill,
          ),
        ),
      ),
      const SizedBox(height: 18,)
    ],
  );
}