// 게시판에서 필터 설정 페이지

// 최종 수정일 : 2023.6.22
// 작업자 : 김혁

// 추가 작업 예정 사항
// 적용 버튼 입력 시 서버에 데이터 전송하기

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mainList/mainListBoard.dart';

final categoryProvider = StateProvider<List<Map>>((ref) {
  return [
    {"name": "맛집", "isChecked": false, "image_color": "0xFFE91E63",
      "category_image": "assets/images/Category/Restaurant.svg"},
    {"name": "카페", "isChecked": false, "image_color": "0xFFE91E63",
      "category_image": "assets/images/Category/Cafe.svg"},
    {"name": "주류", "isChecked": false, "image_color": "0xFF3F51B5",
      "category_image": "assets/images/Category/Alcohol.svg"},
    {"name": "영화", "isChecked": false, "image_color": "0xFF673AB7",
      "category_image": "assets/images/Category/Movie.svg"},
    {"name": "전시", "isChecked": false, "image_color": "0xFF607D8B",
      "category_image": "assets/images/Category/Exhibition.svg"},
    {"name": "공연", "isChecked": false, "image_color": "0xFF607D8B",
      "category_image": "assets/images/Category/Performance.svg"},
    {"name": "게임", "isChecked": false, "image_color": "0xFFFF5722",
      "category_image": "assets/images/Category/Game.svg"},
    {"name": "봉사", "isChecked": false, "image_color": "0xFF8BC34A",
      "category_image": "assets/images/Category/Service.svg"},
    {"name": "독서", "isChecked": false, "image_color": "0xFF374046",
      "category_image": "assets/images/Category/Read.svg"},
    {"name": "스터디", "isChecked": false, "image_color": "0xFF9C27B0",
      "category_image": "assets/images/Category/Study.svg"},
    {"name": "반려동물", "isChecked": false, "image_color": "0xFF795548",
      "category_image": "assets/images/Category/Pet.svg"},
    {"name": "운동", "isChecked": false, "image_color": "0xFFDCA966",
      "category_image": "assets/images/Category/Sports.svg"},
  ];
});

final sortfilterProvider = StateProvider<List<bool>>((ref){
  return [true, false, false];
});

class Filter extends ConsumerStatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  FilterState createState() => FilterState();
}

class FilterState extends ConsumerState<Filter> {
  final ScrollController _scrollController = ScrollController();

  bool isSelected1 = true;
  bool isSelected2 = false;
  bool isSelected3 = false;

  @override
  Widget build(BuildContext context) {
    List<Map> categories = ref.watch(categoryProvider);
    List<bool> sort = ref.watch(sortfilterProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('필터',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
              )),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black,
              icon: SvgPicture.asset(
                "assets/icons/back_icon.svg",
                height: 24,
                width: 24,
              ),
          ),
        ),
        body: Scrollbar(
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
              children:[
                Container(
                  margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 10.0),
                  child: const Text("카테고리", style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xff2f3036))),
                ),

                // 카테고리 리스트 타일
                Column(
                  children: categories.map((category){
                    return Container(
                      margin: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: const Color(0xFFF7F8FA),
                      ),
                      child: CheckboxListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        checkboxShape: const CircleBorder(
                            side: BorderSide(
                              color: Color(0xFFD8D8DC),
                              width: 2,
                            )
                        ),
                        tileColor: Colors.white,
                        activeColor: const Color(0xFF5881EB),
                        value: category["isChecked"],
                        onChanged: (newValue){
                          setState(() {
                            category["isChecked"] = newValue;
                          });
                        },
                        title: Text(category["name"],style: const TextStyle(
                            color: Color(0xFF1F2024),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                        )),
                        secondary: Container(
                          alignment: Alignment.center,
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(int.parse(category["image_color"])),
                          ),
                          child: SvgPicture.asset(
                            category["category_image"],
                          ),
                        ),
                        isThreeLine: false,
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 48),
                Container(
                  margin: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                  child: const Text("정렬", style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xFF2F3036))),
                ),

                // 정렬 버튼
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: [
                      // 최신순 버튼
                      Expanded(
                        child: SizedBox(
                          height: 46,
                          child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius : BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: sort[0] ? const Color(0xFF5B5B5B)
                                        : const Color(0xFFDBDBDB)
                                  ),
                                ),
                              ),
                              backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white)
                            ),
                            onPressed: (){
                              ref.read(sortfilterProvider.notifier).state = [true, false, false];
                            },
                            child: Center(
                              child: Text("최신순",
                                style: TextStyle(
                                  color : sort[0] ? Colors.black : const Color(0xFF707070),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // 마감 임박순 버튼
                      Expanded(
                        child: SizedBox(
                          height: 46,
                          child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius : BorderRadius.circular(12),
                                    side: BorderSide(
                                        color: sort[1] ? const Color(0xFF5B5B5B)
                                            : const Color(0xFFDBDBDB)
                                    ),
                                  ),
                                ),
                                backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white)
                            ),
                            onPressed: (){
                              ref.read(sortfilterProvider.notifier).state = [false, true, false];
                            },
                            child: Center(
                              child: Text("마감 임박 순",
                                style: TextStyle(
                                  color : sort[1] ? Colors.black : const Color(0xFF707070),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // 참여 높은 순 버튼
                      Expanded(
                        child: SizedBox(
                          height: 46,
                          child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius : BorderRadius.circular(12),
                                    side: BorderSide(
                                        color: sort[2] ? const Color(0xFF5B5B5B)
                                            : const Color(0xFFDBDBDB)
                                    ),
                                  ),
                                ),
                                backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white)
                            ),
                            onPressed: (){
                              ref.read(sortfilterProvider.notifier).state = [false, false, true];
                            },
                            child: Center(
                              child: Text("참여 높은 순",
                                style: TextStyle(
                                  color : sort[2] ? Colors.black : const Color(0xFF707070),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                // 적용, 초기화 버튼 출력
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFF4874EA)
                          ),
                          child: TextButton(
                            onPressed: (){
                              List<String> category = [];
                              for(var i = 0; i < categories.length; i++) {
                                  if (categories[i]["isChecked"] == true) {
                                    print(categories[i]["name"]);
                                    category.add(categories[i]["name"]);
                                  }
                              }
                              if(sort[0] == true){
                                //print('정렬 순 : 최신 순');
                                ref.read(sortProvider.notifier).state = "최신순";
                              }else if(sort[1] == true){
                                //print('정렬 순 : 마감 임박 순');
                                ref.read(sortProvider.notifier).state = "마감임박순";
                              }else{
                                //print('정렬 순 : 참여 높은 순');
                                ref.read(sortProvider.notifier).state = "참여높은 순";
                              }
                              if(category.isEmpty){
                                ref.read(categoryNameProvider.notifier).state = "전체보기";
                              }else{
                                ref.read(categoryNameProvider.notifier).state = category[0];
                              }
                              print(sort);
                              refreshController.requestRefresh();

                              Navigator.pop(context);
                            },
                            child: const Text("적용",
                                style: TextStyle(
                                  color:Color(0xFFFFFFFF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5)
                            )
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 46,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Color(0xFFB6B6B6)
                          ),
                          child: TextButton(
                            onPressed: (){
                              setState(() {
                                for(int index = 0; index < categories.length; index++) {
                                  categories[index]["isChecked"] = false;
                                }
                              });
                              ref.read(sortfilterProvider.notifier).state = [true, false, false];
                            },
                              child: const Text("초기화",
                                  style: TextStyle(
                                    color:Color(0xFFFFFFFF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.5,)
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
