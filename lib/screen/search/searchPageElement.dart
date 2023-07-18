// 탐색 페이지 위젯들

// 최종 수정일 : 2023.7.18
// 작업자 : 김혁

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'dart:convert';

import '../../model/showtoast.dart';
import '../../data/userNo.dart';
import '../profile/userProfile.dart';
import 'searchMain.dart';

// 상단 배너
class Banner extends StatefulWidget {
  const Banner({required this.list, Key? key}) : super(key: key);

  final List<String> list;

  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  final PageController _controller = PageController(
    viewportFraction: 1,
    initialPage: 0,
    keepPage: true
  );
  int currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = widget.list;
    final pageCount = list.length;
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black45,
      height: 252,
      width: size.width,
      child: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            onPageChanged: (int page){
              setState(() {
                currentPage = page;
              });
            },
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                list[index],
                width: size.width,
                height: 252,
                fit: BoxFit.fill,
              );
            },
          ),
          Positioned(
            bottom: 22,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < pageCount; i++)
                  _buildPageIndicator((i == currentPage .round()))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        shape: BoxShape.circle,
        color: isCurrentPage ? Colors.white : Colors.transparent,
      ),
    );
  }
}

// 전체보기 버튼
class ButtonAll extends ConsumerWidget {
  const ButtonAll({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedButtonIndex = ref.watch(categoryNumberProvider);
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: selectedButtonIndex == 0 ?
          const MaterialStatePropertyAll<Color>(Color(0xFF5881EB))
              : const MaterialStatePropertyAll<Color>(Color(0xFFF6F6F6)),
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          shadowColor: const MaterialStatePropertyAll<Color>(
              Colors.transparent),
          foregroundColor: selectedButtonIndex == 0 ?
          const MaterialStatePropertyAll<Color>(Colors.white)
              : const MaterialStatePropertyAll<Color>(Colors.black),
          textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          )),
        ),
        onPressed: () {
          ref.read(categoryNumberProvider.notifier).state = 0;
          ref.read(categoryNameProvider.notifier).state = "전체보기";
          searchrefreshController.requestRefresh();
        },
        child: const Text('전체보기'),
      ),
    );
  }
}

// 전체보기 이외에 버튼
class ButtonNotAll extends ConsumerWidget {
  ButtonNotAll({super.key, required this.index});

  final int index;
  final List<String> categoryname = [
    "맛집", "카페", "주류", "영화", "전시", "공연",
    "게임", "봉사", "독서", "스터디", "반려동물", "운동"
  ];

  final List<Map> categories = [
    {"name": "맛집", "image_color": "0xFFE91E63",
      "category_image": "assets/images/Category/Restaurant.svg"},
    {"name": "카페", "image_color": "0xFFE91E63",
      "category_image": "assets/images/Category/Cafe.svg"},
    {"name": "주류", "image_color": "0xFF3F51B5",
      "category_image": "assets/images/Category/Alcohol.svg"},
    {"name": "영화", "image_color": "0xFF673AB7",
      "category_image": "assets/images/Category/Movie.svg"},
    {"name": "전시", "image_color": "0xFF607D8B",
      "category_image": "assets/images/Category/Exhibition.svg"},
    {"name": "공연", "image_color": "0xFF607D8B",
      "category_image": "assets/images/Category/Performance.svg"},
    {"name": "게임", "image_color": "0xFFFF5722",
      "category_image": "assets/images/Category/Game.svg"},
    {"name": "봉사", "image_color": "0xFF8BC34A",
      "category_image": "assets/images/Category/Service.svg"},
    {"name": "독서", "image_color": "0xFF374046",
      "category_image": "assets/images/Category/Read.svg"},
    {"name": "스터디", "image_color": "0xFF9C27B0",
      "category_image": "assets/images/Category/Study.svg"},
    {"name": "반려동물", "image_color": "0xFF795548",
      "category_image": "assets/images/Category/Pet.svg"},
    {"name": "운동", "image_color": "0xFFDCA966",
      "category_image": "assets/images/Category/Sports.svg"},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedButtonIndex = ref.watch(categoryNumberProvider);
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: selectedButtonIndex == index + 1 ?
          const MaterialStatePropertyAll<Color>(Color(0xFF5881EB))
              : const MaterialStatePropertyAll<Color>(Color(0xFFF6F6F6)),
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          shadowColor: const MaterialStatePropertyAll<Color>(
              Colors.transparent),
          foregroundColor: selectedButtonIndex == index + 1 ?
          const MaterialStatePropertyAll<Color>(Colors.white)
              : MaterialStatePropertyAll<Color>(
              Color(int.parse(categories[index]["image_color"]))),
          textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          )),
        ),
        onPressed: () {
          ref.read(categoryNumberProvider.notifier).state = index+1;
          ref.read(categoryNameProvider.notifier).state = categoryname[index];
          searchrefreshController.requestRefresh();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(categories[index]["category_image"],
              colorFilter: ColorFilter.mode(
                  selectedButtonIndex == index + 1 ? Colors.white
                      : Color(int.parse(categories[index]["image_color"])),
                  BlendMode.srcIn),
            ),
            const SizedBox(width: 8),
            Text(categories[index]["name"]),
          ],
        ),
      ),
    );
  }
}

// 추천 호스트 버튼
class RecommendHost extends StatefulWidget {
  RecommendHost(this.image, this.name, this.userNo, this.follow,
      {Key? key}): super(key: key);

  final String image;
  final String name;
  final int userNo;
  bool follow;

  @override
  State<RecommendHost> createState() {
    return _RecommendHostState();
  }
}

class _RecommendHostState extends State<RecommendHost> {

  // 팔로우
  Future<int> addFollow(int followerNo) async {
    try{
      final url = Uri.parse("http://todaymeet.shop:8080/follow/add");
      var postbody = {
        "followerNo":UserNo.myuserNo,
        "followeeNo":followerNo
      };

      Response response = await post(
        url,
        headers: {"Content-Type":"application/json"},
        body: json.encode(postbody),
      );

      if(response.statusCode == 200){
        debugPrint("팔로우 성공");
        print(response);
        return 0;
      }else{
        debugPrint("팔로우 서버 실패");
        showToast("팔로우 서버 실패");
        return -1;
      }
    }catch(e){
      debugPrint("팔로우 오류");
      showToast('팔로우 오류');
      return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String image = widget.image;
    final String name = widget.name;
    final int userNo = widget.userNo;
    bool follow = widget.follow;

    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(18),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xFFF7F8FA)
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                context, MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (builder) => userProfile(userNo: userNo)),
              );
            },
            child: Column(
              children: [
                // 추천 호스트 사진
                SizedBox(
                  width: 36,
                  height: 36,
                  child: ClipOval(
                    child: Image.network(
                      image,
                      width: 36,
                      height: 36,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // 추천 호스트 이름
                SizedBox(
                  width: 64,
                  child: Center(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
          // 팔로우 버튼
          SizedBox(
            height: 24,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: follow == false ?
                    const MaterialStatePropertyAll<Color>(Color(0xFF5881EB))
                      :const MaterialStatePropertyAll<Color>(Color(0xFFD6D6DD)),
                  shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    )
                  ),
                  shadowColor: const MaterialStatePropertyAll<Color>(
                    Colors.transparent
                  ),
                  alignment: Alignment.center,
                  padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 10, vertical: 0)
                  )
                ),
                onPressed: follow == false ?() async {
                  int result = await addFollow(userNo);
                  if(result == 0) {
                    setState(() {
                      widget.follow = true;
                    });
                  }
                }:null,
                child: follow == false ? Row(
                      children: [
                        const Text(
                          "팔로우",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SvgPicture.asset(
                          "assets/icons/add_person.svg",
                          width: 13,
                          height: 13,
                        )
                      ],
                ):const Text(
                  "팔로우",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    color: Colors.white,
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}