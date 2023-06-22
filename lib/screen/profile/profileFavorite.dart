import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/screen/login/login.dart';
import 'package:front/screen/mainMap/mainPageMap.dart';

import 'package:flutter/material.dart';

import 'package:front/model/bottomBar.dart';
import 'package:front/screen/profile/profileMain.dart';



class proflieFavorite extends StatefulWidget {
  const proflieFavorite({Key? key}) : super(key: key);

  @override
  State<proflieFavorite> createState() => _proflieFavoriteState();
}

class _proflieFavoriteState extends State<proflieFavorite> {
  final ScrollController _scrollController = ScrollController();

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
  @override
  Widget build(BuildContext context) {
    String appbarText = '관심사';
    int checkedCount =
        categories.where((category) => category["isChecked"]).length;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
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
          style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.w700),
        ),

        centerTitle: true,
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: ListView(controller: _scrollController, children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 8.0, 5.0),
            height: 20,
            alignment: Alignment.centerLeft,
            child: const Text("관심사를 최대 5개까지 골라 주세요",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xff2f3036))),
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
                    width: 30,
                    height: 30,
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
              height: 56,
              child: CupertinoButton(
                onPressed: () {
                  if (checkedCount > 5) {
                    _overFive(context);
                  } else {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (BuildContext context) =>
                            login()), (route) => false);
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
                      fontFamily: 'PretendardBold',
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
