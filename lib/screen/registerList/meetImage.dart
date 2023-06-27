// 이미지 선택 위젯

// 최종 수정일 : 2023.6.26
// 작업자 : 김혁

// 추가 작업 예정 사항
// 이미지 추가하고 뺴는 알고리즘 추가하기
// x 버튼 구현하기

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';

import '../setting/registerMeeting.dart' as meet;
import 'meetApproval.dart';

class MeetingImage extends StatefulWidget {
  const MeetingImage({Key? key}) : super(key: key);

  @override
  State<MeetingImage> createState() => _MeetingImageState();
}

class _MeetingImageState extends State<MeetingImage> {
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
        if (imageCount < 5 && i < images.length) {
          _imageFiles[imageCount++] = File(images[i].path);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const double imageSize = 65;
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        enabled? Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 10.0),
                height: 58,
                alignment: Alignment.centerLeft,
                  child: const Text("참고 이미지를\n등록해주세요.(선택)",
                      style:  TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        color: Color(0xff2f3036)
                      )
                  ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                alignment: Alignment.centerLeft,
                child: const Text("5장까지 등록 가능",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xff2f3036),
                    )
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                height: 65,
                child: Row(
                  children: [
                    imageCount < 5
                    ? Container(
                      margin: const EdgeInsets.only(right: 6),
                      child: DottedBorder(
                        color: Colors.black,
                        dashPattern: const [4, 2],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(8),
                        child: SizedBox(
                          height: imageSize,
                          width: imageSize,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.transparent
                            ),
                            onPressed: _pickImages,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/icons/picture.svg"),
                                Text("($imageCount/5)",
                                  style: const TextStyle(
                                    color: Color(0xFF2F2F2F),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -1,
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ): const SizedBox.shrink(),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index){
                          return _imageFiles[index] != null
                              ? Container(
                                width: imageSize,
                                height: imageSize,
                                margin: const EdgeInsets.only(right: 8),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(_imageFiles[index]!,
                                        fit: BoxFit.fill
                                    )
                                ),
                              ): const SizedBox.shrink();
                      }),
                    ),
                  ],
                ),
              ),
              Container(
                height: 46,
                width: size.width,
                margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFF0F1F5)),
                    alignment: Alignment.center,
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                    )
                  ),
                  onPressed: (){
                    setState(() {
                      enabled = false;
                      isChecked = true;
                    });
                  },
                  child: const Text('다음',
                    style: TextStyle(
                        color: Color(0xFF2F3036),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                    ),
                  ),
                ),
              )
            ]
        ): imageCount == 0 ? const SizedBox.shrink()
          :Container(
            height: 60,
            margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index){
                return _imageFiles[index] != null
                    ? Container(
                        width: imageSize,
                        height: imageSize,
                        margin: const EdgeInsets.only(right: 6),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(_imageFiles[index]!,
                                fit: BoxFit.cover
                            )
                        ),
                    ): const SizedBox.shrink();
                }
              ),
        ),
        isChecked? const MeetingApproval()
            : const SizedBox.shrink(),
      ],
    );
  }
}
