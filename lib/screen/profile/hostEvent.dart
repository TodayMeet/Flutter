import 'package:flutter/material.dart';

import 'package:front/screen/profile/profileMain.dart';

import '../../data/designconst/constants.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';






class hostEvent extends StatefulWidget {
  const hostEvent({Key? key}) : super(key: key);

  @override
  State<hostEvent> createState() => _hostEventState();
}

class _hostEventState extends State<hostEvent> {

  
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
          width: 24.0,
          height: 24.0,
        ),
        title: '개최한 건수',
      ),


    );
  }
}

