import 'package:flutter/material.dart';

import '../../../../data/designconst/constants.dart';

class textfieldTitle extends StatelessWidget {
  final String title;
  final bool star;
  final bool reverse;

  textfieldTitle({required this.title, required this.star, this.reverse = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (star && reverse) ...[
          Text(
            "*",
            style: TextStyle(
              color: messageRed,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: null,
              color: messageRed,
            ),
          ),
        ],
        if (star && !reverse) ...[
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Text(
            "*",
            style: TextStyle(
              color: messageRed,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
        if (!star) ...[
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ],
    );
  }
}