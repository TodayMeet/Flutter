// 메인 지도 페이지

// 최종 수정일 : 2023.5.14
// 작업자 : 김혁

// 추가 작업 예정 사항
// 서버에서 받아온 모임 정보를 통해 핀 띄우기
// 위치 설정을 통해 받아온 정보로 지도 이동하기

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:front/screen/setting/setlocation.dart';
import 'package:front/model/setting/location.dart';
import 'package:front/model/bottomBar.dart';
import '../mainList/mainListBoard.dart';

const String kakaoMapKey = '61ebde2674fd1c5802aa0e27d589baba';
const String KakaoRestAPIKey = "639525c51e8f0aa63a256f74ddfe80ce";

class MainPageMap extends StatefulWidget {
  const MainPageMap({Key? key}) : super(key: key);

  @override
  State<MainPageMap> createState() => _MainPageMapState();
}

class _MainPageMapState extends State<MainPageMap> {
  double _lat = 33.450701;
  double _lng = 126.570667;
  String dong = "용산동";
  late final WebViewController _mapController;
  List<String> markerList = [];
  List markersLatitude = [];
  List markersLongitude = [];
  int markerCounts = 0;
  List<Map<String,double>> _markersLocation = [];

  Future<List> getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    var userLat = location.latitude;
    var userLong = location.longitude;
    var kakaoGeoUrl = Uri.parse('https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=$userLong&y=$userLat');
    var kakaoGeo = await http.get(kakaoGeoUrl, headers: {"Authorization": "KakaoAK $KakaoRestAPIKey"});
    String addr = kakaoGeo.body;
    var addrData = jsonDecode(addr);

    for(var i = 0; i < 10; i++){
      markerList.add("6.22 18:00 영화");
      markersLatitude.add(userLat + 0.0004 * i);
      markersLongitude.add(userLong + 0.0004 * i);
      _markersLocation.add({'latitude' : markersLatitude[i], 'longitude' : markersLongitude[i]});
    }

    markerCounts = markerList.length;

    String dongName = addrData['documents'][0]['region_3depth_name'];
    setState(() {
      dong = dongName;
    });

    return [location.latitude, location.longitude];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        leading: TextButton.icon(
            onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(
                builder: (context) => LocationPage()));
              },
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
            label: Text(dong,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'PretendardBold'),
            )),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("오늘의 건수",
            style: TextStyle(
              fontFamily: 'PretendardBold',
                color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder(       // 메인페이지 - 지도
          future: getLocationData(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.hasData == false) {
              return const CircularProgressIndicator();
            }
            else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 15),
                ),
              );
            }
            else {
              List loc = snapshot.data;
              _lat = loc[0];
              _lng = loc[1];
              return KakaoMapView(
                width: size.width,
                height: size.height * 0.9,
                kakaoMapKey: kakaoMapKey,
                lat: _lat,
                lng: _lng,
                mapController: (mapController){
                  _mapController = mapController;
                },
                cameraIdle: (message) async {
                  KakaoLatLng latLng = KakaoLatLng.fromJson(jsonDecode(message.message));
                  var userLat = latLng.lat;
                  var userLong = latLng.lng;
                  var kakaoGeoUrl = Uri.parse('https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=$userLong&y=$userLat');
                  var kakaoGeo = await http.get(kakaoGeoUrl, headers: {"Authorization": "KakaoAK $KakaoRestAPIKey"});
                  String addr = kakaoGeo.body;
                  var addrData = jsonDecode(addr);

                  String dongName = addrData['documents'][0]['region_3depth_name'];
                  setState(() {
                    dong = dongName;
                  });
                },
                customOverlayStyle: '''<style>
                  .customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
                  .customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
                  .customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
                  </style>''',
                customOverlay: '''
                var content = '<div class="customoverlay">' +
                    '    <span class="title">${markerList[0]}</span>' +
                    '</div>';

                var position = new kakao.maps.LatLng($_lat, $_lng);

                var customOverlay = new kakao.maps.CustomOverlay({
                    map: map,
                    position: position,
                    content: content,
                    yAnchor: 1
                });
                ''',
                onTapMarker: (message){
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message.message)));
                },
              );
            }
          },
        )
      ),
      bottomNavigationBar: const BottomAppBar(
        child: BottomBar()
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: <Widget> [
          Container(        // 현재 위치 설정
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            margin: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              heroTag: "현재 위치 불러오기",
              backgroundColor: const Color(0xFF4874EA),
              onPressed: () async {
                List location = await getLocationData();
                setState(() {
                  _mapController.runJavascript(
                      '''
                      map.panTo(new kakao.maps.LatLng(${location[0]},${location[1]}));
                      '''
                  );
                });
              },
              child: const Icon(Icons.place, color: Colors.white),
            ),
          ),
          Container(        // 게시판 화면
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            margin: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              heroTag: "게시판화면 이동",
              backgroundColor: const Color(0xFFFFFFFF),
              onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => MainListBoard()));
              },
              child: const Icon(Icons.list, color: Color(0xFF4874EA)),
            ),
          ),
        ],
      ),
    );
  }
}