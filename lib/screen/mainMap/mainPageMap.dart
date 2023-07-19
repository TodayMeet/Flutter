// 메인 지도 페이지

// 최종 수정일 : 2023.7.19
// 작업자 : 김혁

// 추가 작업해야 할 사항
// 핀 폰트 적용

import 'dart:convert';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/data/userNo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/setting/location.dart';
import '../../data/apiKey.dart';
import '../../data/map/pin.dart';
import '../../routes.dart';
import '../../model/showtoast.dart';
import '../mainList/Loading_to_ListDetail.dart';

final dongProvider = StateProvider<String>((ref) => "용산동");
final markerProvider = StateProvider<List<Pin>?>((ref) => null);
final mapControllerProvider = StateProvider<WebViewController?>((ref) => null);

class MainPageMap extends ConsumerStatefulWidget {
  const MainPageMap({super.key});

  @override
  MainPageMapState createState() => MainPageMapState();
}

class MainPageMapState extends ConsumerState<MainPageMap> {
  String pinInformationString = "";
  List<Pin> markersInfo = [];
  late double latitude;
  late double longitude;
  bool isLoaded = false;

  // 현재 위치, 동, 핀 정보 받아오기
  Future<void> getLocationData() async {
    try {
      // 현재 위치 데이터 받아오기
      Location location = Location();
      await location.getCurrentLocation();

      latitude = location.latitude;
      longitude = location.longitude;
      debugPrint('--------------------- 현재 위치 받아오기 완료 --------------------');

      // 동정보 업데이트
      await getDongName(latitude, longitude);

      // 핀 위치 정보 받아오기
      await getPinList(latitude.toString(), longitude.toString());
      setState(() {
        isLoaded = true;
      });
    } catch (e) {
      print('위치 정보 오류');
      showToast('위치 정보 오류');
    }
  }

  // 동 위치 받아오기
  Future<void> getDongName(double lat, double lon) async {
    var kakaoGeoUrl = Uri.parse(
        'https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=$lon&y=$lat');
    var kakaoGeo = await http.get(kakaoGeoUrl,
        headers: {"Authorization": "KakaoAK $KakaoRestAPIKey"});
    String addr = kakaoGeo.body;
    var addrData = jsonDecode(addr);

    final String dongName = addrData['documents'][0]['region_3depth_name'];
    ref.read(dongProvider.notifier).state = dongName;
    debugPrint('--------------------- 동 위치 받아오기 완료 --------------------');
  }

  // 핀 정보 받아오기
  Future<void> getPinList(String lat, String lon) async {
    try {
      final url = Uri.parse('http://todaymeet.shop:8080/map/meet/pinlist');
      var postBody = {
        "lat": lat,
        "lon": lon,
      };

      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(postBody),
      );

      if (response.statusCode == 200) {
        var serverData = jsonDecode(utf8.decode(response.bodyBytes));
        markersInfo.clear();
        serverData.forEach((element) => markersInfo.add(Pin.fromJson(element)));

        final List<Map<String, dynamic>> pinslist = [];
        for (var i = 0; i < markersInfo.length; i++) {
          String pintime =
              DateFormat("M.dd hh:mm").format(markersInfo[i].time);
          String category;
          switch (markersInfo[i].categoryname) {
            case "맛집":
              category = 'restaurant';
              break;
            case "카페":
              category = 'cafe';
              break;
            case "주류":
              category = 'alcohol';
              break;
            case "영화":
              category = 'movie';
              break;
            case "전시":
              category = 'exhibition';
              break;
            case "공연":
              category = 'performance';
              break;
            case "게임":
              category = 'game';
              break;
            case "봉사":
              category = 'service';
              break;
            case "독서":
              category = 'read';
              break;
            case "스터디":
              category = 'study';
              break;
            case "반려동물":
              category = 'pet';
              break;
            case "운동":
              category = 'exercise';
              break;
            default:
              category = 'restaurant';
              break;
          }
          pinslist.add({
            "str": '$pintime ${markersInfo[i].categoryname}',
            "latitude": markersInfo[i].lat,
            "longitude": markersInfo[i].lon,
            "categoryName": category,
            "meetNo": markersInfo[i].meetNo,
          });
        }
        pinInformationString = jsonEncode({'items': pinslist});
        debugPrint('--------------------- 핀 위치 받아오기 완료 --------------------');

        // 처음에 build 제외
        if (isLoaded == true) {
          final webViewController = ref.watch(mapControllerProvider);
          webViewController?.runJavascript('''
                    function addMarker(content, position, index){
                      var marker = new kakao.maps.CustomOverlay({
                        position: position,
                        content: content,
                      });
                      marker.setMap(map);
                      markers.push(marker);
                    }
                   
                    function clearMarkers(){
                      for(var i = 0; i < markers.length; i++) {
                        markers[i].setMap(null);
                      }
                      markers = [];
                    }
                    
                    function clickevent(index){
                      onTapMarker.postMessage(index);
                    }
                    
                    function acceptList(jsonString){
                      const data = JSON.parse(jsonString);
                      const items = data.items;
                      
                      clearMarkers();
                      
                      for(var i = 0; i < items.length; i++){
                        var position = new kakao.maps.LatLng(items[i].latitude, items[i].longitude);
                        var content;
                        switch (items[i].categoryName) {
                          case "restaurant":
                            content = '<div class="customoverlay_restaurant" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "cafe":
                            content = '<div class="customoverlay_cafe" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "alcohol":
                            content = '<div class="customoverlay_alcohol" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "movie":
                            content = '<div class="customoverlay_movie" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "exhibition":
                            content = '<div class="customoverlay_exhibition" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "performance":
                            content = '<div class="customoverlay_performance" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "game":
                            content = '<div class="customoverlay_game" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "service":
                            content = '<div class="customoverlay_service" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "read":
                            content = '<div class="customoverlay_read" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "study":
                            content = '<div class="customoverlay_study" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                             '</div>';
                            break;
                         case "pet":
                            content = '<div class="customoverlay_pet" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "exercise":
                            content = '<div class="customoverlay_exercise" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          default:
                            content = '<div class="customoverlay_restaurant" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                        }
                        addMarker(content, position, i);
                      }
                    }
                  
                    marker.setMap(null);
                    acceptList('$pinInformationString');
          ''');
        }
      } else {
        debugPrint('핀 정보 서버 오류');
        showToast('핀 정보 서버 오류');
      }
    } catch (e) {
      debugPrint('핀 정보 오류');
      showToast('핀 정보 오류');
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 110,
        leading: TextButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              Routes.setLocationPageRoute,
              arguments: false,
            );
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 12, top: 13, bottom: 13),
                child: Text(
                  ref.watch(dongProvider),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SvgPicture.asset(
                "assets/icons/drop_down.svg",
                height: 24,
                width: 24,
              ),
            ],
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "오늘의 건수",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: isLoaded == false
            ? const CircularProgressIndicator()
            : KakaoMapView(
                width: size.width,
                height: size.height,
                kakaoMapKey: kakaoMapKey,
                lat: latitude,
                lng: longitude,
                mapController: (mapController) {
                  ref.read(mapControllerProvider.notifier).state =
                      mapController;
                },
                // 카메라 이동 시 동 정보 업데이트
                cameraIdle: (message) async {
                  KakaoLatLng latLng =
                      KakaoLatLng.fromJson(jsonDecode(message.message));
                  latitude = latLng.lat!;
                  longitude = latLng.lng!;
                  getDongName(latitude, longitude);
                  getPinList(latitude.toString(), longitude.toString());
                },
                // 핀 출력 및 클릭 이벤트
                customOverlay: '''
                    var markers = [];
                    
                    function addMarker(content, position, index){
                      var marker = new kakao.maps.CustomOverlay({
                        position: position,
                        content: content,
                        clickable: true,
                      });
                      marker.setMap(map);
                      markers.push(marker);
                      
                      kakao.maps.event.addListener(marker, 'click', function() {
                        onTapMarker.postMessage('marker ' + index + ' is tapped');
                      });
                    }
                    
                    function clickevent(index){
                      onTapMarker.postMessage(index);
                    }
                    
                    function acceptList(jsonString){
                      const data = JSON.parse(jsonString);
                      const items = data.items;
                      
                      for(let i = 0; i < items.length; i++){
                        var position = new kakao.maps.LatLng(items[i].latitude, items[i].longitude);
                        var content;
                        switch (items[i].categoryName) {
                          case "restaurant":
                            content = '<div class="customoverlay_restaurant" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "cafe":
                            content = '<div class="customoverlay_cafe" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "alcohol":
                            content = '<div class="customoverlay_alcohol" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "movie":
                            content = '<div class="customoverlay_movie" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "exhibition":
                            content = '<div class="customoverlay_exhibition" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "performance":
                            content = '<div class="customoverlay_performance" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "game":
                            content = '<div class="customoverlay_game" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "service":
                            content = '<div class="customoverlay_service" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "read":
                            content = '<div class="customoverlay_read" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "study":
                            content = '<div class="customoverlay_study" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "pet":
                            content = '<div class="customoverlay_pet" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          case "exercise":
                            content = '<div class="customoverlay_exercise" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                          default:
                            content = '<div class="customoverlay_restaurant" onclick ="clickevent(' + items[i].meetNo + ')">' +
                            '    <span class="title">' + items[i].str + '</span>' +
                            '</div>';
                            break;
                        }
                        addMarker(content, position, i);
                      }
                    }
                  
                    marker.setMap(null);
                    acceptList('$pinInformationString');
                    ''',
                // 핀 - 커스텀 오버레이 스타일 -> 폰트 적용 필요
                customOverlayStyle: '''<style>
                      .customoverlay_restaurant {position:relative;border-radius:20px;background:#E91E63;color:#FFF;padding:5px 8px;max-width:200px;}
                      .customoverlay_restaurant .title {text-align:center;color:#FFF;font-size:10px;font-weight:400;}
                      .customoverlay_restaurant::before {content: '';position: absolute;top: 100%;left: 50%;margin-left: -5px;border: 5px solid transparent;border-top-color: #E91E63;}
                      .customoverlay_cafe {position:relative;border-radius:20px;background:#E91E63;color:#FFF;padding:5px 8px;max-width:200px;}
                      .customoverlay_cafe .title {text-align:center;color:#FFF;font-size:10px;font-weight:400;}
                      .customoverlay_cafe::before {content: '';position: absolute;top: 100%;left: 50%;margin-left: -5px;border: 5px solid transparent;border-top-color: #E91E63;}
                      .customoverlay_alcohol {position:relative;border-radius:20px;background:#3F51B5;color:#FFF;padding:5px 8px;max-width:200px;}
                      .customoverlay_alcohol .title {text-align:center;color:#FFF;font-size:10px;font-weight:400;}
                      .customoverlay_alcohol::before {content: '';position: absolute;top: 100%;left: 50%;margin-left: -5px;border: 5px solid transparent;border-top-color: #3F51B5;}
                      .customoverlay_movie {position:relative;border-radius:20px;background:#673AB7;color:#FFF;padding:5px 8px;max-width:200px;}
                      .customoverlay_movie .title {text-align:center;color:#FFF;font-size:10px;font-weight:400;}
                      .customoverlay_movie::before {content: '';position: absolute;top: 100%;left: 50%;margin-left: -5px;border: 5px solid transparent;border-top-color: #673AB7;}
                      .customoverlay_exhibition {position:relative;border-radius:20px;background:#607D8B;color:#FFF;padding:5px 8px;max-width:200px;}
                      .customoverlay_exhibition .title {text-align:center;color:#FFF;font-size:10px;font-weight:400;}
                      .customoverlay_exhibition::before {content: '';position: absolute;top: 100%;left: 50%;margin-left: -5px;border: 5px solid transparent;border-top-color: #607D8B;}
                      .customoverlay_performance {position:relative;border-radius:20px;background:#607D8B;color:#FFF;padding:5px 8px;max-width:200px;}
                      .customoverlay_performance .title {text-align:center;color:#FFF;font-size:10px;font-weight:400;}
                      .customoverlay_performance::before {content: '';position: absolute;top: 100%;left: 50%;margin-left: -5px;border: 5px solid transparent;border-top-color: #607D8B;}
                      .customoverlay_game {position:relative;border-radius:20px;background:#FF5722;color:#FFF;padding:5px 8px;max-width:200px;}
                      .customoverlay_game .title {text-align:center;color:#FFF;font-size:10px;font-weight:400;}
                      .customoverlay_game::before {content: '';position: absolute;top: 100%;left: 50%;margin-left: -5px;border: 5px solid transparent;border-top-color: #FF5722;}
                      .customoverlay_service {position:relative;border-radius:20px;background:##8BC34A;color:#FFF;padding:5px 8px;max-width:200px;}
                      .customoverlay_service .title {text-align:center;color:#FFF;font-size:10px;font-weight:400;}
                      .customoverlay_service::before {content: '';position: absolute;top: 100%;left: 50%;margin-left: -5px;border: 5px solid transparent;border-top-color: ##8BC34A;}
                      .customoverlay_read {position:relative;border-radius:20px;background:#374046;color:#FFF;padding:5px 8px;max-width:200px;}
                      .customoverlay_read .title {text-align:center;color:#FFF;font-size:10px;font-weight:400;}
                      .customoverlay_read::before {content: '';position: absolute;top: 100%;left: 50%;margin-left: -5px;border: 5px solid transparent;border-top-color: #374046;}
                      .customoverlay_study {position:relative;border-radius:20px;background:#9C27B0;color:#FFF;padding:5px 8px;max-width:200px;}
                      .customoverlay_study .title {text-align:center;color:#FFF;font-size:10px;font-weight:400;}
                      .customoverlay_study::before {content: '';position: absolute;top: 100%;left: 50%;margin-left: -5px;border: 5px solid transparent;border-top-color: #9C27B0;}
                      .customoverlay_pet {position:relative;border-radius:20px;background:#795548;color:#FFF;padding:5px 8px;max-width:200px;}
                      .customoverlay_pet .title {text-align:center;color:#FFF;font-size:10px;font-weight:400;}
                      .customoverlay_pet::before {content: '';position: absolute;top: 100%;left: 50%;margin-left: -5px;border: 5px solid transparent;border-top-color: #795548;}
                      .customoverlay_exercise {position:relative;border-radius:20px;background:#DCA966;color:#FFF;padding:5px 8px;max-width:200px;}
                      .customoverlay_exercise .title {text-align:center;color:#FFF;font-size:10px;font-weight:400;}
                      .customoverlay_exercise::before {content: '';position: absolute;top: 100%;left: 50%;margin-left: -5px;border: 5px solid transparent;border-top-color: #DCA966;}
                      </style>''',
                onTapMarker: (message) {
                  debugPrint('--------------- meetNo ${message.message} is clicked ---------------');
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => Loading_to_ListDetail(meetNo: int.parse(message.message), userNo: UserNo.myuserNo,)
                      )
                  );
                },
              ),
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: <Widget>[
          // 현재 위치 설정
          Container(
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
                await getLocationData();
                final webViewController = ref.watch(mapControllerProvider);
                webViewController?.runJavascript('''
                   map.panTo(new kakao.maps.LatLng($latitude,$longitude));
                   ''');
              },
              child: SvgPicture.asset(
                "assets/icons/location.svg",
              ),
            ),
          ),

          // 게시판 화면 이동
          Container(
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
                Navigator.pushNamed(context, Routes.boardPageRoute);
              },
              child: SvgPicture.asset(
                "assets/icons/list.svg",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
