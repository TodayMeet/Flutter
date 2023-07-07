// 위치 설정 페이지

// 최종 수정일 : 2023.7.06
// 작업자 : 김혁

// 추가 작업 예정 사항
// 적용 버튼 입력 시 서버에서 데이터 받아오기

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front/screen/mainList/mainListBoard.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../../data/apiKey.dart';
import '../../data/map/address.dart';
import '../../model/showtoast.dart';
import '../mainMap/mainPageMap.dart';

class LocationPage extends ConsumerStatefulWidget {
  const LocationPage({super.key});

  @override
  LocationPageState createState() => LocationPageState();
}

class LocationPageState extends ConsumerState<LocationPage> {

  final TextEditingController controller = TextEditingController();
  final List<Address> addressList = [];
  final addressStringProvider = StateProvider<String>((ref) => "");
  final addressListProvider = StateProvider<List<Address>?>((ref)=>null);

  // 주소 검색하기
  Future<void> addList () async{
    String findquery = ref.watch(addressStringProvider);

    try {
      Dio dio = Dio();

      final response = await dio.get(
          'http://todaymeet.shop:8080/map/address?query=$findquery',
          queryParameters: {'query':findquery},
      );

      if (response.statusCode == 200){
        var serverData = response.data;
        addressList.clear();
        print(serverData);

        serverData.forEach((element) => addressList.add(Address.fromJson(element)));
      } else {
        print("서버 값 오류");
        showToast("서버 값 오류");
      }
    } catch(e) {
      print('검색 오류');
      showToast('검색 오류');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          title: const Text('위치설정',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 16
              )),
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black,
              iconSize: 24,
              icon: SvgPicture.asset(
                "assets/icons/back_icon.svg",
                height: 24,
                width: 24,
              ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('검색하고자 하는 지역의 동 이름을 입력해 주세요.',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2F3036),
                    fontSize: 14,
                ),
              ),
              Container(
                width: size.width,
                height: 46,
                margin: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                              onTap: (){
                                ()=>ref.refresh(addressListProvider);
                              },
                              onChanged: (text){
                                ref.read(addressStringProvider.notifier).state = text;
                              },
                              maxLines: 1,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "예)용산동, 이곡동",
                                filled: true,
                                fillColor: const Color(0xFFF5F6FA),
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: Color(0xFFC8C8CB),
                                    letterSpacing: -0.5
                                ),
                              ),
                              controller: controller),
                        )
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await addList();
                          ref.read(addressListProvider.notifier).state = addressList;
                          setState(() {});
                        },
                        child: const Text('검색')
                    ),
                  ],
                ),
              ),
              Expanded(
                child:addressListView(ref.watch(addressListProvider), ref)
              ),
            ],
          ),
        ),
      ),
    );
  }
}

ListView addressListView(List<Address>? lists, WidgetRef ref){
  if(lists == null || lists.isEmpty){
    return ListView(
      children: const [SizedBox(height: 0)],
    );
  }

  // 동 위치 받아오기
  Future<void> getDongName(double lat, double lon) async {
    var kakaoGeoUrl = Uri.parse(
        'https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=$lon&y=$lat');
    var kakaoGeo = await http.get(kakaoGeoUrl,
        headers: {"Authorization": "KakaoAK $KakaoRestAPIKey"});
    String addr = kakaoGeo.body;
    var addrData = jsonDecode(addr);
    print(addrData);

    final String dongName = addrData['documents'][0]['region_3depth_name'];
    ref.read(dongProvider.notifier).state = dongName;
  }

  return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: lists.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 12),
          child: SizedBox(
            height: 46,
            child: TextButton(
                style: ButtonStyle(
                  padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 24),
                  ),
                  side: const MaterialStatePropertyAll<BorderSide>(
                    BorderSide(
                      color: Color(0xFFDBDBDB),
                      width: 1,
                    )
                  ),
                  shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  )
                ),
                onPressed: () async {
                  final webViewController = ref.watch(mapControllerProvider);
                  webViewController?.runJavascript(
                      '''
                      map.panTo(new kakao.maps.LatLng(${lists[index].lat},${lists[index].lon}));
                      '''
                  );
                  await getDongName(double.parse(lists[index].lat), double.parse(lists[index].lon));
                  refreshController.requestRefresh();
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(lists[index].address_name,
                      style: const TextStyle(
                          color: Color(0xFF707070),
                          fontSize: 16,
                          fontWeight:FontWeight.w700,
                          letterSpacing: -0.5,
                          overflow: TextOverflow.ellipsis,
                      )),
                ),
              ),
          ),
        );
      }
  );
}
