// 최근 검색어 저장 및 관리

// 최종 수정일 : 2023.6.30
// 작업자 : 김혁

// 추가 작업 예정 사항

import 'package:shared_preferences/shared_preferences.dart';

class SPsearch {
  static late SharedPreferences prefs;

  // 초기화
  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // 검색어 입력시
  Future saveWord(String word) async {
    if(word != '' && prefs.getString(word) == null) {
      prefs.setString(word, word);
      setCounter();
    }
  }

  // 검색어 목록 업데이트 시
  List<String> getWord(){
   List<String> words = [];
   Set<String> keys = prefs.getKeys();
   keys.forEach((String key) {
     if(key != 'counter') {
       String str = prefs.getString(key) ?? '';
       words.add(str);
     }
   });
   return words;
  }

  Future setCounter() async {
    int counter = prefs.getInt('counter') ?? 0;
    counter++;
    await prefs.setInt('counter', counter);
  }

  int getCounter() {
    return prefs.getInt('counter') ?? 0;
  }

  // 단어 옆 x 버튼
  Future deleteWord(String str) async {
    prefs.remove(str);
    int counter = prefs.getInt('counter') ?? 0;
    if(counter != 0) {
      counter--;
      await prefs.setInt('counter', counter);
    }
  }

  // 모두 지우기 버튼
  Future deleteAllWords() async {
    prefs.clear();
    await prefs.setInt('counter', 0);
  }
}
