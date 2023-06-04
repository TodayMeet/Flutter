import 'package:flutter/material.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/screen/profile/profileMain.dart';
// import 'mainListView.dart';



class hostEvent extends StatefulWidget {
  const hostEvent({Key? key}) : super(key: key);

  @override
  State<hostEvent> createState() => _hostEventState();
}

class _hostEventState extends State<hostEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);

        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: Text(
          '개최한 건수',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600
          ),
        ),
        actions: null,
        centerTitle: true,
      ),

    );
  }
}
