import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/main.dart';
import 'package:front/screen/profile/profileMain.dart';

class secession extends StatefulWidget {
  const secession({Key? key}) : super(key: key);

  @override
  State<secession> createState() => _secessionState();
}

class _secessionState extends State<secession> {
  TextEditingController textarea = TextEditingController();
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profileMain()),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          '탈퇴신청',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text(
                "사유",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10.0,
              ),
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
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: "200자 이하 텍스트 입력 가능",
                        hintStyle: TextStyle(color: Color(0xFFC8C8CB)),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '*200자 내로 입력 가능합니다.',
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 21.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 56,
                child: CupertinoButton(
                  onPressed: () {
                    if (textarea.text.length > 200) {
                      _textover200(context);
                    } else {
                      _secession(context);
                    }
                  },
                  minSize: 0,
                  color: CupertinoDynamicColor.resolve(
                    CupertinoColors.systemBlue,
                    context,
                  ).withAlpha(0xFF4874EA),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Text(
                    '탈퇴',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 21.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _secession(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: Column(
        children: [
          Text(
            '탈퇴신청',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 12,
          ),
          Text('탈퇴 후 서비스 이용이 불가능 합니다.'),
          Text('탈퇴 하시겠습니까?'),
        ],
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          },
          child: const Text('확인'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('취소'),
        ),
      ],
    ),
  );
}

void _textover200(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: const Text('200자 이하로 입력해주세요'),
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
