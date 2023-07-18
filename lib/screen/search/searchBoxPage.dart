// 탐색 2 페이지 - 최근 검색어 및 실시간 인기 카테고리

// 최종 수정일 : 2023.6.30
// 작업자 : 김혁

// 추가 작업 예정 사항
// 최근 검색어 저장 및 관리
// 서버 연결

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/popularList.dart';
import '../../model/showtoast.dart';
import '../../data/recentSearches.dart';
import 'searchingBox.dart';

// 최근 검색어 관리 클래스
final SPsearch recentSearch = SPsearch();

class SearchBoxPage extends ConsumerStatefulWidget {
  const SearchBoxPage({super.key});

  @override
  SearchBoxPageState createState() => SearchBoxPageState();
}

class SearchBoxPageState extends ConsumerState<SearchBoxPage> {
  final ScrollController _scrollcontroller = ScrollController();

  // 최근 검색어 목록
  List<String> searchwords = [];

  // 인기 검색어 받아오기
  List<PopularList> popularList = [];
  Future<int> getPopularCategoryList() async {
    try {
      final url =
          Uri.parse('http://todaymeet.shop:8080/popular-category');

      http.Response response = await http.get(url);

      if (response.statusCode == 200){
        var serverData = jsonDecode(utf8.decode(response.bodyBytes));
        popularList.clear();
        serverData
            .forEach((element) => popularList.add(PopularList.fromJson(element)));

        return 1;
      } else{
        print('Data download failed!');
        showToast('Data download failed!');
        return 0;
      }
    }
    catch (e) {
      print('There was a problem with the internet connection.');
      showToast('There was a problem with the internet connection.');
      return -1;
    }
  }

  // 최근 검색어 받아오기
  void updateScreen() {
    searchwords = recentSearch.getWord();
    setState(() {});
  }

  @override
  void initState() {
    recentSearch.init().then((value) {
      updateScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                      EdgeInsets.zero
                    )
                  ),
                  onPressed: () {
                    recentSearch.deleteAllWords();
                    updateScreen();
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

            // 최근 검색어 목록
            (searchwords.isEmpty)
                ? const SizedBox.shrink()   // 최근 검색어 없을 시
                : Wrap(
                    spacing: 10,
                    runSpacing: 12,
                    children: List.generate(searchwords.length, (index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9F1FC),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 32,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              // 최근 검색어 누를 시
                              onPressed: () {
                                textcontroller.text = searchwords[index];
                                ref.read(textchangeProvider.notifier).state =
                                    searchwords[index];
                              },
                              child: Text(
                                searchwords[index],
                                style: const TextStyle(
                                  color: Color(0xFF3F51B5),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  letterSpacing: -1,
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            // 최근 검색어 지우기
                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                recentSearch.deleteWord(searchwords[index]);
                                updateScreen();
                              },
                              child: SvgPicture.asset(
                                "assets/icons/close.svg",
                                width: 12,
                                height: 12,
                                colorFilter: const ColorFilter.mode(
                                    Color(0xFF3F51B5), BlendMode.srcIn),
                              ),
                            ),
                          ],
                        ),
                      );
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
                    fontSize: 14),
              ),
            ),

            // 실시간 인기 카테고리
            FutureBuilder(
              future: getPopularCategoryList(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: [
                      for (int i = 0; i < popularList.length; i++)
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
                              Row(
                                children: [
                                  Text(
                                    '${i + 1}.',
                                    style: const TextStyle(
                                      color: Color(0xFF6C6C6C),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                  const SizedBox(width: 4),

                                  Text(
                                    popularList[i].name,
                                    style: const TextStyle(
                                      color: Color(0xFF6C6C6C),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${popularList[i].count}',
                                    style: const TextStyle(
                                      color: Color(0xFF6C6C6C),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      letterSpacing: -1,
                                    ),
                                  ),

                                  const Text(
                                    '건',
                                    style: TextStyle(
                                      color: Color(0xFF6C6C6C),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                    ],
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator());
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}
