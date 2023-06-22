import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:front/screen/profile/profileMain.dart';

class privatePolicy extends StatefulWidget {
  const privatePolicy({Key? key}) : super(key: key);

  @override
  State<privatePolicy> createState() => _privatePolicyState();
}

class _privatePolicyState extends State<privatePolicy> {
  String text = '';
  String appbarText = '개인정보처리방침';

  @override
  void initState() {
    super.initState();
    loadText();
  }

  Future<void> loadText() async {
    String loadedText = await rootBundle.loadString('assets/texts/privatePolicy.txt');
    setState(() {
      text = loadedText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => profileMain()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF2F2F2F),
            )),
        //leading아이콘 혹시나 필요하면

        title: Text(appbarText,
          style: TextStyle(fontSize: 16.0,color: Colors.black,fontFamily: 'PretendardBold'),
        ),

        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
          child: Center(
            child: Text(text,style: TextStyle(fontSize: 14.0,fontFamily: 'PretendardRegular'),),
          ),
        ),
      ),
    );
  }
}
