import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:front/screen/profile/notice.dart';
import 'package:front/screen/profile/profileMain.dart';

import '../../data/designconst/constants.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';

// import 'mainListView.dart';

class noticeList extends StatefulWidget {
  const noticeList({Key? key}) : super(key: key);

  @override
  State<noticeList> createState() => _noticeListState();
}

class _noticeListState extends State<noticeList> {
  List<String> entries = <String>[
    '업데이트 안내드립니다.',
    '업데이트 안내드립니다.',
    '업데이트 안내드립니다.',
    '업데이트 안내드립니다.',
    '업데이트 안내드립니다.'
  ];
  List<String> entries1 = <String>[
    'googlelogin',
    'kakao_login_large_wide',
    'logoimage',
    'naverlogin',
    'titleimage'
  ];
  String appbarText = '공지사항';
  int year = 2022;
  int month = 6;
  int day = 15;
  // DateTime uploadDate = DateTime(year,month,day);

  String imageIcon = 'assets/images/ProfileImage/Image.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => profileMain()));
          },
        ),
        title: appbarText,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => notice(),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6FA),
                          shape: BoxShape.circle,
                        ),
                        width: 50,
                        height: 50,
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/Image.svg',
                            width: 22,
                            height: 22,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${entries[index]}',
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '2022.06.15',
                            style: TextStyle(
                                color: Color(0xFF71727A), fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
