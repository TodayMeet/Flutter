// Future<void> followingLoad() async {
//   final url = Uri.parse('http://todaymeet.shop:8080/follow/list?userNo=${widget.userNo}');
//
//   final requestData = {
//     "userNo": userNo,
//     "userProfileImage":  userProfileImage,
//     "username": username
//   };
//   final jsonData = jsonEncode(requestData);
//   final response = await http.get(
//     url,
//     headers: {'Content-Type': 'application/json'},
//   );
//   if (response.statusCode == 200) {
//     final responseData = jsonDecode(response.body);
//     print(responseData);
//   } else {}
// }//팔로잉 정보 불러오기
//
//

