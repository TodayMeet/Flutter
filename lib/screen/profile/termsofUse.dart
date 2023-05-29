import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:front/screen/profile/profileMain.dart';





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
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);

        },
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,)),
        title: Text(
          '이용약관',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600
          ),
        ),
        actions: null,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0,horizontal: 24.0),
          child: Center(
            child: Text(text),
          ),
        ),
      ),

    );
  }

}
