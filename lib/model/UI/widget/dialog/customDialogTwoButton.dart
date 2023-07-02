import 'package:flutter/material.dart';

import '../../../../data/designconst/constants.dart';

class CustomDialogTwoButton extends StatelessWidget {
  final String? title;
  final FontWeight titleFontWeight;
  final String message;
  final FontWeight messageFontWeight;
  final String leftButtonText;
  final String rightButtonText;
  final VoidCallback? onLeftPressed;
  final VoidCallback? onRightPressed;

  const CustomDialogTwoButton({
    Key? key,
    this.title,
    this.titleFontWeight = FontWeight.w700,
    required this.message,
    this.messageFontWeight = FontWeight.w400,
    required this.leftButtonText,
    required this.rightButtonText,
    this.onLeftPressed,
    this.onRightPressed,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (title != null) ...[
                    Center(
                      child: Text(
                        title!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: titleFontWeight,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(
                    height: 12.0,
                  ),
                  Center(
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
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
              height: 0,
              color: Colors.grey,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: onLeftPressed,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 18.5),
                      decoration: BoxDecoration(
                        color: buttonBlue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.8),
                        ),
                      ),
                      child: Text(
                        leftButtonText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: onRightPressed,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 18.5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15.8),
                        ),
                      ),
                      child: Text(
                        rightButtonText,
                        style: TextStyle(
                          color: buttonBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}