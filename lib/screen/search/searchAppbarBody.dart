// 탐색 페이지 appbar와 body

// 최종 수정일 : 2023.6.7
// 작업자 : 김혁

// 추가 작업 예정 사항
// mainpage body 추천 호스트 추가, 밑에 게시판 추가
// searchbox body 두 번째 페이지 만들기
// 서버 연결

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'searchPageElement.dart' as element;
import '../../data/recentSearches.dart';
import 'searchMain.dart';
import 'searchingBox.dart';

appbar1() {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    shadowColor: Colors.transparent,
    title: const Text("탐색",
      style: TextStyle(
          fontSize: 16,
          fontFamily: 'PretendardBold',
          color: Colors.black),
    ),
  );
}

final TextEditingController _controller = TextEditingController();

appbar2(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    shadowColor: Colors.transparent,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new,
        color: Colors.black,
        size: 24,
        weight: 400,
      ),
      onPressed: (){
        Navigator.pop(context);
      },
    ),
    title:Container(
        height: 46,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          maxLines: 1,
          controller: _controller,
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(Icons.search, size: 20, color: Color(0xFFBFC0C7)),
            hintText: '검색할 위치를 입력해주세요.',
            hintStyle: TextStyle(
                color: Color(0xFFC8C8CB),
                fontSize: 14,
                fontFamily: "PretendardRegular"
            ),
          ),
          onChanged: (text){
          },
        ),
      ),
  );
}

final categoryProvider = StateProvider<int>((ref)=>0);

class SearchMainPage extends ConsumerWidget {
  SearchMainPage({super.key});

  final ScrollController _scrollController = ScrollController();

  final List<Map> categories = [
    {"name": "맛집", "image_color": "0xFFE91E63",
      "category_image": "assets/images/Category/CategoryRestaurant.png"},
    {"name": "카페", "image_color": "0xFFE91E63",
      "category_image": "assets/images/Category/CategoryCafe.png"},
    {"name": "주류", "image_color": "0xFF3F51B5",
      "category_image": "assets/images/Category/CategoryAlcohol.png"},
    {"name": "영화", "image_color": "0xFF673AB7",
      "category_image": "assets/images/Category/CategoryMovie.png"},
    {"name": "전시", "image_color": "0xFF607D8B",
      "category_image": "assets/images/Category/CategoryExhibition.png"},
    {"name": "공연", "image_color": "0xFF607D8B",
      "category_image": "assets/images/Category/CategoryPerformance.png"},
    {"name": "게임", "image_color": "0xFFFF5722",
      "category_image": "assets/images/Category/CategoryGame.png"},
    {"name": "봉사", "image_color": "0xFF8BC34A",
      "category_image": "assets/images/Category/CategoryService.png"},
    {"name": "독서", "image_color": "0xFF374046",
      "category_image": "assets/images/Category/CategoryRead.png"},
    {"name": "스터디", "image_color": "0xFF9C27B0",
      "category_image": "assets/images/Category/CategoryStudy.png"},
    {"name": "반려동물", "image_color": "0xFF795548",
      "category_image": "assets/images/Category/CategoryPet.png"},
    {"name": "운동", "image_color": "0xFFDCA966",
      "category_image": "assets/images/Category/CategorySports.png"},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final selectedButtonIndex = ref.watch(categoryProvider);
    // 전체 보기를 제외한 버튼
    ElevatedButton button(int index) {
      return ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: selectedButtonIndex == index + 1 ?
          const MaterialStatePropertyAll<Color>(Color(0xFF5881EB))
              : const MaterialStatePropertyAll<Color>(Color(0xFFF6F6F6)),
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          shadowColor: const MaterialStatePropertyAll<Color>(
              Colors.transparent),
          foregroundColor: selectedButtonIndex == index + 1 ?
          const MaterialStatePropertyAll<Color>(Colors.white)
              : MaterialStatePropertyAll<Color>(
              Color(int.parse(categories[index]["image_color"]))),
          textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
            fontFamily: "PretendardBold",
            fontSize: 14,
          )),
        ),
        onPressed: () {
          ref.read(categoryProvider.notifier).state = index+1;
        },
        icon: Image.asset(categories[index]["category_image"],
            color: selectedButtonIndex == index + 1 ?
                Colors.white
                : Color(int.parse(categories[index]["image_color"])),
            scale: 4),
        label: Text(categories[index]["name"]),
      );
    }

    // button list
    List<ElevatedButton> buttons = [
      ElevatedButton(
        style: ButtonStyle(
          backgroundColor: selectedButtonIndex == 0 ?
          const MaterialStatePropertyAll<Color>(Color(0xFF5881EB))
              : const MaterialStatePropertyAll<Color>(Color(0xFFF6F6F6)),
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          shadowColor: const MaterialStatePropertyAll<Color>(
              Colors.transparent),
          foregroundColor: selectedButtonIndex == 0 ?
          const MaterialStatePropertyAll<Color>(Colors.white)
              : const MaterialStatePropertyAll<Color>(Colors.black),
          textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
            fontFamily: "PretendardBold",
            fontSize: 14,
          )),
        ),
        onPressed: () {
          ref.read(categoryProvider.notifier).state = 0;
        },
        child: const Text('전체보기'),
      ),
      button(0),
      button(1),
      button(2),
      button(3),
      button(4),
      button(5),
      button(6),
      button(7),
      button(8),
      button(9),
      button(10),
      button(11),
    ];

    return Scrollbar(
      controller: _scrollController,
      child: ListView(
        controller: _scrollController,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          const element.Banner(),
          Container(
            height: 46,
            margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFF5F6FA)),
                shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                shadowColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const[
                    Icon(Icons.search, size: 20, color: Color(0xFFBFC0C7)),
                    Text('검색어를 입력해주세요.', style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'PretendardRegular',
                      color: Color(0xFFC8C8CB),
                    ),)
                  ],
                ),
              ),
              onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SearchBox())
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 6,
              children: List.generate(
                  buttons.length,
                      (index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      height: 36,
                      width: size.width * 0.283,
                      child: buttons[index])),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(
                  Icons.thumb_up,
                  size: 24,
                  color: Colors.yellowAccent,
                ),
                Text(
                  "추천 호스트",
                  style: TextStyle(
                    color: Color(0xFF2F3036),
                    fontFamily: "PretendardBold",
                    fontSize: 24
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBoxPage extends ConsumerWidget {
  SearchBoxPage({super.key});

  final ScrollController _scrollcontroller = ScrollController();

  final List<String> popularCategory = [
    '주류', '맛집', '카페', '봉사', '영화', '드라마', '운동', '전시', '공연', '게임'
  ];

  final List<int> searchingNum = [
    100, 90, 80, 70, 60, 50, 40, 30, 20, 10
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentSearch = ref.watch(recentSearchProvider);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Scrollbar(
        controller: _scrollcontroller,
        child: ListView(
          controller: _scrollcontroller,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '최근 검색어',
                  style: TextStyle(
                    color: Color(0xFF2F3036),
                    fontFamily: 'PretendardBold',
                    fontSize: 14,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(recentSearchProvider.notifier).state = [];
                  },
                  child: const Text(
                    '모두 지우기',
                    style: TextStyle(
                      color: Color(0xFF9A9A9A),
                      fontFamily: 'PretendardRegular',
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Wrap(
              spacing: 10,
              runSpacing: 12,
              children: List.generate(
                  recentSearch.length,
                      (index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F1FC),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () {

                            },
                            child: Text(recentSearch[index],
                              style: const TextStyle(
                                color: Color(0xFF3F515B),
                                fontFamily: 'PretendardRegular',
                                fontSize: 14,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                ref.read(recentSearchProvider.notifier).state.removeAt(index);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Color(0xFF3F51B5),
                                size: 12,
                                weight: 400,
                              ))
                        ],
                      ),
                    );
                  }),
            ),
            const Divider(
              color: Color(0xFFE6E6E6),
              thickness: 1,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 13.5),
              child: Text(
                '실시간 인기 카테고리',
                style: TextStyle(
                    color: Color(0xFF2F3036),
                    fontFamily: 'PretendardBold',
                    fontSize: 14
                ),
              ),
            ),
            SizedBox(
              height: 800,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: popularCategory.length,
                  itemBuilder: (BuildContext buildcontext, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(0xFFF4F4F4),
                      ),
                      height: 40,
                      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${index + 1}. ${popularCategory[index]}',
                            style: const TextStyle(
                              color: Color(0xFF6C6C6C),
                              fontFamily: 'PretendardBold',
                              fontSize: 16,
                            ),
                          ),
                          Text('${searchingNum[index]} 건',
                            style: const TextStyle(
                              color: Color(0xFF6C6C6C),
                              fontFamily: 'PretendardBold',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
