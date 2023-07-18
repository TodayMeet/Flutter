import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvertisementNotifier extends StateNotifier<List<String>> {
  AdvertisementNotifier(list): super(list);

  // 리스트 추가
  void addList(String url) {
    state = [...state, url];
  }

  // 리스트 클리어
  void clearList() {
    state = [];
  }
}