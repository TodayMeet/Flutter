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
  List<bool> isExpandedList = [];
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
      print('aaaaa');
      print(result);
      print('========');


      List<Map<String, dynamic>> mappedList = result.cast<Map<String, dynamic>>().toList();
      finalresult = mappedList;

      isExpandedList = List<bool>.generate(mappedList.length, (index) => false);
      print('finalresult');
      print(finalresult);

      // print('asdff');
      // print(isExpandedList);
      // questionList = finalresult.map((item) => item['question'] as String).toList();
      // answerList = finalresult.map((item) => item['answer'] as String).toList();
      // faqList = finalresult.map((item) => item['faq'] as int).toList();
      // print(questionList);

      // return answer;
    } else {
      print('처음부터 다시해보는게 어떨까: ${response.statusCode}');

      // return [];
    }
  } //서버로 전송


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed: () {
            questionLoad();
            // Navigator.pop(context);
          },
        ),
        title: '자주 묻는 질문',
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: finalresult.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    setState(() {
                      isExpandedList[index] = !isExpandedList[index];
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
                        '${index}',
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
                              isExpandedList[index] = !isExpandedList[index];
                            });
                          },
                          child: Text(
                            isExpandedList[index]
                                ? ''
                                : '',
                            style: TextStyle(
                              fontFamily: 'xeicon',
                              color: Colors.black,
                              fontSize: 22.0,
                            ),
                          )),

                    ],
                  ),
                ),
                if (isExpandedList[index])
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
                              'aaa',
                              // '${finalresult[faqno][answer]}',
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
          }),
    );
  }
}
