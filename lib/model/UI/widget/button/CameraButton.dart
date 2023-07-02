// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// class CameraButton extends StatelessWidget {
//   final String imagePath;
//   final VoidCallback onPressed;
//   final double width;
//   final double height;
//
//   CameraButton(
//       {required this.imagePath,
//         required this.onPressed,
//         this.width = 24.0,
//         this.height = 24.0});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 24.0,
//       width: 24.0,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Color(0xFF828282),
//       ),
//       child: IconButton(
//           onPressed: onPressed,
//           color: Color(0xFF828282),
//           icon: SvgPicture.asset(
//             imagePath,
//             width: 18000000,
//
//
//           )),
//
//
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../data/designconst/constants.dart';

// class CameraButton extends StatelessWidget {
//   final String imagePath;
//   final VoidCallback onPressed;
//   final double width;
//   final double height;
//
//   CameraButton(
//       {required this.imagePath,
//         required this.onPressed,
//         this.width = 24.0,
//         this.height = 24.0});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(onPressed: (){}, child: SvgPicture.asset(camera),style: ,);
//   }
// }


class CameraButton extends StatelessWidget {
  final VoidCallback onPressed;

  CameraButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 24.0, // 버튼의 너비
        height: 24.0, // 버튼의 높이
        decoration: BoxDecoration(
          color: Color(0xFF828282), // 배경색깔
          shape: BoxShape.circle, // 원 모양으로 설정
        ),
        child: Center(
          child: SvgPicture.asset(
            camera, // Svg 이미지 경로
            width: 12.0, // Svg 너비
            height: 12.0, // Svg 높이
          ),
        ),
      ),
    );
  }
}

