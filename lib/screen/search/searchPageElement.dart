// 탐색 페이지 위젯들

// 최종 수정일 : 2023.6.3
// 작업자 : 김혁

// 추가 작업 예정 사항

import 'package:flutter/material.dart';

class Banner extends StatefulWidget {
  const Banner({Key? key}) : super(key: key);

  @override
  State<Banner> createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  final PageController _controller = PageController(
    initialPage: 0,
  );
  final _pageCount = 3;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 252,
      width: size.width,
      child: Stack(
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            children: [
              Image.asset("assets/images/Category/CategoryCafe.png",color: Colors.black, fit: BoxFit.fitHeight),
              Image.asset("assets/images/Category/CategoryAlcohol.png",color: Colors.black, fit: BoxFit.fitHeight),
              Image.asset("assets/images/Category/CategoryExhibition.png",color: Colors.black, fit: BoxFit.fitHeight),
              ],
          ),
          CustomPageIndicator(pageController: _controller, pageCount: _pageCount)
        ],
      ),
    );
  }
}

class CustomPageIndicator extends StatelessWidget {
  final PageController pageController;
  final int pageCount;

  CustomPageIndicator({required this.pageController, required this.pageCount});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 22,
      left: 0.0,
      right: 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pageCount, (index) {
          bool isCurrentPage = index == pageController.page?.round();
          return _buildPageIndicator(isCurrentPage);
        }),
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        shape: BoxShape.circle,
        color: isCurrentPage ? Colors.white : Colors.grey,
      ),
    );
  }
}
