import 'package:flutter/material.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/screen/profile/profileMain.dart';

import '../../model/profile/CustomAppBar.dart';
import '../../model/svgbutton/svgbutton.dart';
// import 'mainListView.dart';



class hostEvent extends StatefulWidget {
  const hostEvent({Key? key}) : super(key: key);

  @override
  State<hostEvent> createState() => _hostEventState();
}

class _hostEventState extends State<hostEvent> {
  String backarrow = 'assets/images/ProfileImage/backarrow.svg';
  String appbarText = '개최한 건수';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed:() {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profileMain()));},
        ),
        title: appbarText,
      ),


    );
  }
}

