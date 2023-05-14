// 위치 설정 페이지

// 최종 수정일 : 2023.5.14
// 작업자 : 김혁

// 추가 작업 예정 사항
// 적용 버튼 입력 시 서버에서 데이터 받아오기
// 리스트 박스 선택 시 메인 페이지에게 위,경도 값 주기

import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationState();
}

class _LocationState extends State<LocationPage> {
  TextEditingController controller = TextEditingController();

  String inputString = "";
  List addressList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text('위치 설정',
            style: TextStyle(color: Colors.black,
                fontFamily: 'PretendardBold')),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('검색하고자 하는 지역의 동 이름을 입력해 주세요.',
              style: TextStyle(fontFamily: "PretendardBold", color: Color(0xFF2F3036)),
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                      onChanged: (text){
                        setState(() {
                          inputString = text;
                        });
                      },
                        maxLines: 1,
                        decoration: const InputDecoration(
                          labelText: "예)용산동, 이곡동",
                          filled: true,
                          fillColor: Color(0xFFF5F6FA),
                          floatingLabelStyle: TextStyle(
                              fontFamily: "PretendardRegular", fontSize: 5, color: Color(0xFFC8C8CB)),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        controller: controller)
                ),
                ElevatedButton(
                    onPressed: (){

                      setState(() {
                        addList();
                      });
                    },
                    child: Text('검색')
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(5),
                itemCount: addressList.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          print(addressList[index]);
                          Navigator.pop(context);
                        },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black)
                            ),
                            height: 50,
                            child: Text('${addressList[index]}',
                              style: TextStyle(color: Colors.black)),
                          ),
                      ),
                    ],
                  );
                }
              )
            ),
          ],
        ),
      ),
    );
  }

  void addList (){
    addressList.add("서울특별시 성동구 성수동");
    for(var i = 0; i < 10; i++) {
      addressList.add("서울특별시 성동구 성수동 2 가 성동구 성수동 $i가");
    }
  }
}

