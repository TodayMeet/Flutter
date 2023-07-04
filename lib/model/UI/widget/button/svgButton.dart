import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onPressed;
  final double width;
  final double height;

  SvgButton(
      {required this.imagePath,
        required this.onPressed,
        this.width = 24.0,
        this.height = 24.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onPressed, // 버튼이 눌렸을 때의 콜백 함수
          child: IconButton(onPressed: onPressed, color: Colors.black,icon: SvgPicture.asset(
            imagePath,
            width: width,
            height: height,
          ))
      )
    );
  }
}

// GestureDetector(
// onTap: onPressed, // 버튼이 눌렸을 때의 콜백 함수
// child: IconButton(onPressed: onPressed, color: Colors.black,icon: SvgPicture.asset(
// imagePath,
// width: width,
// height: height,
// ))
// )
//
//
// InkWell(
// onTap: onPressed,
// child: IconButton(
// onPressed: onPressed,
// color: Colors.black,
// icon: SvgPicture.asset(
// imagePath,
// width: width,
// height: height,
// )),
// ),