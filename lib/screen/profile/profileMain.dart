import 'dart:convert';
import 'package:front/screen/chat/chatlist.dart';
import 'package:front/screen/profile/userProfile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/model/UI/widget/button/WhiteButton.dart';
import '../../data/userNo.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';
import '../../screen/dialog/dialoglist.dart';
import '../../screen/profile/blockManage.dart';
import '../../screen/profile/followList.dart';
import '../../screen/profile/hostEvent.dart';
import '../../screen/profile/joinEvent.dart';
import '../../screen/profile/noticeList.dart';
import '../../screen/profile/oftenQuestion.dart';
import '../../screen/profile/profileEdit.dart';
import '../../screen/profile/profileFavorite.dart';
import '../../screen/profile/pwChange.dart';
import '../../screen/profile/question.dart';
import '../../screen/profile/secession.dart';
import '../../screen/profile/termsofUse.dart';
import '../../data/designconst/constants.dart';

class profileMain extends StatefulWidget {
  //불러와야할 정보
  //username
  //gender -> 아마 int값
  //프로필 이미지
  //birthdate -> 이거 근데 입력 안했을때는 안띄워야하는건가
  // final int userNo;

  // profileMain({required this.userNo});
  const profileMain({Key? key}) : super(key: key);

  @override
  State<profileMain> createState() => _profileMainState();
}

class _profileMainState extends State<profileMain> {
  final ScrollController _scrollController = ScrollController();


  
  String versionText = 'V 1.0.0';

  int userNo = UserNo.myuserNo;
  String username = ' ';
  int follownum = 0;
  int followeenum = 0;
  int gender = 0;
  String genderString = '';
  String birth = '';
  String userprofileimage = '';
  List<int> followNoList = [];




  Future<void> followingLoad() async {
    final url = Uri.parse('http://todaymeet.shop:8080/follow/list?userNo=${userNo}');
    print('foloowingLoad의 userNo입니다============================${userNo}');

    final requestData = {
      "userNo": userNo,
      "userProfileImage":  userprofileimage,
      "username": username
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final responseData2 = jsonDecode(response.body);
      followNoList = responseData2.map<int>((user) => user['userNo'] as int).toSet().toList();
    } else {}
  }//팔로잉 정보 불러오기

  Future<void> myInfoLoad() async {
    final url = Uri.parse('http://todaymeet.shop:8080/user-profile/${userNo}');

    final requestData = {
      'userNo': userNo,
      'username': username,
      'follownum': follownum,
      'followeenum': followeenum,
      'gender': gender,
      'birth': birth,
      'userprofileimage': userprofileimage
    };
    final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      setState(() {
        userNo = responseData['userNo'];
        userprofileimage = responseData['userProfileImage'];
        username = responseData['username'];
        birth = (responseData['birth'].substring(0,10)).replaceAll('-', '.');

        if (responseData['gender'] == 1) {
          genderString = '(남)';
        } else if (responseData['gender'] == 2) {
          genderString = '(여)';
        }
        follownum = responseData['followNum'];
        followeenum = responseData['followeeNum'];
        print(responseData);
        menu.clear();
        menu.addAll([
          {"name": '개최한 건수', 'goto': hostEvent(userNo: userNo)},
          {"name": '참가한 건수', 'goto': joinEvent(userNo: userNo)},
          {"name": '비밀번호 변경', 'goto': pwChange()},
          {"name": '차단 관리', 'goto': blockManage()},
          {
            "name": '관심사',
            'goto': profileFavorite(
              userNo: userNo,
            )
          },
          {"name": 'FAQ', 'goto': oftenQuestion()},
          {"name": '문의하기', 'goto': question()},
          {"name": '공지사항', 'goto': noticeList()},
          {"name": '개인정보처리방침', 'goto': privatePolicy()},
          {"name": '이용약관', 'goto': termsofUse()},
          {"name": '채팅임시', 'goto': chatlist()},

        ]);
      });
    } else {}
  }



  //사용자 정보 불어오기

  // final List<Map<String, dynamic>> menu = [
  //   {"name": '개최한 건수', 'goto': hostEvent(userNo: 1)},
  //   {"name": '참가한 건수', 'goto': joinEvent(userNo: 1)},
  //   {"name": '비밀번호 변경', 'goto': pwChange()},
  //   {"name": '차단 관리', 'goto': blockManage()},
  //   {
  //     "name": '관심사',
  //     'goto': profileFavorite(
  //       userNo: 1,
  //     )
  //   },
  //   {"name": 'FAQ', 'goto': oftenQuestion()},
  //   {"name": '문의하기', 'goto': question()},
  //   {"name": '공지사항', 'goto': noticeList()},
  //   {"name": '개인정보처리방침', 'goto': privatePolicy()},
  //   {"name": '이용약관', 'goto': termsofUse()},
  //   {"name": '채팅임시', 'goto': chatlist()},
  //   {"name": '사용자프로필', 'goto': userProfile()},
  //   {
  //     "name": '팔로우리스트',
  //     'goto': followList(
  //       username: 'asdf',
  //     )
  //   },
  // ];







  final List<Map<String, dynamic>> menu = [];
  @override
  void initState() {
    super.initState();
    myInfoLoad();
    // followingLoad();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: CustomAppBar(
          title: '내정보',
          leadingWidget: null,
          automaticallyImplyLeading: false,
          actionWidget: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(Color(0xFFDDDDDD)),
            ),
            onPressed: () async {
              // print(userNo);
              // await followingLoad();
              // print(followNoList);
              twobutton.logoutDialog(context);

            },
            child: Text(
              '로그아웃',
              style: TextStyle(
                  color: Color(0xFFA7A8A9),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ), //Appbar
        body: Scrollbar(
          controller: _scrollController,
          child: ListView(
            // controller: _scrollController,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 70,
                        height: 70,
                        color: Colors.blue,
                        child: Image.network(userprofileimage)
                      ),
                    ),

                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${username}${genderString}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              birth,
                              style: TextStyle(
                                color: Color(0xFF1F2024),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 11,
                        ),
                        whiteButton(
                          buttonText: '프로필 수정',
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => profileEdit()));
                          },
                          icon: true,
                          width: MediaQuery.of(context).size.width - 158,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0xFFCACACA),
                            width: 0.5,
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '팔로워',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12.0,
                                color: Color(0xFFA7A8A9)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => followList(username: username,userNo: userNo,)));
                            },
                            child: Text(
                              follownum.toString(),
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1F2024)),
                            ),
                          )
                        ],
                      ),
                    ), //팔로워

                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0xFFCACACA),
                            width: 0.5,
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '팔로잉',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12.0,
                                color: Color(0xFFA7A8A9)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => followList(username: username,userNo: userNo,)));
                            },
                            child: Text(
                              followeenum.toString(),
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1F2024)),
                            ),
                          )
                        ],
                      ),
                    ), //팔로잉
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: menu.length,
                      itemBuilder: (context, index) {
                        final item = menu[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => item['goto'],
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 8),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: const BorderSide(
                                    color: const Color(0xFFE3E3E3), width: 1.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                SvgButton(
                                  imagePath: fowardarrow,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => item['goto'],
                                      ),
                                    );
                                  },
                                  width: 16,
                                  height: 16,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),//메뉴

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            style: ButtonStyle(
                              overlayColor:
                              MaterialStateProperty.all<Color>(Colors.transparent),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => secession(userNo: userNo)),
                              );
                            },
                            child: const Text(
                              '탈퇴신청',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFA7A8A9)),
                            )),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      child: Center(
                        child: Text(
                          versionText,
                          style: const TextStyle(
                              color: Color(0xFFA7A8A9),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//필요한 함수 정리
// 사용자 정보 불러오기, username, gender, birthdate, userimage
// 팔로우 리스트 불러오기
// 팔로잉 리스트 불러오기
