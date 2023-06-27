import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leadingWidget;
  final String title;

  const CustomAppBar({
    required this.leadingWidget,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      backgroundColor: Color(0xFFFFFFFF),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Container(
          color: Color(0xFFE3E3E3), // 테두리 선의 색상
          height: 1.0, // 테두리 선의 높이
        ),
      ),
      leading: leadingWidget,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
