//메인 리스트 게시판 바디 틀

// 최종 수정: 2023.6.27
// 작업자: 정해수 -> 김혁

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../routes.dart';
import '../../data/dummy_meetList.dart';
import '../../data/meetList.dart';
import '../../screen/mainList/Loading_to_ListDetail.dart';
import '../../screen/profile/followList.dart';
import '../../screen/search/searchPageElement.dart' as element;
import '../TextPrint.dart';
import '../UI/widget/button/WhiteButton.dart';
import 'mainListView.dart';
import 'Advertisement.dart';

Widget meetListView(BuildContext context, WidgetRef ref, List<meetList> viewList) {
  return ListView(// 메인 리스트 스크롤 뷰
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    children: [
      //const SizedBox(height: 24.0,),
      //StringText('📣 주변의 새 이벤트', 24, FontWeight.w700, const Color(0xff2F3036)),
      StringText('🧭 주변 이벤트', 24, FontWeight.w700, const Color(0xff2F3036)),
      const SizedBox(height: 19.0,),

      Column(
          children: viewList.asMap().entries.map((list) {
            if(list.key % 5 == 0 && list.key != 0) { //광고 나오는 조건
              return Column(
                children: [
                  Advertisement('광고'), //광고 배너
                  ListViewer(context, ref, list.value),
                ],
              );
            }
            return ListViewer(context, ref, list.value);
          }).toList()
      ), //건수 리스트
      //StringText('🧭 주변 이벤트', 24, FontWeight.w700, const Color(0xff2F3036)),
    ],
  );
}

Widget ListViewer(BuildContext context, WidgetRef ref, meetList List) {
  return Column(
    children: [
      InkWell(
        child: mainListView(List, ref, context),
        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => Loading_to_ListDetail(meetNo: List.meetNo, userNo: tempUser['userNo'],)));
        }, // -> 건수 상세 페이지로 이동
      ),
      const SizedBox(height: 18,)
    ],
  );
}

Widget meetListViews(BuildContext context, WidgetRef ref, List<meetList> viewList) {

  return ListView(// 탐색 화면
    physics: const ClampingScrollPhysics(),
    shrinkWrap: true,
    children: [
      // 상단 배너
      const element.Banner(),

      // 검색 창
      Container(
        height: 46,
        margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
            const MaterialStatePropertyAll<Color>(Color(0xFFF5F6FA)),
            shape: MaterialStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            shadowColor:
            const MaterialStatePropertyAll<Color>(Colors.transparent),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/search.svg"),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  '검색어를 입력해주세요.',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFC8C8CB),
                      letterSpacing: -0.5),
                )
              ],
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.searchBoxRoute);
          },
        ),
      ),

      // 카테고리 선택 버튼
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(child: element.ButtonAll()),
                const SizedBox(width: 6),
                Expanded(child: element.ButtonNotAll(index: 0)),
                const SizedBox(width: 6),
                Expanded(child: element.ButtonNotAll(index: 1)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: element.ButtonNotAll(index: 2)),
                const SizedBox(width: 6),
                Expanded(child: element.ButtonNotAll(index: 3)),
                const SizedBox(width: 6),
                Expanded(child: element.ButtonNotAll(index: 4)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: element.ButtonNotAll(index: 5)),
                const SizedBox(width: 6),
                Expanded(child: element.ButtonNotAll(index: 6)),
                const SizedBox(width: 6),
                Expanded(child: element.ButtonNotAll(index: 7)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: element.ButtonNotAll(index: 8)),
                const SizedBox(width: 6),
                Expanded(child: element.ButtonNotAll(index: 9)),
                const SizedBox(width: 6),
                Expanded(child: element.ButtonNotAll(index: 10)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: element.ButtonNotAll(index: 11)),
                const SizedBox(width: 6),
                Expanded(child: Container()),
                const SizedBox(width: 6),
                Expanded(child: Container()),
              ],
            ),
          ],
        ),
      ),

      // 추천 호스트 텍스트
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
        child: Text(
          "👍 추천 호스트",
          style: TextStyle(
              color: Color(0xFF2F3036),
              fontWeight: FontWeight.w400,
              fontSize: 24),
        ),
      ),

      // 추천 호스트 Container 출력
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SizedBox(
          height: 133,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return element.RecommendHost(
                  element.host_image[index][0],
                  element.host_image[index][1],
                  element.host_image[index][2]);
            },
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
            children: viewList.asMap().entries.map((list) {
              if(list.key % 5 == 0 && list.key != 0) { //광고 나오는 조건
                return Column(
                  children: [
                    Advertisement('광고'), //광고 배너
                    ListViewer(context, ref, list.value),
                  ],
                );
              }
              return ListViewer(context, ref, list.value);
            }).toList()
        ),
      ), //건수 리스트
    ],
  );
}

Widget meetListViewSearch(BuildContext context, WidgetRef ref, List<meetList> viewList) {
  return ListView(  // 탐색 화면 검색 창 탭바
    padding: const EdgeInsets.fromLTRB(24, 24, 24, 6),
    children: [
      Column(
          children: viewList.asMap().entries.map((list) {
            return ListViewer(context, ref, list.value);
          }).toList()
      ), //건수 리스트
    ],
  );
}


Widget meeeeet(BuildContext context, WidgetRef ref, List<meetList> viewList,String userprofileimage,String username, int userNo,String genderString,String birth,int followernum,int followingnum) {
  return ListView(  // 탐색 화면 검색 창 탭바
    padding: EdgeInsets.zero,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 24),
        child: Row(
          children: [
            ClipOval(
              child: Container(width: 70, height: 70, color: Colors.blue, child: Image.network(userprofileimage)),),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${username} ${genderString}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      '${birth} ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),//유저이름, 성, 생년월일
                SizedBox(
                  height: 11,
                ),
                Row(
                  children: [
//팔로우버튼
                    whiteButton(
                      buttonText: '팔로우',
                      onPressed: (){},
                      width: (MediaQuery.of(context).size.width - 148) / 2 ,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),//팔로우 버튼과 차단 버튼 사이 여백
                    whiteButton(
                      buttonText: '차단',
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      width: (MediaQuery.of(context).size.width - 148) / 2 ,
                    )
                  ],
                ),

              ],
            ),
          ],),
      ),
      Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFFCACACA),
                  width: 0.5,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('팔로워',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12.0,color: Color(0xFFA7A8A9)),),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>followList(userNo: userNo,username: username)));

                  },
                  child: Text(followernum.toString(),style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w700,color: Color(0xFF1F2024)),),
                )
              ],
            ),
          ), //팔로워
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFFCACACA),
                  width: 0.5,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('팔로우',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12.0,color: Color(0xFFA7A8A9)),),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>followList(userNo: userNo,username: username)));
                  },
                  child: Text(followingnum.toString(),style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w700,color: Color(0xFF1F2024)),),
                )
              ],
            ),
          ),//팔로잉
        ],
      ),
      ...viewList.asMap().entries.map((list) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          child: ListViewer(context, ref, list.value),
        );
      }).toList(), //건수 리스트
    ],
  );
}



