// 탐색 검색창 페이지

// 최종 수정일 : 2023.6.6
// 작업자 : 김혁

// 추가 작업 예정 사항

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'searchAppbarBody.dart';
import '../../model/bottomBar.dart';

class SearchBox extends ConsumerStatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  SearchBoxState createState() => SearchBoxState();
}

class SearchBoxState extends ConsumerState<SearchBox> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: appbar2(context),
          body: SearchBoxPage(),
          bottomNavigationBar: const BottomBar(),
        )
    );
  }
}
