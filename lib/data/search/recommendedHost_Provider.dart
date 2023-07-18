import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/data/search/recommendedHost.dart';

// 추천 호스트 상태
class RecommendedHostState extends StateNotifier<List<RecommendedHost>> {
  RecommendedHostState(list) : super(list);

  // 추천 호스트 추가
  void addHost(RecommendedHost host) {
    state = [...state, host];
  }

  // 추천 호스트 초기화
  void clearHost() {
    state = [];
  }

  // 추천 호스트 list 개수 반환
  int getLength() {
    return state.length;
  }

  // 추천 호스트 리스트 반환
  RecommendedHost getList(int index) {
    return state[index];
  }
}
