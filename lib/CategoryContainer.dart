// 카테고리 컨테이너 색상 선택 클래스

// 최종 수정: 2023.4.25
// 작업자: 정해수

import 'package:flutter/material.dart';

Widget CategoryContainer(String category) {
  switch(category) {
    case '맛집': case '카페':
    return Container(
      width: 53,
      height: 20,
      decoration: BoxDecoration(
        color: Color(0xffE91E63),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(category,
          style: TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontFamily: 'PretendardBold',
          ),
        ),
      ),
    );
    case '주류':
      return Container(
        width: 53,
        height: 20,
        decoration: BoxDecoration(
          color: Color(0xff3F51B5),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(category,
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontFamily: 'PretendardBold',
            ),
          ),
        ),
      );
    case '영화':
      return Container(
        width: 53,
        height: 20,
        decoration: BoxDecoration(
          color: Color(0xff673AB7),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(category,
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontFamily: 'PretendardBold',
            ),
          ),
        ),
      );
    case '전시': case '공연':
    return Container(
      width: 53,
      height: 20,
      decoration: BoxDecoration(
        color: Color(0xff607D8B),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(category,
          style: TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontFamily: 'PretendardBold',
          ),
        ),
      ),
    );
    case '게임':
      return Container(
        width: 53,
        height: 20,
        decoration: BoxDecoration(
          color: Color(0xffFF5722),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(category,
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontFamily: 'PretendardBold',
            ),
          ),
        ),
      );
    case '봉사':
      return Container(
        width: 53,
        height: 20,
        decoration: BoxDecoration(
          color: Color(0xff8BC34A),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(category,
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontFamily: 'PretendardBold',
            ),
          ),
        ),
      );
    case '독서':
      return Container(
        width: 53,
        height: 20,
        decoration: BoxDecoration(
          color: Color(0xff374046),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(category,
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontFamily: 'PretendardBold',
            ),
          ),
        ),
      );
    case '스터디':
      return Container(
        width: 53,
        height: 20,
        decoration: BoxDecoration(
          color: Color(0xff9C27B0),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(category,
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontFamily: 'PretendardBold',
            ),
          ),
        ),
      );
    case '반려동물':
      return Container(
        width: 53,
        height: 20,
        decoration: BoxDecoration(
          color: Color(0xff795548),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(category,
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontFamily: 'PretendardBold',
            ),
          ),
        ),
      );
    case '운동': default: return Container(
    width: 53,
    height: 20,
    decoration: BoxDecoration(
      color: Color(0xffDCA966),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Center(
      child: Text(category,
        style: TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontFamily: 'PretendardBold',
        ),
      ),
    ),
  );
  }
}