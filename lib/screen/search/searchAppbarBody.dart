// 탐색 페이지 appbar와 body

// 최종 수정일 : 2023.6.26
// 작업자 : 김혁

// 추가 작업 예정 사항
// mainpage body 추천 호스트 추가, 밑에 게시판 추가
// searchbox body 두 번째 페이지 만들기
// 서버 연결

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'searchPageElement.dart' as element;
import '../../data/recentSearches.dart';
import 'searchMain.dart';
import 'searchingBox.dart';

appbar1() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    shadowColor: Colors.transparent,
    title: const Text("탐색",
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.black),
    ),
  );
}

final TextEditingController _controller = TextEditingController();

appbar2(BuildContext context) {
  return AppBar(
      toolbarHeight: 72,
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      leading: IconButton(
        icon: SvgPicture.asset(
          "assets/icons/back_icon.svg"
        ),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      actions: [
        Expanded(
          child: Container(
            height: 46,
            margin: const EdgeInsets.fromLTRB(52, 13, 16, 13),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              maxLines: 1,
              controller: _controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                border: InputBorder.none,
                icon: SvgPicture.asset(
                  "assets/icons/search.svg",
                ),
                hintText: '검색어를 입력해주세요.',
                hintStyle: const TextStyle(
                    color: Color(0xFFC8C8CB),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.5
                ),
              ),
              onChanged: (text){
              },
            ),
      ),
        ),
      ]
  );
}

final categoryProvider = StateProvider<int>((ref)=>0);

class SearchMainPage extends ConsumerWidget {
  SearchMainPage({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/search.svg"
                    ),
                    const SizedBox(width: 10,),
                    const Text('검색어를 입력해주세요.', style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFC8C8CB),
                      letterSpacing: -0.5
                      ),
                    )
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
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                        child: element.ButtonAll()
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                        child: element.ButtonNotAll(index: 0)
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                        child: element.ButtonNotAll(index: 1)
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                        child: element.ButtonNotAll(index: 2)
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                        child: element.ButtonNotAll(index: 3)
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                        child: element.ButtonNotAll(index: 4)
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                        child: element.ButtonNotAll(index: 5)
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                        child: element.ButtonNotAll(index: 6)
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                        child: element.ButtonNotAll(index: 7)
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                        child: element.ButtonNotAll(index: 8)
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                        child: element.ButtonNotAll(index: 9)
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                        child: element.ButtonNotAll(index: 10)
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                        child: element.ButtonNotAll(index: 11)
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                        child: Container()
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                        child: Container()
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
            child: Text(
              "👍 추천 호스트",
              style: TextStyle(
                color: Color(0xFF2F3036),
                fontWeight: FontWeight.w400,
                fontSize: 24
              ),
            ),
          ),
          //element.RecommendHost(element.host_image[0][0], element.host_image[0][1], element.host_image[0][2]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              height: 154,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index){
                  return element.RecommendHost(element.host_image[index][0], element.host_image[index][1], element.host_image[index][2]);
                },
              ),
            ),
          )
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
                    fontWeight: FontWeight.w700,
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
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: -1,
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
                    return SizedBox(
                      height: 32,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFE9F1FC)),
                            shadowColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
                            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                            ),
                            padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: 10)
                            ),
                          ),
                          onPressed: (){

                          },
                          child: Row(
                            children: [
                              Text(recentSearch[index],
                                style: const TextStyle(
                                  color: Color(0xFF3F51B5),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  letterSpacing: -1,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref.read(recentSearchProvider.notifier).state.removeAt(index);
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/close.svg",
                                  width: 12,
                                  height: 12,
                                  colorFilter: const ColorFilter.mode(
                                      Color(0xFF3F51B5),
                                      BlendMode.srcIn
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ),
                    );
                      /*Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F1FC),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 32,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {

                            },
                            child: Text(recentSearch[index],
                              style: const TextStyle(
                                color: Color(0xFF3F51B5),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                ref.read(recentSearchProvider.notifier).state.removeAt(index);
                              },
                              child: SvgPicture.asset(
                                "assets/icons/close.svg",
                                width: 12,
                                height: 12,
                                colorFilter: const ColorFilter.mode(
                                    Color(0xFF3F51B5),
                                    BlendMode.srcIn
                                ),
                              ),
                          )
                        ],
                      ),
                    );*/
                  }),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(
                color: Color(0xFFE6E6E6),
                thickness: 1,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                '실시간 인기 카테고리',
                style: TextStyle(
                    color: Color(0xFF2F3036),
                    fontWeight: FontWeight.w700,
                    fontSize: 14
                ),
              ),
            ),
            Column(
              children: [
              for(int i = 0; i < 10; i++)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFF4F4F4),
                  ),
                  height: 40,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${i + 1}. ${popularCategory[i]}',
                        style: const TextStyle(
                          color: Color(0xFF6C6C6C),
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          letterSpacing: -1,
                        ),
                      ),
                      Text('${searchingNum[i]} 건',
                        style: const TextStyle(
                          color: Color(0xFF6C6C6C),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
