// 메인 지도 페이지

// 최종 수정일 : 2023.5.19
// 작업자 : 김혁

// 추가 작업 예정 사항
// 서버에서 받아온 모임 정보를 통해 핀 띄우기
// 위치 설정을 통해 받아온 정보로 지도 이동하기

import 'dart:convert';
import 'dart:async';
import 'package:front/screen/alarm/alarm.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../setting/setlocation.dart';
import '../mainList/mainListBoard.dart';
import '../../model/setting/location.dart';
import '../../model/bottomBar.dart';
import '../../model/setting/mapClass.dart';
import '../../data/apiKey.dart';

final dongProvider = StateProvider<String>((ref) => "용산동");
final markerProvider = StateProvider<List<Markers>?>((ref) => null);
final mapControllerProvider = StateProvider<WebViewController?>((ref) => null);

class MainPageMap extends ConsumerWidget {
  MainPageMap({super.key});

  Future<List> getLocationData(WidgetRef ref) async {
    // 현재 위치 데이터 받아오기
    Location location = Location();
    await location.getCurrentLocation();

    var userLat = location.latitude;
    var userLong = location.longitude;

    // 동 위치 받아오기
    var kakaoGeoUrl = Uri.parse(
        'https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=$userLong&y=$userLat');
    var kakaoGeo = await http.get(kakaoGeoUrl,
        headers: {"Authorization": "KakaoAK $KakaoRestAPIKey"});
    String addr = kakaoGeo.body;
    var addrData = jsonDecode(addr);

    final String dongName = addrData['documents'][0]['region_3depth_name'];
    ref.read(dongProvider.notifier).state = dongName;

    // 핀 위치 정보 받아오기
    List<Markers> markersInfo = [];
    for (var i = 0; i < 10; i++) {
      markersInfo.add(Markers(
          time: '6.22 18:00',
          categoryName: '주류',
          meetNo: 1,
          personClose: 5,
          location:
              LocationLatLng(latitude: 33.450701, longitude: 126.570667)));
    }
    ref.read(markerProvider.notifier).state = markersInfo;

    return [userLat, userLong];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        leading: TextButton.icon(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LocationPage()));
            },
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
            label: Text(ref.watch(dongProvider),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'PretendardBold'),

            )),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "오늘의 건수",
          style: TextStyle(
              fontSize: 16, fontFamily: 'PretendardBold', color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => alarm()));
              },
              icon: Icon(
                Icons.notifications_none,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: FutureBuilder(
        // 메인페이지 - 지도
        future: getLocationData(ref),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 15),
              ),
            );
          } else {
            List loc = snapshot.data;
            return KakaoMapView(
              width: size.width,
              height: size.height * 0.9,
              kakaoMapKey: kakaoMapKey,
              lat: loc[0],
              lng: loc[1],
              mapController: (mapController) {
                ref.watch(mapControllerProvider.notifier).state = mapController;
              },
              cameraIdle: (message) async {
                KakaoLatLng latLng =
                    KakaoLatLng.fromJson(jsonDecode(message.message));
                var userLat = latLng.lat;
                var userLong = latLng.lng;
                var kakaoGeoUrl = Uri.parse(
                    'https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=$userLong&y=$userLat');
                var kakaoGeo = await http.get(kakaoGeoUrl,
                    headers: {"Authorization": "KakaoAK $KakaoRestAPIKey"});
                String addr = kakaoGeo.body;
                var addrData = jsonDecode(addr);

                String dongName =
                    addrData['documents'][0]['region_3depth_name'];
                ref.read(dongProvider.notifier).state = dongName;
              },
              customOverlay: '''
                function addMarker(content, position){
                  var marker = new kakao.maps.CustomOverlay({
                    position: position,
                    content: content,
                    yAnchor: 1
                  });
                  marker.setMap(map);
                }
                
                for(var i = 0; i < 3; i++){
                  var position = new kakao.maps.LatLng(${loc[0]}+0.001*i, ${loc[1]}+0.001*i);
                  var content = '<div class="customoverlay">' +
                    '    <span class="title">6.22 18:00 주류</span>' +
                    '</div>';
                  addMarker(content, position);
                }
                ''',
              customOverlayStyle: '''<style>
                  .customoverlay {position:relative;border-radius:20px;background:#E91E63;color:#FFF;padding:5px;max-width:200px;}
                  .customoverlay .title {text-align:center;color:#FFF;padding:5px 8px;font-size:10px;font-weight:700;}
                  .customoverlay::before {content: '';position: absolute;top: 100%;left: 50%;margin-left: -8px;border: 8px solid transparent;border-top-color: #E91E63;}
                  </style>''',
              onTapMarker: (message) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message.message)));
              },
            );
          }
        },
      )),
      bottomNavigationBar: const BottomAppBar(child: BottomBar()),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            // 현재 위치 설정
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
                List location = await getLocationData(ref);
                final webViewController = ref.watch(mapControllerProvider);
                webViewController?.runJavascript('''
                    map.panTo(new kakao.maps.LatLng(${location[0]},${location[1]}));
                    ''');
              },
              child: const Icon(Icons.place, color: Colors.white),
            ),
          ),
          Container(
            // 게시판 화면
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainListBoard()));
              },
              child: const Icon(Icons.list, color: Color(0xFF4874EA)),
            ),
          ),
        ],
      ),
    );
  }
}
