// 위치 선택 위젯

// 최종 수정일 : 2023.6.23
// 작업자 : 김혁

// 추가 작업 예정 사항
// 현재 위치 가져오기 할 시 근처에 건물 없을 시 처리

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

import '../setting/registerMeeting.dart' as meet;
import 'meetTime.dart';
import '../../data/apiKey.dart';
import '../../model/setting/location.dart';

class MeetingLocation extends ConsumerStatefulWidget {
  const MeetingLocation({Key? key}) : super(key: key);

  @override
  MeetingLocationState createState() => MeetingLocationState();
}

class MeetingLocationState extends ConsumerState<MeetingLocation> {
  bool meetTime = false;
  bool enabled = true;
  bool isPicked = false;
  String meetLocation = "";
  String meetAddress = "";
  late Size size;

  final String kakaoAPIUrl =
      "https://dapi.kakao.com/v2/local/search/keyword.json";
  final headers = {'Authorization': 'KakaoAK $KakaoRestAPIKey'};

  final ValueNotifier<List<dynamic>> searchResults = ValueNotifier([]);
  final ValueNotifier<String> _searchTerm = ValueNotifier('');
  late final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _searchTerm.dispose();
    searchResults.dispose();
    super.dispose();
  }

  void categoryChange() {
    setState(() {
      if (enabled) {
        meetTime = true;
        enabled = false;
      } else {
        enabled = true;
      }
    });
  }

  // 위치 검색 함수
  void _searchAddress() async {
    final query = _searchTerm.value;
    if (_searchTerm.value.isNotEmpty) {
      final url = Uri.parse("$kakaoAPIUrl?query=$query");
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final docs = jsonResponse['documents'].toList();

        setState(() {
          searchResults.value = docs;
        });
      } else {
        throw Exception('Failed to load address');
      }
    } else {
      searchResults.value = [];
    }
  }

  // 위치 검색 시 나오는 list
  Widget _buildSearchResults(BuildContext context) {
    return ListView.builder(
      itemCount: searchResults.value.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            meetLocation = searchResults.value[index]['place_name'];
            meetAddress = searchResults.value[index]['address_name'];
            meet.meetInfo.address = meetLocation;
            meet.meetInfo.lat = searchResults.value[index]['y'];
            meet.meetInfo.lon = searchResults.value[index]['x'];
            Navigator.pop(context);
            _showlocationmap();
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(24, 6, 24, 6),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F1F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(searchResults.value[index]['place_name'],
                    style: const TextStyle(
                      color: Color(0xFF2F3036),
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      letterSpacing: -0.5,
                    )),
                const SizedBox(height: 4),
                Text(searchResults.value[index]['address_name'],
                    style: const TextStyle(
                      color: Color(0xFF2F3036),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: -0.5,
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  // 현재 위치 정보 받아오기
  Future _getLocationData(BuildContext barcontext) async {
    Location location = Location();
    await location.getCurrentLocation();

    var userLat = location.latitude;
    var userLong = location.longitude;

    var kakaoGeoUrl = Uri.parse(
        'https://dapi.kakao.com/v2/local/geo/coord2address.json?x=$userLong&y=$userLat');
    var kakaoGeo = await http.get(kakaoGeoUrl,
        headers: {"Authorization": "KakaoAK $KakaoRestAPIKey"});
    if (kakaoGeo.statusCode == 200) {
      final addrData = json.decode(kakaoGeo.body);
      print(addrData);

      if (addrData['documents'][0]['road_address'] == null) {
        meetLocation = addrData['documents'][0]['address']['address_name'];
        meetAddress = '';
        meet.meetInfo.address = meetLocation;
      } else {
        meetLocation =
            addrData['documents'][0]['road_address']['building_name'];
        meetAddress = addrData['documents'][0]['road_address']['address_name'];
        meet.meetInfo.address = meetLocation;
      }

      meet.meetInfo.lat = userLat.toString();
      meet.meetInfo.lon = userLong.toString();
      Navigator.pop(barcontext);
      _showlocationmap();
    } else {
      throw Exception('Failed to load my location');
    }
  }

  // 현재 위치 선택하는 위젯
  Widget _pickNowLocation(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            _getLocationData(context);
          },
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.fromLTRB(24, 7, 24, 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFF0F1F5),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/current_location.svg",
                  height: 20,
                  width: 20,
                ),
                const SizedBox(width: 6),
                const Text('현재 위치로 선택',
                    style: TextStyle(
                      color: Color(0xFF2F3036),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: -0.5,
                    )),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(24, 50, 24, 0),
          child: const Text('정확한 약속 장소가 잡히지 않았다면 강남역, 압구정동 같은 대략적인 위치를 입력해 보세요',
              style: TextStyle(
                  color: Color(0xFF2F3036),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: -0.5)),
        ),
      ],
    );
  }

  // 위치 검색하는 창
  void _showsearching() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            _focusNode.requestFocus();
          });
          return Container(
              height: 521,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 30,
                      blurStyle: BlurStyle.outer)
                ],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  AppBar(
                      toolbarHeight: 50,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(24))),
                      backgroundColor: Colors.white,
                      elevation: 0,
                      centerTitle: true,
                      title: const Text(
                        "위치",
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
                              height: 20,
                              width: 20,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ]),

                  Container(
                    height: 46,
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    margin: const EdgeInsets.fromLTRB(24.0, 5.0, 24.0, 5.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      focusNode: _focusNode,
                      maxLines: 1,
                      //controller: _controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: SvgPicture.asset(
                          "assets/icons/search.svg",
                        ),
                        hintText: '검색할 위치를 입력해주세요.',
                        hintStyle: const TextStyle(
                          color: Color(0xFFC8C8CB),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.5,
                        ),
                      ),
                      onSubmitted: (text) {
                        _searchTerm.value = text;
                        _searchAddress();
                      },
                    ),
                  ),

                  // 입력 전에는 현재 위치 선택 / 입력 후에는 입력 된 정보로 검색
                  ValueListenableBuilder<List<dynamic>>(
                    valueListenable: searchResults,
                    builder: (BuildContext context, List<dynamic> value,
                        Widget? child) {
                      if (value.isEmpty) {
                        return _pickNowLocation(context);
                      } else {
                        return Expanded(child: _buildSearchResults(context));
                      }
                    },
                  ),
                ],
              ));
        });
  }

  void _showlocationmap() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        context: context,
        builder: (BuildContext barcontext) {
          return Container(
              height: 521,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 30,
                      blurStyle: BlurStyle.outer)
                ],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  AppBar(
                    toolbarHeight: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    centerTitle: true,
                    leading: IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/back_icon.svg",
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        Navigator.pop(barcontext);
                        _showsearching();
                      },
                    ),
                    title: const Text('선택한 위치 확인',
                        style: TextStyle(
                            color: Color(0xFF1F2024),
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            letterSpacing: 0.09)),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            "assets/icons/close.svg",
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {
                            Navigator.pop(barcontext);
                          },
                        ),
                      ),
                    ],
                  ),

                  Container(
                    height: 330,
                    width: size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFFF0F1F5)
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: KakaoMapView(
                            width: size.width * 0.95,
                            height: size.height * 0.4,
                            kakaoMapKey: kakaoMapKey,
                            lat: double.parse(meet.meetInfo.lat),
                            lng: double.parse(meet.meetInfo.lon),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(29, 11, 29, 11),
                          child: Column(
                            children: [
                              Align(
                                alignment:Alignment.centerLeft,
                                child: Text(
                                  meet.meetInfo.address,
                                  style: const TextStyle(
                                      color: Color(0xFF2F3036),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      letterSpacing: -0.5),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  meetAddress,
                                  style: const TextStyle(
                                    color: Color(0xFF2F3036),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      categoryChange();
                      Navigator.pop(barcontext);
                    },
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xFFF0F1F5)),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/current_location.svg",
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 6),
                          const Text('이 위치로 설정',
                              style: TextStyle(
                                color: Color(0xFF2F3036),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                letterSpacing: -0.5,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Column(
      children: [
        enabled
            ? Column(
                children: [
                  meet.Title(content: "어디서 만날까요?"),
                  Container(
                    width: size.width,
                    margin: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6FA),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextButton(
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                      onPressed: () {
                        _showsearching();
                      },
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "위치를 선택해 주세요.",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xFFC8C8CB),
                              letterSpacing: -0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFC5C6CC), width: 1),
                ),
                child: TextButton(
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                          EdgeInsets.all(16))),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(meetLocation,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xFF2F3036),
                          letterSpacing: -0.5,
                        )),
                  ),
                  onPressed: () {
                    categoryChange();
                  },
                ),
              ),
        meetTime ? const MeetingTime() : const SizedBox.shrink()
      ],
    );
  }
}
