// 탐색 페이지

// 최종 수정일 : 2023.6.6
// 작업자 : 김혁

// 추가 작업 예정 사항

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'searchPageElement.dart' as element;
import 'searchAppbarBody.dart';
import '../../model/bottomBar.dart';

class SearchMain extends ConsumerStatefulWidget {
  const SearchMain({Key? key}) : super(key: key);

  @override
  SearchMainState createState() => SearchMainState();
}

class SearchMainState extends ConsumerState<SearchMain> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: appbar1(),
          body: SearchMainPage(),
          bottomNavigationBar: const BottomBar(),
        )
    );
  }
}
