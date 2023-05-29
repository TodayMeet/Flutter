// 이미지 선택 위젯

// 최종 수정일 : 2023.5.28
// 작업자 : 김혁

// 추가 작업 예정 사항
// 이미지 추가하고 뺴는 알고리즘 추가하기
// row 출력 충돌 해결하기

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../setting/registerMeeting.dart' as meet;
import 'meetApproval.dart';

class MeetingImage extends StatefulWidget {
  const MeetingImage({Key? key}) : super(key: key);

  @override
  State<MeetingImage> createState() => _MeetingImageState();
}

class _MeetingImageState extends State<MeetingImage> {
  String content = "";
  bool enabled = true;
  bool isChecked = false;
  int imageCount = 0;

  final List<File?> _imageFiles = List.filled(5,null);
  final _imagePicker = ImagePicker();

  Future<void> _pickImages() async{
    List<XFile>? images = await _imagePicker.pickMultiImage(
        maxHeight: 1920, maxWidth: 1080, imageQuality: 50);

    setState(() {
      for (int i = 0; i < 5; i++) {
        if (imageCount < 4 && i < images.length) {
          _imageFiles[imageCount++] = File(images[i].path);
        } else {
          _imageFiles[i] = null;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double imageSize = MediaQuery.of(context).size.width * 0.2;
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        enabled? Column(
            children: [
              meet.Title(content:"참고 이미지를\n등록해주세요.(선택)"),
              Container(
                margin: const EdgeInsets.fromLTRB(24.0, 5.0, 24.0, 5.0),
                alignment: Alignment.centerLeft,
                child: const Text("5장까지 등록 가능",
                    style: TextStyle(fontFamily: "PretendardRegular",
                        fontSize: 14, color: Color(0xff2f3036))),
              ),
              Expanded(
                child: Row(
                  children: [
                    imageCount < 4
                    ? SizedBox(
                      height: imageSize,
                      width: imageSize,
                      child: ElevatedButton(
                        onPressed: _pickImages,
                        child: Center(child: Text("($imageCount/5)")),
                      ),
                    ): const SizedBox.shrink(),
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index){
                        return _imageFiles[index] != null
                            ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: imageSize,
                                height: imageSize,
                                margin: EdgeInsets.all(8),
                                child: Image.file(_imageFiles[index]!),
                              ),
                        ): const SizedBox.shrink();
                    }),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12)),
                height: 46,
                width: size.width,
                margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: TextButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFF0F1F5)),
                    alignment: Alignment.center,
                  ),
                  onPressed: (){
                    setState(() {
                      enabled = false;
                      isChecked = true;
                      meet.meetInfo.content = content;
                    });
                  },
                  child: const Text('다음',
                    style: TextStyle(
                        color: Color(0xFF2F3036),
                        fontSize: 14,
                        fontFamily: 'PretendardBold'
                    ),
                  ),
                ),
              )
            ]
        ): Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xFFF5F6FA),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: TextButton(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(content,
                  style: const TextStyle(
                      fontFamily: "PretendardBold",
                      fontSize:15,
                      color: Color(0xFF2F3036))
              ),
            ),
            onPressed: () {
              setState(() {
                enabled = true;
              });
            },
          ),
        ),
        isChecked? MeetingApproval()
            : const SizedBox.shrink(),
      ],
    );
  }
}
