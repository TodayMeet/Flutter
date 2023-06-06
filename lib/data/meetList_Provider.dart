// 건수 리스트 프로바이더 페이지

// 최종 수정: 2023.6.3
// 작업자: 정해수

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/data/dummy_meetList.dart';
import 'meetList.dart';

class meetListNotifier extends StateNotifier<List<meetList>> {
  meetListNotifier(): super([]);

  // 리스트 추가
  void addList(meetList meetList) {
    state = [...state, meetList];
  }

  // 리스트 클리어
  void clearList() {
    state = [];
  }
}
final meetListProvider = StateNotifierProvider<meetListNotifier, List<meetList>>((ref) {
  return meetListNotifier();
});