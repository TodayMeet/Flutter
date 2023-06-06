// 위치 설정 페이지

// 최종 수정일 : 2023.5.19
// 작업자 : 김혁

// 추가 작업 예정 사항
// 적용 버튼 입력 시 서버에서 데이터 받아오기
// 메인 페이지 갈 때 왼쪽 위에 동 정보 바꾸기

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          title: const Text('위치 설정',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'PretendardBold',
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
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('검색하고자 하는 지역의 동 이름을 입력해 주세요.',
                style: TextStyle(
                    fontFamily: "PretendardBold",
                    color: Color(0xFF2F3036),
                    fontSize: 14,
                ),
              ),
              Container(
                width: size.width,
                margin: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          onTap: (){
                            ()=>ref.refresh(addressListProvider);
                          },
                          onChanged: (text){
                            ref.read(addressStringProvider.notifier).state = text;
                          },
                            maxLines: 1,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: "예)용산동, 이곡동",
                              filled: true,
                              fillColor: Color(0xFFF5F6FA),
                              floatingLabelStyle: TextStyle(
                                  fontFamily: "PretendardRegular", fontSize: 13, color: Color(0xFFC8C8CB)),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                            ),
                            controller: controller)
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
    for(var i = 1; i < 10; i++) {
      addressList.add(
          Address(address:"서울특별시 성동구 성수동 2 가 성동구 성수동 $i가", latitude:0, longitude:0));
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
        return Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFDBDBDB))
          ),
          height: 46,
          child: TextButton(
              onPressed: () async {
                final webViewController = ref.watch(mapControllerProvider);
                webViewController?.runJavascript(
                    '''
                    map.panTo(new kakao.maps.LatLng(33.450701, 126.570667));
                    '''
                );

                Navigator.pop(context);
              },
              child: Center(
                child: Text(lists[index].address,
                    style: const TextStyle(
                        color: Color(0xFF707070),
                        fontSize: 16,
                        fontFamily: 'PretendardBold',
                    )),
              ),
            ),
        );
      }
  );
}
