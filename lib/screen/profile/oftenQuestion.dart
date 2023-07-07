import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:front/screen/profile/profileMain.dart';
import '../../data/designconst/constants.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';

// import 'mainListView.dart';

class oftenQuestion extends StatefulWidget {
  const oftenQuestion({Key? key}) : super(key: key);

  @override
  State<oftenQuestion> createState() => _oftenQuestionState();
}

class _oftenQuestionState extends State<oftenQuestion> {
  String question = '';
  String answer = '';
  int faqno = 0;
  List<Map> finalresult = [];

  Future<void> questionLoad() async {
    final url = Uri.parse('http://todaymeet.shop:8080/FAQ/list');
    final requestData = {
      'question' : question,
      'answer' : answer,
      'faqno' : faqno
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url,
      // body: jsonData,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      List<Map<String, dynamic>> mappedList = result.cast<Map<String, dynamic>>().toList();
      mappedList.forEach((item) {
        item["ischecked"] = false;
      });
      finalresult = mappedList;
      List<bool> index = List<bool>.filled(finalresult.length, false);
      setState(() {
        finalresult = mappedList;
      });

    }
  } //서버로 전송

  @override
  void initState() {
    super.initState();
    questionLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed: () {
            // questionLoad();
            Navigator.pop(context);
          },
        ),
        title: '자주 묻는 질문',
      ),
      body: ListView.builder(
        itemCount: finalresult.length,
        itemBuilder: (BuildContext context, int index) {
          final faq = finalresult[index];
          return Column(
            children: [
              ListTile(
                onTap: () {
                  setState(() {
                    faq['ischecked'] = !faq['ischecked'];
                    print(finalresult.length);
                  });
                },
                title: Row(
                  children: [
                    Text(
                      "Q",
                      style: TextStyle(
                          color: Color(0xFF3182F5),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '${faq['question']}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith<Color>((states) => Colors.transparent),
                      ),
                      onPressed: () {
                        setState(() {
                          faq['ischecked'] = !faq['ischecked'];
                        });
                      },
                      child: Text(
                        faq['ischecked'] ? '' : '',
                        style: TextStyle(
                          fontFamily: 'xeicon',
                          color: Colors.black,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (faq['ischecked'])
                Container(
                  color: Color(0xFFF4F4F4),
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          "A",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            '${faq['answer']}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          );
        },
      ),

    );
  }
}
