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
          toolbarHeight: 50,
          backgroundColor: Color(0xFFFFFFFF),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Container(
              color : Color(0xFFE3E3E3), // 테두리 선의 색상
              height: 1.0, // 테두리 선의 높이
            ),
          ),
          leading: IconButton(
            iconSize: 14.93,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profileMain()));
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF2F2F2F),
              )),
          //leading아이콘 혹시나 필요하면

          title: Text(
            '개최한 건수',
            style: TextStyle(fontSize: 16.0,color: Colors.black,fontFamily: 'PretendardBold'),
          ),

          centerTitle: true,
        ),

    );
  }
}

