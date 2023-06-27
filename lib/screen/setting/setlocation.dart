// 위치 설정 페이지

// 최종 수정일 : 2023.6.22
// 작업자 : 김혁

// 추가 작업 예정 사항
// 적용 버튼 입력 시 서버에서 데이터 받아오기
// 메인 페이지 갈 때 왼쪽 위에 동 정보 바꾸기

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../model/setting/mapClass.dart';
import '../mainMap/mainPageMap.dart';

class LocationPage extends ConsumerWidget {
  LocationPage({super.key});

  final TextEditingController controller = TextEditingController();
  final List<Address> addressList = [];
  final addressStringProvider = StateProvider<String>((ref) => "");
  final addressListProvider = StateProvider<List<Address>?>((ref)=>null);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                        onPressed: (){
                          addList();
                          ref.read(addressListProvider.notifier).state = addressList;
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

  void addList (){
    addressList.add(Address(address: "대구광역시 북구 산격동", latitude: 0, longitude:0));
    for(var i = 1; i < 5; i++) {
      addressList.add(
          Address(address:"대구광역시 북구 산격 $i동", latitude:0, longitude:0));
    }
  }
}

ListView addressListView(List<Address>? lists, WidgetRef ref){
  if(lists == null || lists.isEmpty){
    return ListView(
      children: const [SizedBox(height: 0)],
    );
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
                      map.panTo(new kakao.maps.LatLng(33.450701, 126.570667));
                      '''
                  );

                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(lists[index].address,
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
