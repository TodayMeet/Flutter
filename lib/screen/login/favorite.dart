import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/model/dialogEx/dialoglist.dart';
import 'package:front/model/profile/bluebutton.dart';
import 'package:front/screen/login/login.dart';
import 'package:front/screen/mainMap/mainPageMap.dart';
import 'package:flutter/material.dart';
import 'package:front/model/bottomBar.dart';
import '../../data/designconst/constants.dart';
import '../../model/profile/CustomAppBar.dart';
import '../../model/svgbutton/svgbutton.dart';


class favorite extends StatefulWidget {
  const favorite({Key? key}) : super(key: key);

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
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
  String buttonText = '시작하기';
  String appbarText = '관심사';
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
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => login()));
          },
        ),
        title: appbarText,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Scrollbar(
          controller: _scrollController,
          child: ListView(controller: _scrollController, children: [
            Text("관심사를 최대 5개까지 골라 주세요",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xff2f3036))),
            SizedBox(height: 8,),
            Column(
              // 카테고리
              crossAxisAlignment: CrossAxisAlignment.center,
              children: categories.map((category) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
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
                      child: ClipOval(
                          child: Image.asset(
                        category["category_image"],
                            scale: 3,
                            fit: BoxFit.cover,
                      )),
                    ),
                    isThreeLine: false,
                  ),
                );
              }).toList(),
            ),
            Spacer(),
            blueButton(buttonText: buttonText, onPressed: (){
             if (checkedCount > 5) {
               onebutton.overFive(context);
             } else {
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                   builder: (BuildContext context) =>
                       login()), (route) => false);
             }
           }),

          ]),
        ),
      ),
    );
  }
}

