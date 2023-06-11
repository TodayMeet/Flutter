// 건수 상세 정보 출력 페이지

// 최종 수정: 2023.6.8
// 작업자: 정해수

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/model/mainList/CategoryContainer.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/model/mainList/Invitation.dart';
import 'package:front/data/dummy_meetList.dart';
import 'package:intl/intl.dart';
import '../../data/Comment.dart';
import '../../data/meet.dart';
import '../../data/meetList_Provider.dart';
import '../../model/mainList/CommentContainer.dart';
import 'Comments.dart';
import '../../data/apiKey.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  late meet Meet;
  var commentData;

  @override
  void initState() {
    super.initState();
    upLoadData(widget.meetData);
    getCommentData(Meet.meetNo);
  }

  void upLoadData(dynamic meetData) {
    Meet = meet.fromJson(meetData);
  }

  void getCommentData(int meetNo) async {
    try {
      final url = Uri.parse('http://todaymeet.shop:8080/meet/comment/$meetNo');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        commentData = jsonDecode(utf8.decode(response.bodyBytes));

      } else {
        print('Data download failed!');
        showToast('Data download failed!');
      }
    } catch (e) {
      print('There was a problem with the internet connection.');
      showToast('There was a problem with the internet connection.');
    }
  }

  void updateData() async {
    try {
      final url = Uri.parse('http://todaymeet.shop:8080/meet/detail/${Meet.meetNo}');
      var postBody =
      {
        "userNo": tempUser['userNo']
      };
      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(postBody),
      );

      if (response.statusCode == 200) {
        print('t1');
        upLoadData(jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        print('Data download failed!');
        showToast('Data download failed!');
      }
    } catch (e) {
      print('There was a problem with the internet connection.');
      showToast('There was a problem with the internet connection.');
    }
  }

  Future<void> addUser() async {
    print('t2');
    try {
      final url = Uri.parse('http://todaymeet.shop:8080/meetuseradd');
      var postBody =
      {
        "meet":{
          "meetNo":Meet.meetNo
        },
        "user":{
          "userNo":tempUser['userNo']
        }
      };
      print('t3');
      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(postBody),
      );
      print('t4');
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        print('t5');
      } else {
        print('Data update failed! : ${response.statusCode}');
        showToast('Data update failed!');
      }
    } catch (e) {
      print('There was a problem with the internet connection.');
      showToast('There was a problem with the internet connection.');
    }
  }
  Future<void> subUser() async {
    try {
      final url = Uri.parse('http://todaymeet.shop:8080/meetuserremove');
      var postBody =
      {
        "meet":{
          "meetNo":Meet.meetNo
        },
        "user":{
          "userNo":tempUser['userNo']
        }
      };

      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(postBody),
      );

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        updateData();
      } else {
        print('Data update failed!');
        showToast('Data update failed!');
      }
    } catch (e) {
      print('There was a problem with the internet connection.');
      showToast('There was a problem with the internet connection.');
    }
  }

  List<Comment> sortComments(List<Comment> comments) {
    List<Comment> temp = [];

    for(int i = 0; i < comments.length; i++) {
      if(comments[i].parentNo < 0){ //대댓글이 아니면
        temp.add(comments[i]);
        for(int j = i + 1; j < comments.length; j++) {
          if(comments[i].meetCommentNo == comments[j].parentNo) {
            temp.add(comments[j]);
          }
        }
      }
    }
    return temp;
  } //대댓글 정렬

  @override
  Widget build(BuildContext context) {
    final curpeopleNumProvider = StateProvider((ref) => Meet.peopleNum);
    final invitationButtonColorProvider = Provider((ref) {
      final curpeopleNum = ref.watch(curpeopleNumProvider);
      int buttonColor = ref.watch(invitationColorProvider);

      if(Meet.isInsert) { // 리스트 안에 있음
        if(curpeopleNum < Meet.peopleLimit) { // 인원수 안 넘침
          return buttonColor = 0xffFFFFFF;
        } else { //인원수 넘침
          return buttonColor = 0xffC5C5C5;
        }
      } else { //리스트 안에 없음
        return buttonColor = 0xffC5C5C5;
      }
    });
    final completeContainerProvider = Provider((ref) {
      if(Meet.personClosed || Meet.timeClosed) { // 인원수 마감 or 시간 마감
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

      if(Meet.isInsert) { //리스트 안에 있음
        return buttonColor = 0xffF0F1F5;
      } else { //리스트 안에 없음
        if(curpeopleNum < Meet.peopleLimit) { // 인원수 안 넘침
          return buttonColor = 0xffFFFFFF;
        } else { //인원수 넘침
          return buttonColor = 0xffC5C5C5;
        }
      }
    });
    final participationButtonTextProvider = Provider((ref) {
      final curpeopleNum = ref.watch(curpeopleNumProvider);
      String buttonText = ref.watch(participationTextProvider);

      if(Meet.isInsert) { //리스트 안에 있음
        return buttonText = '참가 취소하기';
      } else { //리스트 안에 없음
        if(curpeopleNum < Meet.peopleLimit) { // 인원수 안 넘침
          return buttonText = '참가하기';
        } else { //인원수 넘침
          return buttonText = '모집이 마감되었습니다';
        }
      }
    });
    final participationButtonIconProvider = Provider((ref) {
      final curpeopleNum = ref.watch(curpeopleNumProvider);
      IconData buttonIcon = ref.watch(participationIconProvider);

      if(Meet.isInsert) { //리스트 안에 있음
        return buttonIcon = Icons.person_remove_rounded;
      } else { //리스트 안에 없음
        if(curpeopleNum < Meet.peopleLimit) { // 인원수 안 넘침
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
    List<Comment> comments = ref.watch(commentsProvider);
    comments = sortComments(Meet.comments);

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

          Container(
            width: double.maxFinite,
            height: 200,
            color: const Color(0xffF0F1F5),
            child: const Center(child: Text('(사진)')),
          ),

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        categoryContainer(Meet.categoryName,),
                        const SizedBox(width: 6,),
                        completeContainer
                      ],
                    ),
                    Row(
                      children: [
                        StringText('모집 마감 시간: ', 12, 'PretendardRegular', Colors.black),
                        IntText(DateFormat('HH').format(Meet.time), 12, 'PretendardRegular', Colors.black),
                        StringText(':', 12, 'PretendardRegular', Colors.black),
                        IntText(DateFormat('mm').format(Meet.time), 12, 'PretendardRegular', Colors.black),
                      ],
                    )
                  ],
                ), //카테고리, 마감시간

                const SizedBox(height: 12,),
                Row(
                  children: [
                    StringText(Meet.title, 24, 'PretendardBold', const Color(0xff2F3036))
                  ],
                ), //모임 제목

                const SizedBox(height: 10,),
                Row(
                  children: [
                    Image.asset('assets/images/User_Picture/User_pic_null.png',
                        width: 26, height: 26),  //사용자 사진
                    const SizedBox(width: 10,),
                    StringText(Meet.username, 12, 'PretendardRegular', Colors.black),
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
                              if(Meet.isInsert) { //리스트 안에 있음
                                setState(() {
                                  updateData();
                                  //subUser();
                                });
                                showToast('취소했습니다');
                              } else { //리스트 안에 없음
                                if(curUserNum < Meet.peopleLimit) { // 인원수 안 넘침
                                  // 서버에 증원 요청 -> 데이터 갱신 -> 화면 리빌드
                                  print('t1');
                                  addUser();
                                  print('t6');
                                  showToast('참가했습니다');
                                } else { //인원수 넘침
                                  null;
                                  showToast('모집이 마감되었습니다');
                                }
                              }
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
                              if(Meet.isInsert) { //리스트 안에 있음
                                if(curUserNum < Meet.peopleLimit) { // 인원수 안 넘침
                                  showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(12)
                                        ),
                                      ),
                                      builder: (BuildContext context) {
                                        return Invitaiton(
                                            meetNo: Meet.meetNo,
                                            userNo: tempUser['usrNo'],
                                            userLimit: Meet.peopleLimit,
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
                        print(Meet.userList.toString());
                        print(Meet.peopleNum.toString());
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 130,
                        child: StringText(Meet.content, 14, 'PretendardRegular', const Color(0xff5E5F68))),
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
                    IntText(DateFormat('yyyy').format(Meet.time), 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    StringText('년 ', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    IntText(DateFormat('MM').format(Meet.time), 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    StringText('월 ', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    IntText(DateFormat('dd').format(Meet.time), 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    StringText('일 ', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    IntText(DateFormat('hh').format(Meet.time), 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    StringText(':', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    IntText(DateFormat('mm').format(Meet.time), 14, 'PretendardRegular', const Color(0xff5E5F68)),
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
                    StringText(Meet.address, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                  ],
                ), //모임 장소

                const SizedBox(height: 16,),
                Center(
                  child: Container(
                    height: 300,
                    color: const Color(0xffF0F1F5),
                    child: KakaoMapView(
                      height: 300,
                      width: double.infinity,
                      lat: double.parse(Meet.lat),
                      lng: double.parse(Meet.lon),
                      kakaoMapKey: kakaoMapKey,
                    ),
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
                    StringText(Meet.age, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    //age(Meet.age, Meet.hostage),
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
                    IntText(Meet.fee, 14, 'PretendardRegular', const Color(0xff5E5F68)),
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
                    IntText(Meet.peopleLimit, 14, 'PretendardRegular', const Color(0xff5E5F68)),
                    StringText(' 명까지', 14, 'PretendardRegular', const Color(0xff5E5F68)),
                  ],
                ), //참가 인원

                const SizedBox(height: 25,),
                Column(
                  children: Meet.userList.map((user) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.account_circle), //유저 아이콘
                              const SizedBox(width: 10,),
                              StringText(user['username'], 12, 'PretendardBold', Colors.black),
                            ],
                          ),
                          userList(user, Meet.userNo)

                        ],
                      ),
                    );
                  }).toList(),
                ),

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

                const SizedBox(height: 16,),
                Column(
                  children: comments.asMap().entries.map((c) {
                    return Column(
                      children: [
                        CommentContainer(context, c.value, c.key),
                      ],
                    );
                  }).toList(),
                ),

                const SizedBox(height: 28,),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  child: ButtonTheme(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) {
                                  return Comments(Data: commentData);
                                }
                            )
                        );
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

Widget userList(Map user, int hostNo) {
  if(hostNo == user['userNo']){
    return Row(
      children: [
        Image.asset('assets/images/List_Icon/List_icon_host.png',
            width: 24, height: 24),
        const SizedBox(width: 4,),
        StringText('호스트', 12, 'PretendardBold', const Color(0xffB78C00)),
      ],
    );
  } else {
    return Row(
      children: [
        const Icon(Icons.account_circle, color: Color(0xffDCDCDC),),
        const SizedBox(width: 4,),
        StringText('참여자', 12, 'PretendardBold', const Color(0xff999999)),
      ],
    );
  }
}