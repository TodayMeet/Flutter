import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/screen/dialog/dialoglist.dart';
import 'package:http/http.dart' as http;
import 'package:front/screen/profile/profileMain.dart';

import '../../data/designconst/constants.dart';
import '../../model/UI/widget/button/blueButton.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';
import '../../model/UI/widget/text/textfieldTitle.dart';

class profileFavorite extends StatefulWidget {
  final int userNo;

  profileFavorite({required this.userNo});

  @override
  State<profileFavorite> createState() => _profileFavoriteState();
}

class _profileFavoriteState extends State<profileFavorite> {
  final ScrollController _scrollController = ScrollController();
  final String appbarText = '관심사';
  String selectFavorite = '관심사를 최대 5개까지 골라 주세요';
  List<Map> categories = [
    {
      "name": "맛집",
      "isChecked": false,
      "image_color": "0xFFE91E63",
      "category_image": "assets/images/Category/Restaurant.svg"
    },
    {
      "name": "카페",
      "isChecked": false,
      "image_color": "0xFFE91E63",
      "category_image": "assets/images/Category/Cafe.svg"
    },
    {
      "name": "주류",
      "isChecked": false,
      "image_color": "0xFF3F51B5",
      "category_image": "assets/images/Category/Alcohol.svg"
    },
    {
      "name": "영화",
      "isChecked": false,
      "image_color": "0xFF673AB7",
      "category_image": "assets/images/Category/Movie.svg"
    },
    {
      "name": "전시",
      "isChecked": false,
      "image_color": "0xFF607D8B",
      "category_image": "assets/images/Category/Exhibition.svg"
    },
    {
      "name": "공연",
      "isChecked": false,
      "image_color": "0xFF607D8B",
      "category_image": "assets/images/Category/Performance.svg"
    },
    {
      "name": "게임",
      "isChecked": false,
      "image_color": "0xFFFF5722",
      "category_image": "assets/images/Category/Game.svg"
    },
    {
      "name": "봉사",
      "isChecked": false,
      "image_color": "0xFF8BC34A",
      "category_image": "assets/images/Category/Service.svg"
    },
    {
      "name": "독서",
      "isChecked": false,
      "image_color": "0xFF374046",
      "category_image": "assets/images/Category/Read.svg"
    },
    {
      "name": "스터디",
      "isChecked": false,
      "image_color": "0xFF9C27B0",
      "category_image": "assets/images/Category/Study.svg"
    },
    {
      "name": "반려동물",
      "isChecked": false,
      "image_color": "0xFF795548",
      "category_image": "assets/images/Category/Pet.svg"
    },
    {
      "name": "운동",
      "isChecked": false,
      "image_color": "0xFFDCA966",
      "category_image": "assets/images/Category/Sports.svg"
    },
  ];
  Set<String> selectedCategories = {};
  Color textColor = Color(0xff2f3036);
  int test = 34;

  Future<List<String>> categoryLoad() async {
    final url1 = Uri.parse('http://todaymeet.shop:8080/usercategory/${test}');
    final requestData = selectedCategories.toList();
    final jsonData = jsonEncode(requestData);
    final response = await http.get(
      url1,
      headers: {'Content-Type': 'application/json'},

    );
    if (response.statusCode == 200) {
      // print('전송잘됨');
      // print(selectedCategories.toList());
      // print(url1);
      // var serverData = jsonDecode(utf8.decode(response.bodyBytes));

      List<dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));
      List<String> resultList = [];
      for (dynamic data in result) {
        // 데이터를 String으로 변환하여 결과 리스트에 추가
        String resultItem = data.toString();
        resultList.add(resultItem);
      }
      print(resultList);
      return resultList;
      // print(response);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => favorite()),
      // );
    } else {
      print('전송 자체가 안됨. 상태 코드: ${response.statusCode}');
      print(selectedCategories.toList());
      // print(widget.password);
      // print(widget.email);
      print(url1);
      print(jsonData);
      print(response.body);
      return ['a'];
    }
  }

  Future<void> categoryChange() async {
    final url1 = Uri.parse('http://todaymeet.shop:8080/usercategory/${widget.userNo}');
    final requestData = selectedCategories.toList();
    final jsonData = jsonEncode(requestData);
    final response = await http.put(
      url1,
      headers: {'Content-Type': 'application/json'},
      body: jsonData,
    );
    if (response.statusCode == 200) {
      print('전송잘됨');
      print(selectedCategories.toList());
      print(url1);
      print(response.body);
      print(response);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => favorite()),
      // );
    } else {
      print('전송 자체가 안됨. 상태 코드: ${response.statusCode}');
      print(selectedCategories.toList());
      // print(widget.password);
      // print(widget.email);
      print(url1);
      print(jsonData);
      print(response.body);

    }
  }
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {

    List<String> loadedCategories = await categoryLoad();

    for (String name in loadedCategories) {
      for (Map category in categories) {
        if (category['name'] == name) {
          category['isChecked'] = true;
          break;
        }
      }
    }
    for (Map category in categories) {
      print(category['isChecked']);
    }
  }
  @override
  Widget build(BuildContext context) {
    int checkedCount =
        categories.where((category) => category["isChecked"]).length;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: appbarText,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(controller: _scrollController, children: [
          textfieldTitle(title: '관심사를 최대 5개까지 골라 주세요.', star: false),
          Column(
            // 카테고리
            crossAxisAlignment: CrossAxisAlignment.center,
            children: categories.map((category) {
              if (category['isChecked']) {
                selectedCategories.add(category['name']);
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF7F8FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(

                      leading: Container(
                        alignment: Alignment.center,
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(int.parse(category["image_color"])),
                        ),
                        child: SvgPicture.asset(category["category_image"]),
                      ),
                      title: Text(category["name"],
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15)),

                      trailing: Container(
                        width: category['isChecked'] ? 64 : 45,
                        child: category['isChecked']
                            ? TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.resolveWith<Color>(
                                    (states) => Colors.transparent),
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (states) => Color(0xFF5881EB),
                            ),
                            shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                                  (states) => RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              category['isChecked'] = false;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('관심',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12.0,color: Colors.white),),
                              SizedBox(width: 5,),
                              SvgPicture.asset('assets/icons/detail/Vector.svg')
                            ],
                          ),
                        )
                            : TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.resolveWith<Color>(
                                    (states) => Colors.transparent),
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (states) => Color(0xFFD6D6DD),
                            ),
                            shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                                  (states) => RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              category['isChecked'] = true;
                            });
                          },
                          child: Text('관심',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12.0,color: Colors.white),),
                        ),
                      )


                      ),
                ),
              );
            }).toList(),
          ),

          blueButton(
              buttonText: '저장하기',
              onPressed: () async {
                if (checkedCount > 5) {
                  onebutton.overFiveDialog(context);
                } else {
                  categoryLoad();
                  print("userNo는");
                  print(widget.userNo);
                  print('새로 선택한 관심사는');
                  print(selectedCategories.toList());
                  print('기존에 선택했던 관심사는');





                  // print(categor);
                  // categoryChange();
                }
              })
        ]),
      ),
    );
  }
}


