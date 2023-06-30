// 탐색 3 페이지 - 탭바 및 탭바 뷰

// 최종 수정일 : 2023.6.30
// 작업자 : 김혁

// 추가 작업 예정 사항
// 서버 연결

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'searchingBox.dart';
import 'searchTabbarBoard.dart';

// 탐색화면 - 3 (탭바)
class TabbarPage extends ConsumerWidget {
  const TabbarPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        // 전체보기 탭바
        SearchTabbarViewItem(
            searchword: ref.watch(textchangeProvider), categoryName: "전체보기"),

        // 맛집 탭바
        SearchTabbarViewItem(
            searchword: ref.watch(textchangeProvider), categoryName: "맛집"),

        // 카페 탭바
        SearchTabbarViewItem(
            searchword: ref.watch(textchangeProvider), categoryName: "카페"),

        // 주류 탭바
        SearchTabbarViewItem(
            searchword: ref.watch(textchangeProvider), categoryName: "주류"),

        // 영화 탭바
        SearchTabbarViewItem(
            searchword: ref.watch(textchangeProvider), categoryName: "영화"),

        // 전시 탭바
        SearchTabbarViewItem(
            searchword: ref.watch(textchangeProvider), categoryName: "전시"),

        // 공연 탭바
        SearchTabbarViewItem(
            searchword: ref.watch(textchangeProvider), categoryName: "공연"),

        // 게임 탭바
        SearchTabbarViewItem(
            searchword: ref.watch(textchangeProvider), categoryName: "게임"),

        // 봉사 탭바
        SearchTabbarViewItem(
            searchword: ref.watch(textchangeProvider), categoryName: "봉사"),

        // 독서 탭바
        SearchTabbarViewItem(
            searchword: ref.watch(textchangeProvider), categoryName: "독서"),

        // 스터디 탭바
        SearchTabbarViewItem(
            searchword: ref.watch(textchangeProvider), categoryName: "스터디"),

        // 반려동물 탭바
        SearchTabbarViewItem(
            searchword: ref.watch(textchangeProvider), categoryName: "반려동물"),

        // 운동 탭바
        SearchTabbarViewItem(
            searchword: ref.watch(textchangeProvider), categoryName: "운동"),

      ],
    );
  }
}

PreferredSizeWidget searchTabbar(){
  return PreferredSize(
    preferredSize: const Size.fromHeight(52),
    child: Container(
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
                color: Color(0xFFE4E4E4),
                width: 1,
              ),
              bottom: BorderSide(
                color: Color(0xFFE4E4E4),
                width: 1,
              )
          )
      ),
      child: TabBar(
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
        indicatorColor: const Color(0xFF5881EB),
        labelColor: const Color(0xFF5881EB),
        unselectedLabelColor: Colors.black,
        labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.3,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        isScrollable: true,
        controller: tabController,
        tabs: const <Widget> [
          Tab(
            text: "전체보기",
          ),
          Tab(
            text: "맛집",
          ),
          Tab(
            text: "카페",
          ),
          Tab(
            text: "주류",
          ),
          Tab(
            text: "영화",
          ),
          Tab(
            text: "전시",
          ),
          Tab(
            text: "공연",
          ),
          Tab(
            text: "게임",
          ),
          Tab(
            text: "봉사",
          ),
          Tab(
            text: "독서",
          ),
          Tab(
            text: "스터디",
          ),
          Tab(
            text: "반려동물",
          ),
          Tab(
            text: "운동",
          ),
        ],
      ),
    ),
  );
}