import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

import '../../model/UI/widget/customAppBar.dart';

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
