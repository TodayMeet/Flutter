// 카테고리 선택 위젯

// 최종 수정일 : 2023.5.28
// 작업자 : 김혁

// 추가 작업 예정 사항

import 'package:flutter/material.dart';

import '../setting/registerMeeting.dart';

class MeetingCategory extends StatefulWidget {
  const MeetingCategory({Key? key}) : super(key: key);

  @override
  State<MeetingCategory> createState() => _MeetingCategoryState();
}

class _MeetingCategoryState extends State<MeetingCategory> {
  bool enabled = true;
  String categoryText = "";

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

  void categoryChange(){
    setState(() {
      if(enabled){
        enabled = false;
      }else{
        for(var i = 0; i < 12; i++) {
          categories[i]["isChecked"] = false;
        }
        enabled = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return enabled? Column(                   // 카테고리
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
                meetInfo.categoryName = category["name"];
              });
              categoryText = category["name"];
              categoryChange();
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
              child: Image.asset(category["category_image"], scale: 4),
            ),
            isThreeLine: false,
          ),
        );
      }).toList(),
    ): Container(
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: TextButton(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(categoryText,
              style: const TextStyle(
                  fontFamily: "PretendardBold",
                  fontSize:15,
                  color: Color(0xFF2F3036))
          ),
        ),
        onPressed: () {
          categoryChange();
        },
      ),
    );
  }
}
