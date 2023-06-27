import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  SvgButton({required this.imagePath, required this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: onPressed,
          child: SvgPicture.asset(
            imagePath,
            semanticsLabel: 'Button',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
