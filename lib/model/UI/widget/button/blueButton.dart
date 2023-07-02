import 'package:flutter/material.dart';
import '../../../../data/designconst/constants.dart';

class blueButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;


  const blueButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(

        width: MediaQuery.of(context).size.width,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                // 버튼 눌려있을때는 높이 0으로 해놓고
                return 0;
              }
              return 0.5; // 이건 디폴트
            }),
            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                // 버튼이 눌려 있을 때의 배경색
                //color: rgb(72,116,234);
                return Color(0xFF345FB2); //
              }
              return buttonBlue; // 기본 배경색
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          ),
          // style: ElevatedButton.styleFrom(
          //   elevation: 0,
          //   backgroundColor: buttonBlue,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(12.0),
          //   ),
          // ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 16.0),
            child: Center(
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//
// style: ButtonStyle(
// backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
// if (states.contains(MaterialState.pressed)) {
// // 꾹 누르고 있을 때 버튼 색상 변경
// return Colors.grey.withOpacity(0.5);
// }
// return Colors.blue; // 기본 버튼 색상
// }),