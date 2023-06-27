// 카테고리 선택 위젯

// 최종 수정일 : 2023.6.23
// 작업자 : 김혁

// 추가 작업 예정 사항

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    {"name": "맛집", "isChecked": false, "image_color": "0xFFE91E63", "categoryNo": 0,
      "category_image": "assets/images/Category/Restaurant.svg"},
    {"name": "카페", "isChecked": false, "image_color": "0xFFE91E63", "categoryNo": 1,
      "category_image": "assets/images/Category/Cafe.svg"},
    {"name": "주류", "isChecked": false, "image_color": "0xFF3F51B5", "categoryNo": 2,
      "category_image": "assets/images/Category/Alcohol.svg"},
    {"name": "영화", "isChecked": false, "image_color": "0xFF673AB7", "categoryNo": 3,
      "category_image": "assets/images/Category/Movie.svg"},
    {"name": "전시", "isChecked": false, "image_color": "0xFF607D8B", "categoryNo": 4,
      "category_image": "assets/images/Category/Exhibition.svg"},
    {"name": "공연", "isChecked": false, "image_color": "0xFF607D8B", "categoryNo": 5,
      "category_image": "assets/images/Category/Performance.svg"},
    {"name": "게임", "isChecked": false, "image_color": "0xFFFF5722", "categoryNo": 6,
      "category_image": "assets/images/Category/Game.svg"},
    {"name": "봉사", "isChecked": false, "image_color": "0xFF8BC34A", "categoryNo": 7,
      "category_image": "assets/images/Category/Service.svg"},
    {"name": "독서", "isChecked": false, "image_color": "0xFF374046", "categoryNo": 8,
      "category_image": "assets/images/Category/Read.svg"},
    {"name": "스터디", "isChecked": false, "image_color": "0xFF9C27B0", "categoryNo": 9,
      "category_image": "assets/images/Category/Study.svg"},
    {"name": "반려동물", "isChecked": false, "image_color": "0xFF795548", "categoryNo": 10,
      "category_image": "assets/images/Category/Pet.svg"},
    {"name": "운동", "isChecked": false, "image_color": "0xFFDCA966", "categoryNo": 11,
      "category_image": "assets/images/Category/Sports.svg"},
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
          margin: const EdgeInsets.fromLTRB(24, 10, 24, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: const Color(0xFFF7F8FA),
          ),
          child: CheckboxListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            activeColor: const Color(0xFF5881EB),
            tileColor: Colors.white,
            checkboxShape: const CircleBorder(
              side: BorderSide(
                width: 2,
                color: Color(0xFFD8D8DC),
              )
            ),
            value: category["isChecked"],
            onChanged: (newValue){
              setState(() {
                category["isChecked"] = newValue;
                meetInfo.categoryNo = category["categoryNo"];
              });
              categoryText = category["name"];
              categoryChange();
            },
            title: Text(category["name"],
              style: const TextStyle(
                color: Color(0xFF1F2024),
                fontWeight: FontWeight.w700,
                fontSize: 16)
            ),
            secondary: Container(
              alignment: Alignment.center,
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(int.parse(category["image_color"])),
              ),
              child: SvgPicture.asset(
                category["category_image"]
              ),
            ),
            isThreeLine: false,
          ),
        );
      }).toList(),
    ): Container(
      margin: const EdgeInsets.fromLTRB(24, 10, 24, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        border: Border.all(
            color: const Color(0xFFC5C6CC),
            width: 1
        ),
      ),
      child: TextButton(
        style: const ButtonStyle(
          padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.all(16)
          )
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(categoryText,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize:14,
                  color: Color(0xFF2F3036),
                  letterSpacing: -0.5,
              )
          ),
        ),
        onPressed: () {
          categoryChange();
        },
      ),
    );
  }
}
