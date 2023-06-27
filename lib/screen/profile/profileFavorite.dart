import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/screen/login/login.dart';
import 'package:front/screen/mainMap/mainPageMap.dart';

import 'package:flutter/material.dart';

import 'package:front/model/bottomBar.dart';
import 'package:front/screen/profile/profileMain.dart';

import '../../model/profile/CustomAppBar.dart';
import '../../model/svgbutton/svgbutton.dart';



class profileFavorite extends StatefulWidget {
  const profileFavorite({Key? key}) : super(key: key);

  @override
  State<profileFavorite> createState() => _profileFavoriteState();
}

class _profileFavoriteState extends State<profileFavorite> {
  final ScrollController _scrollController = ScrollController();
  final String appbarText = '관심사';
  String selectFavorite = '관심사를 최대 5개까지 골라 주세요';
  List<Map> categories = [
    {
      "name": "맛집",
      "isChecked": false,
      "image_color": "0xFFE91E63",
      "category_image": "assets/images/Category/CategoryRestaurant.png"
    },
    {
      "name": "카페",
      "isChecked": false,
      "image_color": "0xFFE91E63",
      "category_image": "assets/images/Category/CategoryCafe.png"
    },
    {
      "name": "주류",
      "isChecked": false,
      "image_color": "0xFF3F51B5",
      "category_image": "assets/images/Category/CategoryAlcohol.png"
    },
    {
      "name": "영화",
      "isChecked": false,
      "image_color": "0xFF673AB7",
      "category_image": "assets/images/Category/CategoryMovie.png"
    },
    {
      "name": "전시",
      "isChecked": false,
      "image_color": "0xFF607D8B",
      "category_image": "assets/images/Category/CategoryExhibition.png"
    },
    {
      "name": "공연",
      "isChecked": false,
      "image_color": "0xFF607D8B",
      "category_image": "assets/images/Category/CategoryPerformance.png"
    },
    {
      "name": "게임",
      "isChecked": false,
      "image_color": "0xFFFF5722",
      "category_image": "assets/images/Category/CategoryGame.png"
    },
    {
      "name": "봉사",
      "isChecked": false,
      "image_color": "0xFF8BC34A",
      "category_image": "assets/images/Category/CategoryService.png"
    },
    {
      "name": "독서",
      "isChecked": false,
      "image_color": "0xFF374046",
      "category_image": "assets/images/Category/CategoryRead.png"
    },
    {
      "name": "스터디",
      "isChecked": false,
      "image_color": "0xFF9C27B0",
      "category_image": "assets/images/Category/CategoryStudy.png"
    },
    {
      "name": "반려동물",
      "isChecked": false,
      "image_color": "0xFF795548",
      "category_image": "assets/images/Category/CategoryPet.png"
    },
    {
      "name": "운동",
      "isChecked": false,
      "image_color": "0xFFDCA966",
      "category_image": "assets/images/Category/CategorySports.png"
    },
  ];
  Color textColor = Color(0xff2f3036);
  String backarrow = 'assets/images/ProfileImage/backarrow.svg';
  @override
  Widget build(BuildContext context) {

    int checkedCount =
        categories.where((category) => category["isChecked"]).length;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed:() {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profileMain()));},
        ),
        title: appbarText,
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: ListView(controller: _scrollController, children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 8.0, 5.0),
            height: 20,
            alignment: Alignment.centerLeft,
            child: Text(selectFavorite,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: textColor)),
          ),
          Column(
            // 카테고리
            crossAxisAlignment: CrossAxisAlignment.center,
            children: categories.map((category) {
              return Container(
                margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),//전체 테두리
                  color: const Color(0xFFF7F8FA),
                ),
                child: CheckboxListTile(
                  checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  value: category["isChecked"],
                  onChanged: (newValue) {
                    setState(() {
                      category["isChecked"] = newValue;
                    });
                  },
                  title: Text(category["name"],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15)),
                  secondary: Container(
                    alignment: Alignment.center,
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(int.parse(category["image_color"])),
                    ),
                    child: Image.asset(
                      category["category_image"],
                      scale: 4,
                    ),
                  ),
                  isThreeLine: false,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 52,
              child: CupertinoButton(
                onPressed: () {
                  if (checkedCount > 5) {
                    _overFive(context);
                  } else {

                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (BuildContext context) =>
                            profileMain()), (route) => false);
                  }
                },
                minSize: 0,
                padding: EdgeInsets.symmetric(),
                color: CupertinoDynamicColor.resolve(
                  CupertinoColors.systemBlue,
                  context,
                ).withAlpha(0xFF4874EA),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Text(
                  '저장하기',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.0),
        ]),
      ),
    );
  }
}

void _overFive(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: const Text('5개 이하로 선택해주세요'),
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
