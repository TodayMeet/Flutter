// 이미지 선택 위젯

// 최종 수정일 : 2023.7.19
// 작업자 : 김혁

// 추가 작업 예정 사항
// 이미지 중복 처리

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

  final List<XFile> _imageFiles = [];
  final List<File> _showFiles = [];
  final _imagePicker = ImagePicker();

  // 이미지 선택
  Future<void> _pickImages() async{
    List<XFile>? images = await _imagePicker.pickMultiImage(
        maxHeight: 1920, maxWidth: 1080, imageQuality: 50);

    if(images.isEmpty){
      return;
    }

    for(final image in images ?? []){
      final file = File(image.path);
      if(_imageFiles.length < 5 && !_imageFiles.contains(image)){
        setState(() {
          _imageFiles.add(image);
          _showFiles.add(file);
          imageCount++;
        });
      }
    }
  }

  // 선택한 이미지 제거
  void removeImage(int index) {
    setState(() {
      _showFiles.removeAt(index);
      _imageFiles.removeAt(index);
      imageCount--;
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
              // 이미지 선택 title
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

              // 이미지 선택 및 출력
              Container(
                margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                height: 89,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    imageCount < 5                // 선택한 이미지가 5개 이하인 경우
                    ? Container(
                      margin: const EdgeInsets.only(right: 6),
                      child: DottedBorder(
                        color: Colors.black,
                        dashPattern: const [4, 2],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(8),
                        child: SizedBox(
                          height: imageSize-2,
                          width: imageSize-2,
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

                                const SizedBox(height: 2),
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

                    // 선택한 이미지 출력 위젯
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index){
                          return imageCount > index
                              ? Stack(
                                children: [
                                  Center(
                                    child: GestureDetector(
                                      onTap: () async {
                                        await _pickImages();
                                      },
                                      child: Container(
                                        width: imageSize,
                                        height: imageSize,
                                        margin: const EdgeInsets.only(right: 8),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.file(_showFiles[index],
                                                fit: BoxFit.fill
                                            )
                                        ),
                                      ),
                                    ),
                                  ),

                                  // x 버튼
                                  Positioned(
                                    top: 3.5,
                                    right: 0,
                                    child: GestureDetector(
                                      key: Key('RemoveButton$index'),
                                      onTap: () => removeImage(index),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/icons/image_close.svg"
                                        ),
                                      ),
                                    )
                                  )
                                ],
                              ): const SizedBox.shrink();
                      }),
                    ),
                  ],
                ),
              ),

              // 다음 버튼
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
                    meet.meetInfo.imagefiles = [];
                    setState(() {
                      if (imageCount != 0){
                        for(int i = 0; i < imageCount; i++){
                          meet.meetInfo.imagefiles.add(_imageFiles[i]);
                        }
                      }
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
          :Container(                            // 선택 완료 후 이미지 출력
            height: 77,
            margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index){
                return imageCount > index
                    ? Stack(
                      children: [
                        // 이미지 출력
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              await _pickImages();
                            },
                            child: Container(
                                width: imageSize,
                                height: imageSize,
                                margin: const EdgeInsets.only(top: 12, right: 6),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(_showFiles[index],
                                        fit: BoxFit.cover
                                    )
                                ),
                            ),
                          ),
                        ),

                        // x 버튼
                        Positioned(
                            top: 3.5,
                            right: 0,
                            child: GestureDetector(
                              key: Key('RemoveButton$index'),
                              onTap: () => removeImage(index),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/image_close.svg"
                                ),
                              ),
                            )
                        )
                      ],
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
