import 'package:flutter/material.dart';

import 'package:front/model/bottomBar.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
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
        title: const Text('필터',
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
                height: 50,
                alignment: Alignment.centerLeft,
                child: const Text("카테고리", style: TextStyle(fontFamily:"PretendardBold",
                    fontSize: 13, color: Color(0xff2f3036))),
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
              Container(
                margin: const EdgeInsets.fromLTRB(20.0, 20.0, 8.0, 10.0),
                height: 50,
                alignment: Alignment.centerLeft,
                child: const Text("정렬", style: TextStyle(fontFamily: "PretendardBold",
                    fontSize: 13, fontWeight: FontWeight.bold)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ToggleButtons(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    selectedBorderColor: const Color(0xFF5B5B5B),
                    selectedColor: const Color(0xFF000000),
                    borderColor: const Color(0xFFDBDBDB),
                    color: const Color(0xFF707070),
                    textStyle: const TextStyle(fontFamily: "PretendardBold"),
                    fillColor: const Color(0xFFFFFFFF),
                    splashColor: const Color(0xFFFFFFFF),
                    constraints: BoxConstraints.expand(
                      width: size.width * 0.3,
                    ),
                    isSelected: isSelected1,
                    onPressed: (int index){
                      setState(() {
                        isSelected1[index] = true;
                        isSelected2[index] = false;
                        isSelected3[index] = false;
                      });
                    },
                    children:[
                      Container(
                          alignment: Alignment.center,
                          child: const Text("최신순")),
                    ],
                  ),
                  ToggleButtons(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    selectedBorderColor: const Color(0xFF5B5B5B),
                    selectedColor: const Color(0xFF000000),
                    borderColor: const Color(0xFFDBDBDB),
                    color: const Color(0xFF707070),
                    textStyle: const TextStyle(fontFamily: "PretendardBold"),
                    fillColor: const Color(0xFFFFFFFF),
                    splashColor: const Color(0xFFFFFFFF),
                    constraints: BoxConstraints.expand(
                      width: size.width * 0.3,
                    ),
                    isSelected: isSelected2,
                    onPressed: (int index){
                      setState(() {
                        isSelected1[index] = false;
                        isSelected2[index] = true;
                        isSelected3[index] = false;
                      });
                    },
                    children: [
                      Container(
                          alignment: Alignment.center,
                          child: const Text("마감 임박 순")),
                    ],
                  ),
                  ToggleButtons(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    selectedBorderColor: const Color(0xFF5B5B5B),
                    selectedColor: const Color(0xFF000000),
                    borderColor: const Color(0xFFDBDBDB),
                    color: const Color(0xFF707070),
                    textStyle: const TextStyle(fontFamily: "PretendardBold"),
                    fillColor: const Color(0xFFFFFFFF),
                    splashColor: const Color(0xFFFFFFFF),
                    constraints: BoxConstraints.expand(
                      width: size.width * 0.3,
                    ),
                    isSelected: isSelected3,
                    onPressed: (int index){
                      setState(() {
                        isSelected1[index] = false;
                        isSelected2[index] = false;
                        isSelected3[index] = true;
                      });
                    },
                    children: [
                      Container(
                          alignment: Alignment.center,
                          child: const Text("참여 높은 순")),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: size.width * 0.4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFF4874EA)
                    ),
                    margin: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          for(var i = 0; i < categories.length; i++){
                            if(categories[i]["isChecked"] == true){
                              print(categories[i]["name"]);
                            }
                          }

                          if(isSelected1[0] == true){
                            print('정렬 순 : 최신 순');
                          }else if(isSelected2[0] == true){
                            print('정렬 순 : 마감 임박 순');
                          }else{
                            print('정렬 순 : 참여 높은 순');
                          }
                        });
                        Navigator.pop(context);
                      },
                      child: const Text("적용", style: TextStyle(
                          color:Color(0xFFFFFFFF), fontFamily: "PretendardBold"))),
                  ),
                  Container(
                    width: size.width * 0.4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFFB6B6B6)
                    ),
                    margin: const EdgeInsets.fromLTRB(10, 20, 20, 20),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          for(int index = 0; index < categories.length; index++) {
                            categories[index]["isChecked"] = false;
                          }
                          isSelected1[0] = true;
                          isSelected2[0] = false;
                          isSelected3[0] = false;
                        });
                      },
                        child: const Text("초기화", style: TextStyle(
                            color:Color(0xFFFFFFFF), fontFamily: "PretendardBold"))
                    ),
                  ),
                ],
              ),
            ]
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: BottomBar()
      ),
    );
  }
}
