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
  String appbarText = '자주 묻는 질문';
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
                            color: Color(0xFF3182F5),
                            fontSize: 20,
                              fontFamily: 'PretendardBold',
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${entries[index]}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'PretendardBold',
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
                                  fontFamily: 'PretendardRegular',
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
