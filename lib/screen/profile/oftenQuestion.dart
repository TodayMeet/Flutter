import 'package:flutter/material.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/screen/profile/profileMain.dart';
// import 'mainListView.dart';

class oftenQuestion extends StatefulWidget {
  const oftenQuestion({Key? key}) : super(key: key);

  @override
  State<oftenQuestion> createState() => _oftenQuestionState();
}

class _oftenQuestionState extends State<oftenQuestion> {
  List<String> entries = <String>[
    '건수 등록은 어떻게 하나요?',
    '건수 등록은 어떻게 하나요?',
    '건수 등록은 어떻게 하나요?',
    '건수 등록은 어떻게 하나요?'
  ];
  List<String> entries1 = <String>[
    '네비게이션바 가운데 버튼을 누르면 건수를 등록 할 수 있습니다 . 등록 절차에 따라 건수를 입력하시면 새로운 건수 등록이 완료됩니다.',
    '건수 등록은 어떻게 하나요?',
    '건수 등록은 어떻게 하나요?',
    '건수 등록은 어떻게 하나요?'
  ];
  List<int> qindex = <int>[1, 2, 3, 4];
  List<bool> isExpandedList = List<bool>.generate(4, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          '자주 묻는 질문',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: null,
        centerTitle: true,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(
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
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${entries[index]}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isExpandedList[index] = !isExpandedList[index];
                            });
                          },
                          icon: Icon(
                            isExpandedList[index]
                                ? Icons.expand_less
                                : Icons.expand_more,
                          ),
                        ),
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
                                '${entries1[index]}',
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
              ),
            );;
          }),
    );
  }
}
