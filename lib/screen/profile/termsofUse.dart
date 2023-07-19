//이용약관

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
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
