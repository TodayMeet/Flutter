// 건수 리스트 프로바이더 페이지

// 최종 수정: 2023.6.3
// 작업자: 정해수

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front/data/Comment.dart';
import 'meetList.dart';

class meetListNotifier extends StateNotifier<List<meetList>> {
  meetListNotifier(list): super(list);

  // 리스트 추가
  void addList(meetList meetList) {
    state = [...state, meetList];
  }

  // 리스트 클리어
  void clearList() {
    state = [];
  }
}

class CommentsNotifier extends StateNotifier<List<Comment>> {
  CommentsNotifier(): super([]);
}
final commentsProvider = StateNotifierProvider<CommentsNotifier, List<Comment>>((ref) {
  return CommentsNotifier();
});