
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/model/UI/widget/button/WhiteButton.dart';
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
import '../../model/bottomBar.dart';



class profileMain extends StatefulWidget {
  const profileMain({Key? key}) : super(key: key);

  @override
  State<profileMain> createState() => _profileMainState();
}

class _profileMainState extends State<profileMain> {
  final ScrollController _scrollController = ScrollController();
  String myprofileImage = 'assets/images/ProfileImage/avatarIcon1.svg';
  String name = '이름';
  String gender = '성별';
  String birthdate = '2000.03.13';

  int follower = 100;
  int following = 100;
  final List<Map<String, dynamic>> menu = [
    {"name": '개최한 건수', 'goto': hostEvent()},
    {"name": '참가한 건수', 'goto': joinEvent()},
    {"name": '비밀번호 변경', 'goto': pwChange()},
    {"name": '차단 관리', 'goto': blockManage()},
    {"name": '관심사', 'goto': profileFavorite()},
    {"name": 'FAQ', 'goto': oftenQuestion()},
    {"name": '문의하기', 'goto': question()},
    {"name": '공지사항', 'goto': noticeList()},
    {"name": '개인정보처리방침', 'goto': privatePolicy()},
    {"name": '이용약관', 'goto': termsofUse()},

  ];
  secession secessionroute = secession();
  String versionText = 'V 1.0.0';


  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    // 새로고침 작업 수행
    await Future.delayed(Duration(seconds: 1));

    // 화면 갱신
    setState(() {});
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
            onPressed: () {
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
              profileMainTop(myprofileImage: myprofileImage, name: name, gender: gender, birthdate: birthdate, profileEditButtonRoute: profileEdit()),
              //myprofileImage : 내정보 내이미지
              //name : 내정보 이름
              //gender : 내정보 성
              //birthdate : 내정보 생년월일 2000.03.01
              //proflieEditButtonRoute : 프로필 수정 버튼 클릭 시 이동하게 되는 경로
              profileMainMiddle(follower: follower, following: following), //팔로워 팔로잉
              //follwer , following숫자 textbutton
              profileMainBottom(menu: menu, secessionroute: secessionroute, versionText: versionText), //메뉴
              //메뉴(개최한 건수 등등), 탈퇴신청 버튼, 버전 확인칸 총 두 가지로 이루어짐
            ],
          ),
        ),
        bottomNavigationBar: const BottomAppBar(child: BottomBar()),
      ),
    );
  }
}




class profileMainTop extends StatelessWidget {
  const profileMainTop({
    super.key,
    required this.myprofileImage,
    required this.name,
    required this.gender,
    required this.birthdate,
    required this.profileEditButtonRoute,
  });

  final String myprofileImage;
  final String name;
  final String gender;
  final String birthdate;
  final profileEdit profileEditButtonRoute;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      child: Row(
        children: [
          profileImage(myprofileImage: myprofileImage),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  nameGender(name: name, gender: gender),
                  SizedBox(
                    width: 8.0,
                  ),
                  birthDate(birthdate: birthdate),
                ],
              ),
              SizedBox(
                height: 11,
              ),
              profileEditButton(profileEditButtonRoute: profileEditButtonRoute)
            ],
          ),
        ],
      ),
    );
  }
}
  class profileImage extends StatelessWidget {
  const profileImage({
    super.key,
    required this.myprofileImage,
  });

  final String myprofileImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
        child: Image.asset('assets/images/User_Picture/User_pic_sample4.png',fit: BoxFit.fill,));
  }
}
  class nameGender extends StatelessWidget {
  const nameGender({
    super.key,
    required this.name,
    required this.gender,
  });

  final String name;
  final String gender;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${name}(${gender})',
      style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.w700),
    );
  }
}
  class birthDate extends StatelessWidget {
  const birthDate({
    super.key,
    required this.birthdate,
  });

  final String birthdate;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${birthdate} ',
      style: TextStyle(
        color: Color(0xFF1F2024),
        fontSize: 12,
      ),
    );
  }
}
  class profileEditButton extends StatelessWidget {
  const profileEditButton({
    super.key,
    required this.profileEditButtonRoute,
  });

  final profileEdit profileEditButtonRoute;

  @override
  Widget build(BuildContext context) {
    return whiteButton(
      buttonText: '프로필 수정',
      onPressed: (){
        Navigator.push(context,  MaterialPageRoute(
            builder: (context) => profileEdit()));
    },
      icon: true,
      width: MediaQuery.of(context).size.width - 158,

    );
  }
}

class profileMainMiddle extends StatelessWidget {
  const profileMainMiddle({
    super.key,
    required this.follower,
    required this.following,
  });

  final int follower;
  final int following;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                followerNumberButton(follower: follower)
              ],
            ),
          ),//팔로워

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
                followingNumberButton(following: following)
              ],
            ),
          ),//팔로잉
        ],
      ),
    );
  }
}
  class followerNumberButton extends StatelessWidget {
  const followerNumberButton({
    super.key,
    required this.follower,
  });

  final int follower;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => followList()));
      },
      child: Text(
        follower.toString(),
        style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2024)),
      ),
    );
  }
}
  class followingNumberButton extends StatelessWidget {
  const followingNumberButton({
    super.key,
    required this.following,
  });

  final int following;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => followList()));
      },
      child: Text(
        following.toString(),
        style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2024)),
      ),
    );
  }
}

class profileMainBottom extends StatelessWidget {
  const profileMainBottom({
    super.key,
    required this.menu,
    required this.secessionroute,
    required this.versionText,
  });

  final List<Map<String, dynamic>> menu;
  final secession secessionroute;
  final String versionText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          profileMenu(menu: menu), //메뉴

          secessionButton(secessionroute: secessionroute), //탈퇴신청
          version(versionText: versionText), //버전확인

        ],
      ),
    );
  }
}
  class profileMenu extends StatelessWidget {
  const profileMenu({
    super.key,
    required this.menu,
  });

  final List<Map<String, dynamic>> menu;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
            padding: const EdgeInsets.only(left: 8 ),
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
                SvgButton(imagePath: fowardarrow, onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => item['goto'],
                    ),
                  );
                },width: 16,height: 16,)
              ],
            ),
          ),
        );
      },
    );
  }
}
  class secessionButton extends StatelessWidget {
  const secessionButton({
    super.key,
    required this.secessionroute,
  });

  final secession secessionroute;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          ),
            onPressed: () {


              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => secessionroute),
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
    );
  }
}
  class version extends StatelessWidget {
  const version({
    super.key,
    required this.versionText,
  });

  final String versionText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
      child: Center(
        child: Text(
          versionText,
          style: const TextStyle(
              color: Color(0xFFA7A8A9),
              fontSize: 14.0,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

















