// 탐색 2 페이지 - 최근 검색어 및 실시간 인기 카테고리

// 최종 수정일 : 2023.6.30
// 작업자 : 김혁

// 추가 작업 예정 사항
// 최근 검색어 저장 및 관리
// 서버 연결

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  // 인기 카테고리 더미데이터
  final List<String> popularCategory = [
    '주류',
    '맛집',
    '카페',
    '봉사',
    '영화',
    '드라마',
    '운동',
    '전시',
    '공연',
    '게임'
  ];
  final List<int> searchingNum = [100, 90, 80, 70, 60, 50, 40, 30, 20, 10];

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
            Column(
              children: [
                for (int i = 0; i < 10; i++)
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
                        Text(
                          '${i + 1}. ${popularCategory[i]}',
                          style: const TextStyle(
                            color: Color(0xFF6C6C6C),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            letterSpacing: -1,
                          ),
                        ),
                        Text(
                          '${searchingNum[i]} 건',
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
