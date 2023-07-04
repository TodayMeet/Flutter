
import 'package:flutter/material.dart';

import '../../../../data/designconst/constants.dart';

class CustomDialogOneButton extends StatelessWidget {
  final String message;
  final FontWeight messageFontWeight;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const CustomDialogOneButton({
    Key? key,
    required this.message,
    this.messageFontWeight = FontWeight.w400,
    required this.buttonText,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
        width: MediaQuery.of(context).size.width - 55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 36.0),
              child: Center(
                child: Center(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: messageFontWeight,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              height: 0,
              color: Colors.grey,
            ),
            InkWell(
              onTap: onButtonPressed,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 18.5),
                decoration: BoxDecoration(
                  color: buttonBlue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.8),
                    bottomRight: Radius.circular(15.8),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}