// 건수 상세 정보 출력 페이지

// 최종 수정: 2023.7.3
// 작업자: 정해수 -> 김혁

// 추가 작업해야 할 사항
// 채팅방 입장 연결

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import '../../model/mainList/CategoryContainer.dart';
import '../../model/TextPrint.dart';
import '../../model/mainList/Invitation.dart';
import '../../data/dummy_meetList.dart';
import '../../data/meet.dart';
import '../../model/mainList/CommentContainer.dart';
import '../../data/apiKey.dart';
import '../alarm/alarm.dart';
import 'Comments.dart';

//state provider
final invitationColorProvider = StateProvider((ref) => 0xffFFFFFF);
final participationColorProvider = StateProvider((ref) => 0xffFFFFFF);
final participationTextProvider = StateProvider((ref) => '참가하기');
final participationIconProvider =
    StateProvider((ref) => Icons.person_add_rounded);

class ListDetail extends ConsumerStatefulWidget {
  const ListDetail({
    Key? key,
    required this.meetData,
  }) : super(key: key);

  final dynamic meetData; //건수 데이터

  @override
  ListDetailState createState() => ListDetailState();
}

class ListDetailState extends ConsumerState<ListDetail> {
  late meet Meet; //건수 정보
  late String pinInformation; // 모임 핀정보

  @override
  void initState() {
    super.initState();
    upLoadData(widget.meetData); //건수 데이터 클래스 객체화
    print(Meet.meetNo);
  }

  // 상세화면 데이터 불러오기
  void upLoadData(dynamic meetData) {
    Meet = meet.fromJson(meetData);
    pinInformation = DateFormat("MM.dd hh:mm ").format(Meet.time);
    pinInformation = "$pinInformation${Meet.categoryName}";
  }

  //건수 상세화면 새로고침
  void updateData() async {
    try {
      final url =
          Uri.parse('http://todaymeet.shop:8080/meet/detail/${Meet.meetNo}');
      var postBody = {"userNo": tempUser['userNo']};
      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(postBody),
      );

      if (response.statusCode == 200) {
        var updateData = jsonDecode(utf8.decode(response.bodyBytes));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ListDetail(
              meetData: updateData,
            ),
          ),
        );
      } else {
        print('Data download failed!');
        showToast('Data download failed!');
      }
    } catch (e) {
      print('There was a problem with the internet connection.');
      showToast('There was a problem with the internet connection.');
    }
  }

  // 참가하기
  Future<void> addUser() async {
    try {
      final url = Uri.parse('http://todaymeet.shop:8080/meetuseradd');
      var postBody = {
        "meet": {"meetNo": Meet.meetNo},
        "user": {"userNo": tempUser['userNo']}
      };
      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(postBody),
      );
      if (response.statusCode == 200) {
        print(response.body);
        updateData();
        showToast('참가했습니다');
      } else {
        print('Data update failed! : ${response.statusCode}');
        showToast('Data update failed!');
      }
    } catch (e) {
      print('There was a problem with the internet connection.');
      showToast('There was a problem with the internet connection.');
    }
  }

  // 참가 취소
  Future<void> subUser() async {
    try {
      final url = Uri.parse('http://todaymeet.shop:8080/meetuserremove');
      var postBody = {
        "meet": {"meetNo": Meet.meetNo},
        "user": {"userNo": tempUser['userNo']}
      };

      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(postBody),
      );

      if (response.statusCode == 200) {
        print(response.body);
        updateData();
        showToast('취소했습니다');
      } else {
        print('Data update failed!');
        showToast('Data update failed!');
      }
    } catch (e) {
      print('There was a problem with the internet connection.');
      showToast('There was a problem with the internet connection.');
    }
  }

  // 지도보기 창
  void findLocation() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: 700,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 30,
                    blurStyle: BlurStyle.outer,
                  ),
                ]),
            child: Column(
              children: [
                AppBar(
                  toolbarHeight: 50,
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24))),
                  title: const Text(
                    "지도보기",
                    style: TextStyle(
                      color: Color(0xFF1F2024),
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      letterSpacing: 0.09,
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          "assets/icons/close.svg",
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                KakaoMapView(
                  width: double.infinity,
                  height: 650,
                  kakaoMapKey: kakaoMapKey,
                  lat: double.parse(Meet.lat),
                  lng: double.parse(Meet.lon),
                  customOverlay: '''
                  function addMarker(content, position){
                    var marker = new kakao.maps.CustomOverlay({
                      position: position,
                      content: content,
                      yAnchor: 1
                    });
                    marker.setMap(map);
                  }
                  
                  marker.setMap(null);
                  
                  var position = new kakao.maps.LatLng(${double.parse(Meet.lat)}, ${double.parse(Meet.lon)});
                  var content = '<div class="customoverlay">' +
                     '    <span class="title">' + '$pinInformation' + '</span>' +
                     '</div>';
                  addMarker(content, position);
                    
                  ''',
                  customOverlayStyle: '''<style>
                    .customoverlay {position:relative;border-radius:20px;background:#E91E63;color:#FFF;padding:5px;max-width:200px;}
                    .customoverlay .title {text-align:center;color:#FFF;padding:5px 8px;font-size:10px;font-weight:700;}
                    .customoverlay::before {content: '';position: absolute;top: 100%;left: 50%;margin-left: -8px;border: 8px solid transparent;border-top-color: #E91E63;}
                    </style>''',
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //결합된 provider
    final curpeopleNumProvider = StateProvider((ref) => Meet.peopleNum);
    final invitationButtonColorProvider = Provider((ref) {
      final curpeopleNum = ref.watch(curpeopleNumProvider);
      int buttonColor = ref.watch(invitationColorProvider);

      if (Meet.isInsert) {
        // 리스트 안에 있음
        if (curpeopleNum < Meet.peopleLimit) {
          // 인원수 안 넘침
          return buttonColor = 0xffFFFFFF;
        } else {
          //인원수 넘침
          return buttonColor = 0xffC5C5C5;
        }
      } else {
        //리스트 안에 없음
        return buttonColor = 0xffC5C5C5;
      }
    });
    final completeContainerProvider = Provider((ref) {
      if (Meet.personClosed || Meet.timeClosed) {
        // 인원수 마감 or 시간 마감
        return Container(
          width: 33,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xffD0D1D8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: StringText_letterspacing(
                '완료', 9, FontWeight.w700, Colors.white, -0.5),
          ),
        );
      } else {
        return const SizedBox(
          width: 33,
        );
      }
    });
    final participationButtonColorProvider = Provider((ref) {
      final curpeopleNum = ref.watch(curpeopleNumProvider);
      int buttonColor = ref.watch(participationColorProvider);

      if (Meet.isInsert) {
        //리스트 안에 있음
        return buttonColor = 0xffF0F1F5;
      } else {
        //리스트 안에 없음
        if (curpeopleNum < Meet.peopleLimit) {
          // 인원수 안 넘침
          return buttonColor = 0xffFFFFFF;
        } else {
          //인원수 넘침
          return buttonColor = 0xffC5C5C5;
        }
      }
    });
    final participationButtonTextProvider = Provider((ref) {
      final curpeopleNum = ref.watch(curpeopleNumProvider);
      String buttonText = ref.watch(participationTextProvider);

      if (Meet.isInsert) {
        //리스트 안에 있음
        return buttonText = '참가 취소하기';
      } else {
        //리스트 안에 없음
        if (curpeopleNum < Meet.peopleLimit) {
          // 인원수 안 넘침
          return buttonText = '참가하기';
        } else {
          //인원수 넘침
          return buttonText = '모집이 마감되었습니다';
        }
      }
    });
    final participationButtonIconProvider = Provider((ref) {
      final curpeopleNum = ref.watch(curpeopleNumProvider);
      IconData buttonIcon = ref.watch(participationIconProvider);

      if (Meet.isInsert) {
        //리스트 안에 있음
        return buttonIcon = Icons.person_remove_rounded;
      } else {
        //리스트 안에 없음
        if (curpeopleNum < Meet.peopleLimit) {
          // 인원수 안 넘침
          return buttonIcon = Icons.person_add_rounded;
        } else {
          //인원수 넘침
          return buttonIcon = Icons.person_off_rounded;
        }
      }
    });

    //provider 등록
    final curUserNum = ref.watch(curpeopleNumProvider);
    final int inviationButtonColor = ref.watch(invitationButtonColorProvider);
    final Widget completeContainer = ref.watch(completeContainerProvider);
    final int particitationButtonColor =
        ref.watch(participationButtonColorProvider);
    final String particitationButtonText =
        ref.watch(participationButtonTextProvider);
    final IconData particitationButtonIcon =
        ref.watch(participationButtonIconProvider);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 1,
          title: const Text(
            "오늘의 건수",
            style: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.black, fontSize: 16),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black,
              icon: SvgPicture.asset("assets/icons/back_icon.svg")),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const alarm()));
                },
                icon: SvgPicture.asset("assets/icons/detail/alarm.svg")),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/icons/detail/search.svg",
              ),
            ),
          ],
        ),
        body: ListView(// 메인 리스트 스크롤 뷰
            children: <Widget>[
          MeetImage(Meet.meetImage), //건수 사진

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        categoryContainer(
                          Meet.categoryName,
                        ),
                        const SizedBox(width: 6),
                        completeContainer
                      ],
                    ),
                    Row(
                      children: [
                        StringText(
                            '마감 시간 : ', 12, FontWeight.w400, Colors.black),
                        StringText_letterspacing(
                            DateFormat('HH:mm').format(Meet.time),
                            12,
                            FontWeight.w400,
                            Colors.black,
                            -0.5),
                      ],
                    )
                  ],
                ), //카테고리, 마감시간

                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    StringText(Meet.title, 24, FontWeight.w700,
                        const Color(0xff2F3036))
                  ],
                ), //모임 제목

                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.asset(
                          'assets/images/User_Picture/User_pic_null.png',
                          width: 26,
                          height: 26),
                    ), //사용자 사진
                    const SizedBox(
                      width: 10,
                    ),
                    StringText_letterspacing(
                        Meet.username, 12, FontWeight.w400, Colors.black, -0.5),
                  ],
                ), //호스트 사진, 이름

                const SizedBox(height: 12),
                Row(children: [
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: OutlinedButton.icon(
                          icon: Icon(particitationButtonIcon,
                              color: const Color(0xff5E5F68)),
                          onPressed: () {
                            if (Meet.isInsert) {
                              //리스트 안에 있음
                              setState(() {
                                //updateData();
                                subUser();
                              });
                            } else {
                              //리스트 안에 없음
                              if (curUserNum < Meet.peopleLimit) {
                                // 인원수 안 넘침
                                // 서버에 증원 요청 -> 데이터 갱신 -> 화면 리빌드
                                addUser();
                              } else {
                                //인원수 넘침
                                null;
                                showToast('모집이 마감되었습니다');
                              }
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Color(particitationButtonColor),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            side: const BorderSide(color: Color(0xFFE1E2E7)),
                          ),
                          label: StringText_letterspacing(
                              particitationButtonText,
                              14,
                              FontWeight.w700,
                              const Color(0xff5E5F68),
                              -0.5)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: OutlinedButton.icon(
                          icon: SvgPicture.asset(
                              "assets/icons/detail/invite.svg"),
                          onPressed: () {
                            if (Meet.isInsert) {
                              //리스트 안에 있음
                              if (curUserNum < Meet.peopleLimit) {
                                // 인원수 안 넘침
                                showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(24)),
                                    ),
                                    builder: (BuildContext context) {
                                      return Invitaiton(
                                          meetNo: Meet.meetNo,
                                          userNo: tempUser['userNo'],
                                          userLimit: Meet.peopleLimit,
                                          curUserNum: curUserNum);
                                    });
                              } else {
                                // 인원수 넘침
                                null;
                                showToast('모집 인원을 초과하여 초대할 수 없습니다');
                              }
                            } else {
                              //리스트 안에 없음
                              null;
                              showToast('참가하지 않은 건수에서는 초대할 수 없습니다');
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Color(inviationButtonColor),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            side: const BorderSide(color: Color(0xFFE1E2E7)),
                          ),
                          label: StringText_letterspacing('초대', 14,
                              FontWeight.w700, const Color(0xff5E5F68), -0.5)),
                    ),
                  ),
                ]), //참가하기, 초대하기 버튼

                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 46,
                  child: OutlinedButton(
                    onPressed: () {
                      // 채팅방 입장
                      print(Meet.userList.toString());
                      print(Meet.peopleNum.toString());
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xff4874EA),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/icons/detail/chatting.svg"),
                        const SizedBox(width: 8),
                        StringText_letterspacing(
                            '채팅방 입장', 14, FontWeight.w700, Colors.white, -0.5),
                      ],
                    ),
                  ),
                ), //채팅방 입장 버튼

                const SizedBox(height: 16),
                line(),

                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 50,
                        child: StringText_letterspacing(
                            '내용', 12, FontWeight.w700, Colors.black, -0.5)),
                    const SizedBox(width: 16),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: StringText_letterspacing(Meet.content, 14,
                          FontWeight.w400, const Color(0xff5E5F68), -0.5),
                    ),
                  ],
                ), //모임 내용

                const SizedBox(height: 16),
                line(),

                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 50,
                        child: StringText(
                            '시간', 12, FontWeight.w700, Colors.black)),
                    const SizedBox(width: 16),
                    StringText_letterspacing(
                        DateFormat('yyyy 년 MM 월 dd 일 hh:mm').format(Meet.time),
                        14,
                        FontWeight.w400,
                        const Color(0xff5E5F68),
                        -0.5),
                  ],
                ), //모임 날짜 및 시각

                const SizedBox(height: 16),
                line(),

                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 50,
                        child: StringText_letterspacing(
                            '장소', 12, FontWeight.w700, Colors.black, -0.5)),
                    const SizedBox(width: 16),
                    StringText_letterspacing(Meet.address, 14, FontWeight.w400,
                        const Color(0xff5E5F68), -0.5),
                  ],
                ), //모임 장소

                const SizedBox(height: 16),
                Center(
                  child: KakaoMapView(
                    height: 200,
                    width: double.infinity,
                    lat: double.parse(Meet.lat),
                    lng: double.parse(Meet.lon),
                    kakaoMapKey: kakaoMapKey,
                    customOverlay: '''
                  function addMarker(content, position){
                    var marker = new kakao.maps.CustomOverlay({
                      position: position,
                      content: content,
                      yAnchor: 1
                    });
                    marker.setMap(map);
                  }
                  
                  marker.setMap(null);
                  var position = new kakao.maps.LatLng(${double.parse(Meet.lat)}, ${double.parse(Meet.lon)});
                  var content = '<div class="customoverlay">' +
                   '    <span class="title">' + '$pinInformation' + '</span>' +
                   '</div>';
                  addMarker(content, position);
                  
                  kakao.maps.event.addListener(map, 'click', function(){
                      onTapMarker.postMessage('Map is clicked');
                    }
                  );
                  
                  ''',
                    customOverlayStyle: '''<style>
                      .customoverlay {position:relative;border-radius:20px;background:#E91E63;color:#FFF;padding:5px;max-width:200px;}
                      .customoverlay .title {text-align:center;color:#FFF;padding:5px 8px;font-size:10px;font-weight:700;}
                      .customoverlay::before {content: '';position: absolute;top: 100%;left: 50%;margin-left: -8px;border: 8px solid transparent;border-top-color: #E91E63;}
                      </style>''',
                    onTapMarker: (message) {
                      if (message.message == 'Map is clicked') {
                        findLocation();
                      }
                    },
                  ),
                ), //지도 출력

                const SizedBox(height: 16),
                line(),

                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 50,
                        child: StringText_letterspacing(
                            '참여연령', 12, FontWeight.w700, Colors.black, -0.5)),
                    const SizedBox(width: 16),
                    StringText_letterspacing(Meet.age, 14, FontWeight.w400,
                        const Color(0xff5E5F68), -0.5),
                    //age(Meet.age, Meet.hostage),
                  ],
                ), //참여 연령 제한

                const SizedBox(height: 16),
                line(),

                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 50,
                        child: StringText_letterspacing(
                            '참가비', 12, FontWeight.w700, Colors.black, -0.5)),
                    const SizedBox(width: 16),
                    StringText_letterspacing('${Meet.fee}원', 14,
                        FontWeight.w400, const Color(0xff5E5F68), -0.5),
                  ],
                ), //참가비

                const SizedBox(height: 16),
                line(),

                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 50,
                        child: StringText_letterspacing(
                            '참가 인원', 12, FontWeight.w700, Colors.black, -0.5)),
                    const SizedBox(width: 16),
                    StringText_letterspacing(
                        '$curUserNum명 참여중 / 최대 ${Meet.peopleLimit} 명까지',
                        14,
                        FontWeight.w400,
                        const Color(0xff5E5F68),
                        -0.5),
                  ],
                ), //참가 인원

                const SizedBox(height: 28),
                Column(
                  children: Meet.userList.map((user) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.account_circle), //유저 아이콘
                              const SizedBox(
                                width: 10,
                              ),
                              StringText_letterspacing(user['username'], 12,
                                  FontWeight.w700, Colors.black, -0.5),
                            ],
                          ),
                          userList(user, Meet.userNo)
                        ],
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 18),
                line(),

                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                      width: 50,
                      child: StringText_letterspacing('댓글', 12, FontWeight.w700,
                          const Color(0xffAEAFB3), -0.5)),
                ), //댓글

                //const SizedBox(height: 16,),
                Column(
                  children: Meet.comments.asMap().entries.map((c) {
                    return Column(
                      children: [
                        CommentContainer(context, c.value, c.key),
                      ],
                    );
                  }).toList(),
                ),

                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Comments(
                                    meetNo: Meet.meetNo,
                                  )));
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xffF0F1F5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: Center(
                        child: StringText_letterspacing('전체 댓글 보기', 14,
                            FontWeight.w700, const Color(0xffA8A8B2), -0.5)),
                  ),
                ), //전체 댓글 보기 버튼

                const SizedBox(height: 24),
              ],
            ),
          ),
        ]));
  }
}

Widget age(String ageSet, int age) {
  if (ageSet.compareTo('전연령') != 0) {
    return Row(
      children: [
        IntText(age - 5, 14, FontWeight.w400, const Color(0xff5E5F68)),
        StringText(' ~ ', 14, FontWeight.w400, const Color(0xff5E5F68)),
        IntText(age + 5, 14, FontWeight.w400, const Color(0xff5E5F68)),
      ],
    );
  } else {
    return StringText('연령 제한 없음', 14, FontWeight.w400, const Color(0xff5E5F68));
  }
} //연령 제한 여부

Widget line() {
  return const Divider(
    height: 1,
    color: Color(0xffF0F1F5),
    thickness: 1.0,
  );
}

Widget userList(Map user, int hostNo) {
  if (hostNo == user['userNo']) {
    return Row(
      children: [
        SvgPicture.asset("assets/icons/detail/host.svg"),
        const SizedBox(
          width: 4,
        ),
        StringText_letterspacing(
            '호스트', 12, FontWeight.w400, const Color(0xffB78C00), -0.5),
      ],
    );
  } else {
    return Row(
      children: [
        SvgPicture.asset("assets/icons/detail/participant.svg"),
        const SizedBox(
          width: 4,
        ),
        StringText_letterspacing(
            '참여자', 12, FontWeight.w400, const Color(0xff999999), -0.5),
      ],
    );
  }
}

class MeetImage extends StatefulWidget {
  const MeetImage(this.meetImage, {Key? key}) : super(key: key);
  final List<String> meetImage;

  @override
  _MeetImageState createState() => _MeetImageState(meetImage);
}

class _MeetImageState extends State<MeetImage> {
  _MeetImageState(this.meetImage);

  final List<String> meetImage;

  final PageController _controller =
      PageController(viewportFraction: 1, initialPage: 0, keepPage: true);
  int currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return meetImage.isEmpty
        ? const SizedBox.shrink()
        : SizedBox(
            height: 252,
            width: size.width,
            child: Stack(
              children: [
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  onPageChanged: (int page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  itemCount: meetImage.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(
                      meetImage[index],
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
                      for (int i = 0; i < meetImage.length; i++)
                        _buildPageIndicator((i == currentPage.round()))
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
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
