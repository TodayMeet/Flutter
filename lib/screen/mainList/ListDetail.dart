// 건수 상세 정보 출력 페이지

// 최종 수정: 2023.6.2
// 작업자: 정해수

//추가 작업 예정 사항:
// 참가 인원 리스트 출력
// 버튼 이동 페이지 연결
// 지도 출력

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/model/mainList/CategoryContainer.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/model/mainList/Invitation.dart';
import 'package:front/data/dummy_meetList.dart';
import 'package:intl/intl.dart';
import '../../data/meet.dart';
import 'Comments.dart';

final invitationColorProvider = StateProvider((ref) => 0xffFFFFFF);
final participationColorProvider = StateProvider((ref) => 0xffFFFFFF);
final participationTextProvider = StateProvider((ref) => '참가하기');
final participationIconProvider = StateProvider((ref) => Icons.person_add_rounded);

class ListDetail extends ConsumerStatefulWidget {
  const ListDetail({Key? key,
    required this.meetData,
  }) : super(key: key);

  final dynamic meetData;

  @override
  ListDetailState createState() => ListDetailState();
}

class ListDetailState extends ConsumerState<ListDetail> {
  late dynamic test;

  @override
  void initState() {
    super.initState();
    updateData(widget.meetData);
  }

  void updateData(dynamic meetData) {
    //불러온 json데이터 클래스 객체화
    test = meet.fromJson(meetData);
    print(test); //확인용 출력
/*
    test = meet(meetNo: 0, categoryName: "스터디",time: DateTime.parse("2023-07-30 15:00:00"),
        title: "스터디 모임 모집합니다", userNo: 1, userProfileImage: "image", username: "test", address: "대구",
        meetImage: "", commentNum: 2, peopleLimit: 5, peopleNum: 3, lat: 35.886714, lon: 128.222,
        personClosed: false, fee: 5000, content: "스터디 내용 등등", approval: false,
        timeClosed: false, hostUser: {"userNo": 1, "userProfileImage": "image", "username": "test"},
        comments: [{"meetCommentNo": 4, "meetNo": 5, "parentNo": null, "content": "comment 2",
          "userNo": 2, "userProfileImage": null, "username": "b", "createDate": "2023-05-31 04:02:42"},
          {"meetCommentNo": 3, "meetNo": 5, "parentNo": null, "content": "comment test", "userNo": 1,
            "userProfileImage": "image", "username": "test", "createDate": "2023-05-31 04:02:35"}],
        userList: [{"userNo": 1, "userProfileImage": "image", "username": "test"},{"userNo": 2,
          "userProfileImage": null, "username": "b"}], age: "전연령");*/
  }

  @override
  Widget build(BuildContext context) {
    final curpeopleNumProvider = StateProvider((ref) => test.peopleNum);

    final invitationButtonColorProvider = Provider((ref) {
      final curpeopleNum = ref.watch(curpeopleNumProvider);
      int buttonColor = ref.watch(invitationColorProvider);

      if(test.userList.contains(tempUser)) { // 리스트 안에 있음
        if(curpeopleNum < test.peopleLimit) { // 인원수 안 넘침
          return buttonColor = 0xffFFFFFF;
        } else { //인원수 넘침
          return buttonColor = 0xffC5C5C5;
        }
      } else { //리스트 안에 없음
        return buttonColor = 0xffC5C5C5;
      }
    });
    final completeContainerProvider = Provider((ref) {
      if(test.personClosed || test.timeClosed) { // 인원수 마감 or 시간 마감
        return Container(
          width: 33,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xffD0D1D8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: StringText('완료', 9, 'PretendardBold', Colors.white),
          ),
        );
      }else {
        return const SizedBox(width: 33,);
      }
    });
    final participationButtonColorProvider = Provider((ref) {
      final curpeopleNum = ref.watch(curpeopleNumProvider);
      int buttonColor = ref.watch(participationColorProvider);

      if(test.userList.contains(tempUser)) { //리스트 안에 있음
        return buttonColor = 0xffF0F1F5;
      } else { //리스트 안에 없음
        if(curpeopleNum < test.peopleLimit) { // 인원수 안 넘침
          return buttonColor = 0xffFFFFFF;
        } else { //인원수 넘침
          return buttonColor = 0xffC5C5C5;
        }
      }
    });
    final participationButtonTextProvider = Provider((ref) {
      final curpeopleNum = ref.watch(curpeopleNumProvider);
      String buttonText = ref.watch(participationTextProvider);

      if(test.userList.contains(tempUser)) { //리스트 안에 있음
        return buttonText = '참가 취소하기';
      } else { //리스트 안에 없음
        if(curpeopleNum < test.peopleLimit) { // 인원수 안 넘침
          return buttonText = '참가하기';
        } else { //인원수 넘침
          return buttonText = '모집이 마감되었습니다';
        }
      }
    });
    final participationButtonIconProvider = Provider((ref) {
      final curpeopleNum = ref.watch(curpeopleNumProvider);
      IconData buttonIcon = ref.watch(participationIconProvider);

      if(test.userList.contains(tempUser)) { //리스트 안에 있음
        return buttonIcon = Icons.person_remove_rounded;
      } else { //리스트 안에 없음
        if(curpeopleNum < test.peopleLimit) { // 인원수 안 넘침
          return buttonIcon = Icons.person_add_rounded;
        } else { //인원수 넘침
          return buttonIcon = Icons.person_off_rounded;
        }
      }
    });

    final curUserNum = ref.watch(curpeopleNumProvider);
    final int inviationButtonColor = ref.watch(invitationButtonColorProvider);
    final Widget completeContainer = ref.watch(completeContainerProvider);
    final int particitationButtonColor = ref.watch(participationButtonColorProvider);
    final String particitationButtonText = ref.watch(participationButtonTextProvider);
    final IconData particitationButtonIcon = ref.watch(participationButtonIconProvider);

    List<Map> tempUserList = [];
    int tempPeopleNum = 0;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
        title: const Text("오늘의 건수",
          style: TextStyle(
              fontFamily: 'PretendardBold',
              color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios_new)),
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
                        categoryContainer(test.categoryName,),
                        const SizedBox(width: 6,),
                        completeContainer
                      ],
                    ),
                    Row(
                      children: [
                        StringText('모집 마감 시간: ', 12, 'PretendardRegular', Colors.black),
                        IntText(DateFormat('HH').format(test.time), 12, 'PretendardRegular', Colors.black),
                        StringText(':', 12, 'PretendardRegular', Colors.black),
                        IntText(DateFormat('mm').format(test.time), 12, 'PretendardRegular', Colors.black),
                      ],
                    )
                  ],
                ), //카테고리, 마감시간

                const SizedBox(height: 12,),
                Row(
                  children: [
                    StringText(test.title, 24, 'PretendardBold', const Color(0xff2F3036))
                  ],
                ), //모임 제목

                const SizedBox(height: 10,),
                Row(
                  children: [
                    Image.asset('assets/images/User_Picture/User_pic_null.png',
                        width: 26, height: 26),  //사용자 사진
                    const SizedBox(width: 10,),
                    StringText(test.username, 12, 'PretendardRegular', Colors.black),
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
                            icon: Icon(
                              particitationButtonIcon,
                              color: const Color(0xff5E5F68)
                            ),
                            onPressed: () {
                              if(test.userList.contains(tempUser)) { //리스트 안에 있음
                                //ref.read(curpeopleNumProvider.notifier).state--;
                                tempPeopleNum = test.peopleNum;
                                tempPeopleNum--;
                                tempUserList.addAll(test.userList);
                                tempUserList.remove(tempUser);
                                test = test.copyWith(userList: tempUserList, peopleNum: tempPeopleNum);
                                showToast('취소했습니다');
                              } else { //리스트 안에 없음
                                if(curUserNum < test.peopleLimit) { // 인원수 안 넘침
                                  //서버에 인원수 체크
                                  //ref.read(curpeopleNumProvider.notifier).state++;
                                  tempPeopleNum = test.peopleNum;
                                  tempPeopleNum++;
                                  tempUserList.addAll(test.userList);
                                  tempUserList.add(tempUser);
                                  test = test.copyWith(userList: tempUserList, peopleNum: tempPeopleNum);
                                  showToast('참가했습니다');
                                } else { //인원수 넘침
                                  null;
                                  showToast('모집이 마감되었습니다');
                                }
                              }
                              print(test.userList.toString());
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Color(particitationButtonColor),
                            ),
                            label: StringText(particitationButtonText, 14, 'PretendardBold', const Color(0xff5E5F68)),
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
                              if(test.userList.contains(tempUser)) { //리스트 안에 있음
                                if(curUserNum < test.peopleLimit) { // 인원수 안 넘침
                                  showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(12)
                                        ),
                                      ),
                                      builder: (BuildContext context) {
                                        return Invitaiton(
                                            meetNo: test.meetNo,
                                            userNo: tempUser['usrNo'],
                                            userLimit: test.peopleLimit,
                                            curUserNum: curUserNum
                                        );
                                      }
                                  );
                                } else { // 인원수 넘침
                                  null;
                                  showToast('모집 인원을 초과하여 초대할 수 없습니다');
                                }
                              } else { //리스트 안에 없음
                                null;
                                showToast('참가하지 않은 건수에서는 초대할 수 없습니다');
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Color(inviationButtonColor),
                            ),
                            label: StringText('초대하기', 14, 'PretendardBold', const Color(0xff5E5F68)),
                          ),
                        ),
                      ),
                    ]
                ), //참가하기, 초대하기 버튼

                const SizedBox(height: 10,),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 46,
                  child: ButtonTheme(
                    child: OutlinedButton(
                      onPressed: () {
                        print(test.userList.toString());
                        print(test.peopleNum.toString());
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xff4874EA),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/List_Icon/List_icon_comments2.png',
                              width: 20, height: 20),
                          const SizedBox(width: 7.75,),
                          StringText('채팅방 입장', 14, 'PretendardBold', Colors.white),

                        ],
                      ),
                    ),
                  ),
                ), //채팅방 입장 버튼

                const SizedBox(height: 16,),
                line(),

                const SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StringText('내용', 12, 'PretendardBold', Colors.black),
                    const SizedBox(width: 50,),
                    StringText(test.content, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                  ],
                ), //모임 내용

                const SizedBox(height: 16,),
                line(),

                const SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StringText('시간', 12, 'PretendardBold', Colors.black),
                    const SizedBox(width: 50,),
                    IntText(DateFormat('yyyy').format(test.time), 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    StringText('년 ', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    IntText(DateFormat('MM').format(test.time), 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    StringText('월 ', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    IntText(DateFormat('dd').format(test.time), 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    StringText('일 ', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    IntText(DateFormat('hh').format(test.time), 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    StringText(':', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    IntText(DateFormat('mm').format(test.time), 14, 'PretendardRegular', const Color(0xff5E5F68)),
                  ],
                ), //모임 날짜 및 시각

                const SizedBox(height: 16,),
                line(),

                const SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StringText('장소', 12, 'PretendardBold', Colors.black),
                    const SizedBox(width: 50,),
                    StringText(test.address, 14, 'PretendardRegular', const Color(0xff5E5F68)),
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
                line(),

                const SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StringText('참여 연령', 12, 'PretendardBold', Colors.black),
                    const SizedBox(width: 35,),
                    StringText(test.age, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    //age(test.age, test.hostage),
                  ],
                ), //참여 연령 제한

                const SizedBox(height: 16,),
                line(),

                const SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StringText('참가비', 12, 'PretendardBold', Colors.black),
                    const SizedBox(width: 50,),
                    IntText(test.fee, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    StringText('원', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                  ],
                ), //참가비

                const SizedBox(height: 16,),
                line(),

                const SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StringText('참가 인원', 12, 'PretendardBold', Colors.black),
                    const SizedBox(width: 35,),
                    IntText(curUserNum, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    StringText('명 참여중 / 최대 ', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    IntText(test.peopleLimit, 14, 'PretendardRegular', const Color(0xff5E5F68)),
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
                        StringText(test.username, 12, 'PretendardBold', Colors.black),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset('assets/images/List_Icon/List_icon_host.png',
                            width: 24, height: 24),
                        const SizedBox(width: 4,),
                        StringText('호스트', 12, 'PretendardBold', const Color(0xffB78C00)),
                      ],
                    )
                  ],
                ), //참가자 리스트

                const SizedBox(height: 16,),
                line(),

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
                SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  child: ButtonTheme(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => const Comments()));
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xffF0F1F5),
                        elevation: 0,
                      ),
                      child: Center(child: StringText('전체 댓글 보기', 14, 'PretendardBold', const Color(0xffA8A8B2))),
                    ),
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

Widget age(String ageSet, int age) {
  if(ageSet.compareTo('전연령') != 0)
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

Widget line() {
  return const Center(
    child: SizedBox(
      child: Divider(
        color: Color(0xffF0F1F5),
        thickness: 1.0,
      ),
    ),
  );
}