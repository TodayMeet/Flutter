// 탐색 페이지

// 최종 수정일 : 2023.5.28
// 작업자 : 김혁

// 추가 작업 예정 사항

import 'package:flutter/material.dart';

import 'searchPageElement.dart' as element;

class SearchMain extends StatefulWidget {
  const SearchMain({Key? key}) : super(key: key);

  @override
  State<SearchMain> createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text("탐색",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'PretendardBold',
                color: Colors.black),),
          ),
          body: Scrollbar(
            controller: _scrollController,
            child: ListView(
              controller: _scrollController,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                const element.Banner(),
                Container(
                  margin: EdgeInsets.fromLTRB(24, 12, 24, 16),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFF5F6FA)),
                      shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
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

                    },
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }
}
