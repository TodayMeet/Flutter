// 탐색 검색창 페이지

// 최종 수정일 : 2023.6.29
// 작업자 : 김혁

// 추가 작업 예정 사항

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'searchTabbarItem.dart';
import 'searchBoxPage.dart';

late TabController tabController;
final textchangeProvider = StateProvider<String>((ref) => "");
final TextEditingController textcontroller = TextEditingController();

class SearchBox extends ConsumerStatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  SearchBoxState createState() => SearchBoxState();
}

class SearchBoxState extends ConsumerState<SearchBox>
    with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 13, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
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
                      controller: textcontroller,
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
                      onSubmitted: (text){
                        ref.read(textchangeProvider.notifier).state = text;
                        if(recentSearch.getCounter() >= 4){
                          List<String> searchwords = recentSearch.getWord();
                          recentSearch.deleteWord(searchwords[0]);
                        }
                        recentSearch.saveWord(text);
                      },
                    ),
                  ),
                ),
              ],

              bottom: showBottomWidget(),
            ),
          body: (ref.watch(textchangeProvider) == "")
              ? const SearchBoxPage()
              : const TabbarPage(),
        )
    );
  }

  PreferredSizeWidget? showBottomWidget() {
    if(ref.watch(textchangeProvider) == ""){
      return null;
    } else {
      return searchTabbar();
    }
  }
}

