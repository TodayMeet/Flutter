import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/designconst/constants.dart';

class whiteButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final bool icon;

  const whiteButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.width = 113.5,
    this.height = 40,
    this.icon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        child: icon
            ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: Color(0xFF666666),
                fontSize: 14.0,
              ),
            ),
            SvgPicture.asset(
              fowardarrow,
              width: 16,
              height: 16,
            ),
          ],
        )
            : Text(
          buttonText,
          style: TextStyle(
            color: Color(0xFF666666),
            fontSize: 14.0,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          // overlayColor: MaterialStateProperty.all<Color>(Colors.blue),

        ),
      ),
    );
  }
}
