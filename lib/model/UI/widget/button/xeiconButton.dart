import 'package:flutter/material.dart';

class xeiconButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final double fontSize;



  const xeiconButton({
    Key? key,
    this.text='',
    required this.onPressed,
    this.fontSize=24,

  }): super(key : key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (){
          Scaffold.of(context).openEndDrawer();
        },
        child: Text(text,style: TextStyle(color: Colors.black,fontFamily: 'xeicon',fontSize: fontSize),));
  }
}
