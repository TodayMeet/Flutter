import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

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
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          '이용약관',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: null,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
