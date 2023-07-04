import 'package:flutter/material.dart';

class followPinkButton extends StatelessWidget{
  final String buttonText;
  final VoidCallback onPressed;
  final bool icon;

  const followPinkButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.icon = false,
  }) : super(key:key);

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Text('팔로우',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),),
          Text('',style: TextStyle(fontSize: 16,fontFamily: 'xeicon',color: Colors.white),)
        ],
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
// 버튼 눌려있을때는 높이 0으로 해놓고
            return 0;
          }
          return 0.5; // 이건 디폴트
        }),

// 바꿔야 하는 내용
        backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
// 버튼이 눌려 있을 때의 배경색

            return Color(0xFFEF457F); //
          }
          return Color(0xFFFF558F); // 기본 배경색
        }),

        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
      ),
    );
  }

}



























