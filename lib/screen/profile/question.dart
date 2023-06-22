import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/screen/profile/profileMain.dart';
// import 'mainListView.dart';



class question extends StatefulWidget {
  const question({Key? key}) : super(key: key);

  @override
  State<question> createState() => _questionState();
}

class _questionState extends State<question> {
  String appbarText = '문의하기';
  TextEditingController textarea = TextEditingController();
  TextEditingController textarea1 = TextEditingController();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text('작성하신 문의 답변은 이메일 아이디 주소로 보내드립니다.\n답변까지 최대 2~3 일이 걸립니다.',
                  style: TextStyle(
                  fontSize: 14,
                ),),
              ),
              Text('제목',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6FA),
                  border: Border.all(
                    width: 1,
                    color: Color(0xFFF5F6FA),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    TextField(
                      controller: textarea,
                      decoration: InputDecoration(
                        hintText: "2자 이상 30자 이하 한글, 영문, 숫자 입력 가능",
                        hintStyle: TextStyle(color: Color(0xFFC8C8CB)),
                        border: InputBorder.none,
                      ),

                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.0,),
              Text('내용',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6FA),
                  border: Border.all(
                    width: 1,
                    color: Color(0xFFF5F6FA),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    TextField(
                      controller: textarea1,
                      maxLines: 14,
                      decoration: InputDecoration(
                        hintText: "500자 이하 텍스트 입력 가능",
                        hintStyle: TextStyle(color: Color(0xFFC8C8CB)),
                        border: InputBorder.none,
                      ),

                    ),
                  ],
                ),
              ),
              SizedBox(height: 21.0,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 56,
                child: CupertinoButton(
                  onPressed: () {
                    if(textarea1.text.length >500){
                      _textover500(context);
                    }else{
                      _question_confirm(context);
                    }

                  },
                  minSize: 0,

                  color: CupertinoDynamicColor.resolve(
                    CupertinoColors.systemBlue,
                    context,
                  ).withAlpha(0xFF4874EA),

                  borderRadius: BorderRadius.all(Radius.circular(10.0)),

                  child: Text(
                    '문의하기',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 21.0,),
            ],

          ),
        ),
      ),
    );
  }
}

void _question_confirm(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: const Text('문의 접수되었습니다'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text('확인'),
        ),
      ],
    ),
  );
}

void _textover500(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: const Text('500자 이하로 입력해주세요'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('확인'),
        ),
      ],
    ),
  );
}