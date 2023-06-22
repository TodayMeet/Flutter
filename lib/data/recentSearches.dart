import 'package:flutter_riverpod/flutter_riverpod.dart';

final recentSearchProvider = StateProvider<List<String>>((ref){
  return ['영화', '맛집', '산책', '스터디', '반려동물'];
});