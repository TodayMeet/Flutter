import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/screen/mainMap/mainPageMap.dart';


import 'package:flutter/material.dart';

import 'package:front/model/bottomBar.dart';

import 'accountsetting.dart';

class favorite extends StatefulWidget {
  const favorite({Key? key}) : super(key: key);

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  final ScrollController _scrollController = ScrollController();

  List<Map> categories = [
    {"name": "맛집", "isChecked": false, "image_color": "0xFFE91E63",
      "category_image": "assets/images/Category/CategoryRestaurant.png"},
    {"name": "카페", "isChecked": false, "image_color": "0xFFE91E63",
      "category_image": "assets/images/Category/CategoryCafe.png"},
    {"name": "주류", "isChecked": false, "image_color": "0xFF3F51B5",
      "category_image": "assets/images/Category/CategoryAlcohol.png"},
    {"name": "영화", "isChecked": false, "image_color": "0xFF673AB7",
      "category_image": "assets/images/Category/CategoryMovie.png"},
    {"name": "전시", "isChecked": false, "image_color": "0xFF607D8B",
      "category_image": "assets/images/Category/CategoryExhibition.png"},
    {"name": "공연", "isChecked": false, "image_color": "0xFF607D8B",
      "category_image": "assets/images/Category/CategoryPerformance.png"},
    {"name": "게임", "isChecked": false, "image_color": "0xFFFF5722",
      "category_image": "assets/images/Category/CategoryGame.png"},
    {"name": "봉사", "isChecked": false, "image_color": "0xFF8BC34A",
      "category_image": "assets/images/Category/CategoryService.png"},
    {"name": "독서", "isChecked": false, "image_color": "0xFF374046",
      "category_image": "assets/images/Category/CategoryRead.png"},
    {"name": "스터디", "isChecked": false, "image_color": "0xFF9C27B0",
      "category_image": "assets/images/Category/CategoryStudy.png"},
    {"name": "반려동물", "isChecked": false, "image_color": "0xFF795548",
      "category_image": "assets/images/Category/CategoryPet.png"},
    {"name": "운동", "isChecked": false, "image_color": "0xFFDCA966",
      "category_image": "assets/images/Category/CategorySports.png"},
  ];

  List<bool> isSelected1 = [true];
  List<bool> isSelected2 = [false];
  List<bool> isSelected3 = [false];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text('관심사',
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'PretendardBold')),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainPageMap()));
            },
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: ListView(
            controller: _scrollController,
            children:[
              Container(
                margin: const EdgeInsets.fromLTRB(20.0, 20.0, 8.0, 5.0),
                height: 20,
                alignment: Alignment.centerLeft,
                child: const Text("관심사를 최대 5개까지 골라 주세요", style: TextStyle(fontFamily:"PretendardBold",
                    fontSize: 14, color: Color(0xff2f3036))),
              ),
              Column( // 카테고리
                crossAxisAlignment: CrossAxisAlignment.center,
                children: categories.map((category){
                  return Container(
                    margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xFFF7F8FA),
                    ),
                    child: CheckboxListTile(
                      checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      value: category["isChecked"],
                      onChanged: (newValue){
                        setState(() {
                          category["isChecked"] = newValue;
                        });
                      },
                      title: Text(category["name"],style: const TextStyle(fontFamily: "PretendardBold",
                          fontSize: 15)),
                      secondary: Container(
                        alignment: Alignment.center,
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(int.parse(category["image_color"])),
                        ),
                        child: Image.asset(category["category_image"]),
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
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainPageMap()));},
                    minSize: 0,
                    padding: EdgeInsets.symmetric(),
                    color: CupertinoDynamicColor.resolve(
                      CupertinoColors.systemBlue,
                      context,
                    ).withAlpha(0xFF4874EA),

                    borderRadius: BorderRadius.all(Radius.circular(10.0)),

                    child: Text(
                      '다음',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.0),

            ]
        ),
      ),

    );
  }
}
