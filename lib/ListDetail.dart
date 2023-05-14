// 건수 상세 정보 출력 페이지

// 최종 수정: 2023.5.14
// 작업자: 정해수

//추가 작업 예정 사항:
// 참가 인원 리스트 출력
// 버튼 이동 페이지 연결
// 지도 출력
// 하단 바 고정

import 'package:flutter/material.dart';
import 'meetList.dart';
import 'CategoryContainer.dart';
import 'TextPrint.dart';
import 'Invitation.dart';

//List 클래스 더미 객체
meetList test2 = meetList('호스트1', 25, 1, 1, '게임', '대구광역시 용산구 121-2', '용산동', 2023, 6, 30, 17, 00, true, 8, 20000, '내가 이 과목 왜했지', 'ㄹㅇ 인생 최대 실수\n과거의 나야 그만둬\n지금 학점이 문제가 아닙니다', true, 0, 0, 1);

class ListDetail extends StatefulWidget {
  const ListDetail({Key? key}) : super(key: key);

  @override
  State<ListDetail> createState() => _ListDetailState();
}

class _ListDetailState extends State<ListDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('오늘의 건수',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView( // 메인 리스트 스크롤 뷰
          children: <Widget>[
            //모임 사진
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryContainer(test2.category,),
                const SizedBox(width: 6,),
                Complete(test2.complete),
                Row(
                  children: [
                    StringText('모집 마감 시간: ', 12, 'PretendardRegular', Colors.black),
                    IntText(test2.hour, 12, 'PretendardRegular', Colors.black),
                    StringText(':', 12, 'PretendardRegular', Colors.black),
                    TimeText(test2.minute, 12, 'PretendardRegular', Colors.black),
                  ],
                )
              ],
            ), //카테고리, 마감시간

            const SizedBox(height: 12,),
            Row(
              children: [
                StringText(test2.title, 24, 'PretendardBold', const Color(0xff2F3036))
              ],
            ), //모임 제목

            const SizedBox(height: 10,),
            Row(
              children: [
                Image.asset('assets/images/User_Picture/User_pic_null.png',
                    width: 26, height: 26),  //사용자 사진
                const SizedBox(width: 10,),
                StringText(test2.hostName, 12, 'PretendardRegular', Colors.black),
              ],
            ), //호스트 사진, 이름

            const SizedBox(height: 10,),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonTheme(
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(SnackBar(content: Text('미구현 기능입니다 (참가하기)')));
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(47, 15, 47, 15),
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/images/List_Icon/List_icon_participate.png',
                              width: 20, height: 20),
                          const SizedBox(width: 7.75,),
                          StringText('참가하기', 14, 'PretendardBold', const Color(0xff5E5F68)),
                        ],
                      ),
                    ),
                  ),
                  ButtonTheme(
                    child: OutlinedButton(
                      onPressed: () {
                        Invitaiton(context, test2);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(47, 15, 47, 15),
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/images/List_Icon/List_icon_invite.png',
                              width: 20, height: 20),
                          const SizedBox(width: 7.75,),
                          StringText('초대하기', 14, 'PretendardBold', const Color(0xff5E5F68)),
                        ],
                      ),
                    ),
                  ),
                ]
            ), //참가하기, 초대하기 버튼

            const SizedBox(height: 10,),
            Row(
              children: [
                ButtonTheme(
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(content: Text('미구현 기능입니다 (채팅방 입장)')));
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(132, 15, 132, 15),
                      backgroundColor: const Color(0xff4874EA),
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/List_Icon/List_icon_comments2.png',
                            width: 20, height: 20),
                        const SizedBox(width: 7.75,),
                        StringText('채팅방 입장', 14, 'PretendardBold', Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ), //채팅방 입장 버튼

            const SizedBox(height: 16,),
            const Center(
              child: SizedBox(
                width: 365,
                child: Divider(
                  color: Color(0xffF0F1F5),
                  thickness: 1.0,
                ),
              ),
            ), //구분선

            const SizedBox(height: 16,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StringText('내용', 12, 'PretendardBold', Colors.black),
                const SizedBox(width: 50,),
                StringText(test2.content, 14, 'PretendardRegular', const Color(0xff5E5F68)),
              ],
            ), //모임 내용

            const SizedBox(height: 16,),
            const Center(
              child: SizedBox(
                child: Divider(
                  color: Color(0xffF0F1F5),
                  thickness: 1.0,
                ),
              ),
            ), //구분선

            const SizedBox(height: 16,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StringText('시간', 12, 'PretendardBold', Colors.black),
                const SizedBox(width: 50,),
                IntText(test2.year, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                StringText('년 ', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                IntText(test2.month, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                StringText('월 ', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                IntText(test2.date, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                StringText('일 ', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                IntText(test2.hour, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                StringText(':', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                TimeText(test2.minute, 14, 'PretendardRegular', const Color(0xff5E5F68)),
              ],
            ), //모임 날짜 및 시각

            const SizedBox(height: 16,),
            const Center(
              child: SizedBox(
                child: Divider(
                  color: Color(0xffF0F1F5),
                  thickness: 1.0,
                ),
              ),
            ), //구분선

            const SizedBox(height: 16,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StringText('장소', 12, 'PretendardBold', Colors.black),
                const SizedBox(width: 50,),
                StringText(test2.location, 14, 'PretendardRegular', const Color(0xff5E5F68)),
              ],
            ), //모임 장소

            const SizedBox(height: 16,),
            Center(
              child: Container(
                height: 300,
                color: const Color(0xffF0F1F5),
                child: Center(child: Text('(지도 출력)')),
              ),
            ), //지도 출력

            const SizedBox(height: 16,),
            const Center(
              child: SizedBox(
                child: Divider(
                  color: Color(0xffF0F1F5),
                  thickness: 1.0,
                ),
              ),
            ), //구분선

            const SizedBox(height: 16,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StringText('참여 연령', 12, 'PretendardBold', Colors.black),
                const SizedBox(width: 35,),
                Age(test2.age),
              ],
            ), //참여 연령 제한

            const SizedBox(height: 16,),
            const Center(
              child: SizedBox(
                child: Divider(
                  color: Color(0xffF0F1F5),
                  thickness: 1.0,
                ),
              ),
            ), //구분선

            const SizedBox(height: 16,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StringText('참가비', 12, 'PretendardBold', Colors.black),
                const SizedBox(width: 50,),
                IntText(test2.fee, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                StringText('원', 14, 'PretendardRegular', const Color(0xff5E5F68)),
              ],
            ), //참가비

            const SizedBox(height: 16,),
            const Center(
              child: SizedBox(
                child: Divider(
                  color: Color(0xffF0F1F5),
                  thickness: 1.0,
                ),
              ),
            ), //구분선

            const SizedBox(height: 16,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StringText('참가 인원', 12, 'PretendardBold', Colors.black),
                const SizedBox(width: 35,),
                IntText(test2.curUserNum, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                StringText('명 참여중 / 최대 ', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                IntText(test2.userLimit, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                StringText(' 명까지', 14, 'PretendardRegular', const Color(0xff5E5F68)),
              ],
            ), //참가 인원

            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //호스트 사진
                    StringText(test2.hostName, 12, 'PretendardRegular', Colors.black),
                  ],
                ),
                Row(
                  children: [
                    Image.asset('assets/images/List_Icon/List_icon_host.png',
                        width: 24, height: 24),
                    const SizedBox(width: 4,),
                    StringText('호스트', 12, 'PretendardRegular', const Color(0xffB78C00)),
                  ],
                )
              ],
            ), //참가자 리스트

            const SizedBox(height: 16,),
            const Center(
              child: SizedBox(
                child: Divider(
                  color: Color(0xffF0F1F5),
                  thickness: 1.0,
                ),
              ),
            ), //구분선

            const SizedBox(height: 16,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 24,),
                StringText('댓글', 12, 'PretendardBold', const Color(0xffAEAFB3)),
              ],
            ), //댓글

            //댓글 내용

            const SizedBox(height: 28,),
            Center(
              child: Row(
                children: [
                  ButtonTheme(
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(SnackBar(content: Text('미구현 기능입니다 (전체 댓글 보기)')));
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(138, 15, 138, 15),
                        backgroundColor: const Color(0xffF0F1F5),
                        elevation: 0,
                      ),
                      child: Row(
                        children: [
                          StringText('전체 댓글 보기', 14, 'PretendardBold', const Color(0xffA8A8B2)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ), //전체 댓글 보기 버튼

            const SizedBox(height: 28,),
          ]
        ),
      )
    );
  }
}

class Complete extends StatelessWidget {
  final int complete;

  const Complete(this.complete, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(complete != 0)
      {
        return Container(
          width: 33,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xffD0D1D8),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: StringText('완료', 9, 'PretendardBold', Colors.white),
          ),
        );
      }
    else
      {
        return const SizedBox(width: 33,);
      }
  }
} //모집 완료 여부

Widget Age(bool age) {
  if(age)
  {
    return Container(
        child: Row(
          children: [
            IntText(test2.hostAge - 5, 14, 'PretendardRegular', const Color(0xff5E5F68)),
            StringText(' ~ ', 14, 'PretendardRegular', const Color(0xff5E5F68)),
            IntText(test2.hostAge + 5, 14, 'PretendardRegular', const Color(0xff5E5F68)),
          ],
        )
    );
  }
  else
  {
    return StringText('연령 제한 없음', 14, 'PretendardRegular', const Color(0xff5E5F68));
  }
}//연령 제한 여부