// 위치 선택 위젯

// 최종 수정일 : 2023.5.28
// 작업자 : 김혁

// 추가 작업 예정 사항
// 서버에서 위치 정보 받아오기
// 받아온 위치 정보로 지도 출력

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../setting/registerMeeting.dart' as meet;
import 'meetTime.dart';
import '../../data/apiKey.dart';

class MeetingLocation extends StatefulWidget {
  const MeetingLocation({Key? key}) : super(key: key);

  @override
  State<MeetingLocation> createState() => _MeetingLocationState();
}

class _MeetingLocationState extends State<MeetingLocation> {
  bool meetTime = false;
  bool enabled = true;
  String meetLocation = "";

  final String KakaoAPIUrl = "https://dapi.kakao.com/v2/local/search/keyword.json";
  final headers = {
    'Authorization':'KakaoAK $KakaoRestAPIKey'
  };

  String searchText = '';
  List<dynamic> searchResults = [];

  TextEditingController _controller = TextEditingController();

  void categoryChange(){
    setState(() {
      if(enabled){
        meetTime = true;
        enabled = false;
      }else{
        enabled = true;
      }
    });
  }

  void _searchAddress(String query) async {
    final url = Uri.parse("$KakaoAPIUrl?query=$query");
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final docs = jsonResponse['documents'].toList();

      setState(() {
        searchResults = docs;
      });
    } else {
      throw Exception('Failed to load address');
    }
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(searchResults[index]['address_name']),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        enabled? Column(
          children: [
            meet.Title(content:"어디서 만날까요?"),
            Container(
              width: size.width,
              margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6FA),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextButton(
                onPressed: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)
                      )),
                      context: context,
                      builder: (BuildContext barcontext){
                        return Container(
                          height: 600,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Spacer(flex: 30),
                                  const Text("위치",
                                    style: TextStyle(
                                        color: Color(0xFF1F2024),
                                        fontFamily: "PretendardBold",
                                        fontSize: 16),
                                  ),
                                  const Spacer(flex : 24),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: (){
                                      Navigator.pop(barcontext);
                                    },
                                  ),
                                ],
                              ),
                              Container(
                                height: 46,
                                width: size.width,
                                padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                                margin: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F6FA),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextField(
                                  controller: _controller,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.search, size: 20, color: Color(0xFFBFC0C7)),
                                    hintText: '검색할 위치를 입력해주세요.',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFC8C8CB),
                                      fontSize: 14,
                                      fontFamily: "PretendardRegular"
                                    ),
                                  ),
                                  onChanged: (text){
                                    searchText = text;
                                  },
                                  onTap: (){
                                    meetLocation = "강남역 2호선";
                                    categoryChange();
                                    Navigator.pop(barcontext);
                                  },
                                ),
                              ),
                              Expanded(child: _buildSearchResults()),
                            ],
                          ),
                        );
                      }
                  );
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("위치를 선택해 주세요.",
                    style: TextStyle(
                        fontFamily: "PretendardRegular",
                        fontSize: 15,
                        color: Color(0xFFC8C8CB)),
                  ),
                ),
              ),
            ),
          ],
        ): Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: TextButton(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(meetLocation,
                  style: const TextStyle(
                      fontFamily: "PretendardBold",
                      fontSize:15,
                      color: Color(0xFF2F3036))
              ),
            ),
            onPressed: () {
              categoryChange();
            },
          ),
        ),
        meetTime? MeetingTime()
            :const SizedBox.shrink()
      ],
    );
  }
}
