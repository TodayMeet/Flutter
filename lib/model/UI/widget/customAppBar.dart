import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget  implements PreferredSizeWidget{
  final Widget? leadingWidget;
  final String title;
  final bool? automaticallyImplyLeading;
  final Widget? actionWidget;

  const CustomAppBar({
    this.leadingWidget = null,
    this.automaticallyImplyLeading = false,
    required this.title,
    this.actionWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(

      toolbarHeight: 50,
      backgroundColor: Color(0xFFFFFFFF),
      elevation: 0,
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Container(
          color: Color(0xFFE3E3E3),
          height: 1.0,
        ),
      ),
      leading: leadingWidget,
      // leading: leadingWidget !=null  ? :,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: actionWidget != null ? [actionWidget!] : [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}