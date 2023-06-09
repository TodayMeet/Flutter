import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:front/screen/profile/profileMain.dart';

import '../../data/designconst/constants.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';


class termsofUse extends StatefulWidget {
  const termsofUse({Key? key}) : super(key: key);

  @override
  State<termsofUse> createState() => _termsofUseState();
}

class _termsofUseState extends State<termsofUse> {
  String text = '';

  @override
  void initState() {
    super.initState();
    loadText();
  }

  Future<void> loadText() async {
    String loadedText = await rootBundle.loadString('assets/texts/termsofUse.txt');
    setState(() {
      text = loadedText;
    });
  }//이용약관txt 불러오기

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed:() {
            Navigator.pop(context);
            },
          width: 24.0,
          height: 24.0,

        ),
        title: '이용약관',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(child: Text(text,style: TextStyle(fontSize: 14,),),),
        ),
      ),
    );
  }
}

class privatePolicy extends StatefulWidget {
  const privatePolicy({Key? key}) : super(key: key);

  @override
  State<privatePolicy> createState() => _privatePolicyState();
}

class _privatePolicyState extends State<privatePolicy> {
  String text = '';


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
      appBar: CustomAppBar(
        leadingWidget: IconButton(
          iconSize: 14.93,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF2F2F2F),
          ),
        ),
        title: '개인정보처리방침',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Text(text,style: TextStyle(fontSize: 14.0),),
          ),
        ),
      ),
    );
  }
}
