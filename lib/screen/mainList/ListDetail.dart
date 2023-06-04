// 건수 상세 정보 출력 페이지

// 최종 수정: 2023.5.15
// 작업자: 정해수

//추가 작업 예정 사항:
// 참가 인원 리스트 출력
// 버튼 이동 페이지 연결
// 지도 출력
// 하단 바 고정

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/data/meetList.dart';
import 'package:front/model/mainList/CategoryContainer.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/model/mainList/Invitation.dart';

final buttonColorProvider = StateProvider((ref) => 0xffFFFFFF);
final buttonTextProvider = StateProvider((ref) => '참가하기');

class ListDetail extends ConsumerStatefulWidget {
  const ListDetail({Key? key}) : super(key: key);

  @override
  _ListDetailState createState() => _ListDetailState();
}

class _ListDetailState extends ConsumerState<ListDetail> {

  @override
  Widget build(BuildContext context) {
    int curUserNum = ref.watch(curUserNumProvider);
    int buttonColor = ref.watch(buttonColorProvider);
    String buttonText = ref.watch(buttonTextProvider);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("오늘의 건수",
          style: TextStyle(
              fontFamily: 'PretendardBold',
              color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView( // 메인 리스트 스크롤 뷰
        children: <Widget>[

          Image.asset('assets/images/List_Image/List_image_sample1.png',
              fit: BoxFit.fill,), //등록 이미지

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        categoryContainer(test0.category,),
                        const SizedBox(width: 6,),
                        //Complete(complete),
                      ],
                    ),
                    Row(
                      children: [
                        StringText('모집 마감 시간: ', 12, 'PretendardRegular', Colors.black),
                        IntText(test0.hour, 12, 'PretendardRegular', Colors.black),
                        StringText(':', 12, 'PretendardRegular', Colors.black),
                        TimeText(test0.minute, 12, 'PretendardRegular', Colors.black),
                      ],
                    )
                  ],
                ), //카테고리, 마감시간

                const SizedBox(height: 12,),
                Row(
                  children: [
                    StringText(test0.title, 24, 'PretendardBold', const Color(0xff2F3036))
                  ],
                ), //모임 제목

                const SizedBox(height: 10,),
                Row(
                  children: [
                    Image.asset('assets/images/User_Picture/User_pic_null.png',
                        width: 26, height: 26),  //사용자 사진
                    const SizedBox(width: 10,),
                    StringText(test0.hostName, 12, 'PretendardRegular', Colors.black),
                  ],
                ), //호스트 사진, 이름

                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 30,
                        height: 46,
                        child: ButtonTheme(
                          child: OutlinedButton.icon(
                            icon: const Icon(
                                Icons.person_add_rounded,
                                color: Color(0xff5E5F68)
                            ),
                            onPressed: curUserNum >= test0.userLimit ? () {
                              if(ref.read(buttonTextProvider.notifier).state == '참가하기'){
                                ref.read(buttonColorProvider.notifier).state = 0xffC5C5C5;
                                ref.read(buttonTextProvider.notifier).state = '모집이 마감되었습니다';
                                null;
                              } else {
                                ref.read(curUserNumProvider.notifier).state--;
                                ref.read(buttonTextProvider.notifier).state = '참가하기';
                                ref.read(buttonColorProvider.notifier).state = 0xffFFFFFF;
                              }
                            } : () {
                              //서버에 인원수 체크
                              if(ref.read(buttonTextProvider.notifier).state == '참가하기') {
                                ref.read(curUserNumProvider.notifier).state++;
                                showToast('참가했습니다');
                                ref.read(buttonTextProvider.notifier).state = '참가 취소하기';
                                ref.read(buttonColorProvider.notifier).state = 0xffC5C5C5;
                              } else {
                                ref.read(curUserNumProvider.notifier).state--;
                                ref.read(buttonTextProvider.notifier).state = '참가하기';
                                ref.read(buttonColorProvider.notifier).state = 0xffFFFFFF;
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Color(buttonColor),
                            ),
                            label: StringText(buttonText, 14, 'PretendardBold', const Color(0xff5E5F68)),
                            ),
                          ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 30,
                        height: 46,
                        child: ButtonTheme(
                          child: OutlinedButton.icon(
                            icon: const Icon(
                                Icons.mail,
                                color: Color(0xff5E5F68)
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30)
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    return const Invitaiton();
                                  }
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              //padding: const EdgeInsets.fromLTRB(47, 15, 47, 15),
                            ),
                            label: StringText('초대하기', 14, 'PretendardBold', const Color(0xff5E5F68)),
                          ),
                        ),
                      ),
                    ]
                ), //참가하기, 초대하기 버튼

                const SizedBox(height: 10,),
                ButtonTheme(
                  child: OutlinedButton(
                    onPressed: () {
                      // if(ref.read(CompleteProvider.notifier).state) {
                      //   ref.read(CompleteProvider.notifier).state = false;
                      // } else {
                      //   ref.read(CompleteProvider.notifier).state = true;
                      // }
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
                ), //채팅방 입장 버튼

                const SizedBox(height: 16,),
                Line(),

                const SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StringText('내용', 12, 'PretendardBold', Colors.black),
                    const SizedBox(width: 50,),
                    StringText(test0.content, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                  ],
                ), //모임 내용

                const SizedBox(height: 16,),
                Line(),

                const SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StringText('시간', 12, 'PretendardBold', Colors.black),
                    const SizedBox(width: 50,),
                    IntText(test0.year, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    StringText('년 ', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    IntText(test0.month, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    StringText('월 ', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    IntText(test0.date, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    StringText('일 ', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    IntText(test0.hour, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    StringText(':', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    TimeText(test0.minute, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                  ],
                ), //모임 날짜 및 시각

                const SizedBox(height: 16,),
                Line(),

                const SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StringText('장소', 12, 'PretendardBold', Colors.black),
                    const SizedBox(width: 50,),
                    StringText(test0.location, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                  ],
                ), //모임 장소

                const SizedBox(height: 16,),
                Center(
                  child: Container(
                    height: 300,
                    color: const Color(0xffF0F1F5),
                    child: const Center(child: Text('(지도 출력)')),
                  ),
                ), //지도 출력

                const SizedBox(height: 16,),
                Line(),

                const SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StringText('참여 연령', 12, 'PretendardBold', Colors.black),
                    const SizedBox(width: 35,),
                    Age(test0.age, test0.hostAge),
                  ],
                ), //참여 연령 제한

                const SizedBox(height: 16,),
                Line(),

                const SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StringText('참가비', 12, 'PretendardBold', Colors.black),
                    const SizedBox(width: 50,),
                    IntText(test0.fee, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    StringText('원', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                  ],
                ), //참가비

                const SizedBox(height: 16,),
                Line(),

                const SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StringText('참가 인원', 12, 'PretendardBold', Colors.black),
                    const SizedBox(width: 35,),
                    IntText(curUserNum, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    StringText('명 참여중 / 최대 ', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    IntText(test0.userLimit, 14, 'PretendardRegular', const Color(0xff5E5F68)),
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
                        StringText(test0.hostName, 12, 'PretendardRegular', Colors.black),
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
                Line(),

                const SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 24,),
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
                              ..showSnackBar(const SnackBar(content: Text('미구현 기능입니다 (전체 댓글 보기)')));
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
              ],
            ),
          ),
        ]
      )
    );
  }
}

Widget Complete(bool complete) {
  if(complete)
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
} //모집 완료 여부

Widget Age(bool ageSet, int age) {
  if(ageSet)
  {
    return Row(
      children: [
        IntText(age - 5, 14, 'PretendardRegular', const Color(0xff5E5F68)),
        StringText(' ~ ', 14, 'PretendardRegular', const Color(0xff5E5F68)),
        IntText(age + 5, 14, 'PretendardRegular', const Color(0xff5E5F68)),
      ],
    );
  }
  else
  {
    return StringText('연령 제한 없음', 14, 'PretendardRegular', const Color(0xff5E5F68));
  }
}//연령 제한 여부

Widget Line() {
  return const Center(
    child: SizedBox(
      child: Divider(
        color: Color(0xffF0F1F5),
        thickness: 1.0,
      ),
    ),
  );
}