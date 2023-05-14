
import 'package:flutter/material.dart';
import 'meetList.dart';
import 'TextPrint.dart';

Future Invitaiton(BuildContext context, meetList test) {
  return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 50,),
                  StringText('초대하기', 18, 'PretendardBold', Color(0xff1F2024)),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close)
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Image.asset('assets/images/User_Picture/User_pic_null.png',
                              width: 26, height: 26),  //사용자 사진
                          const SizedBox(width: 10,),
                          StringText(test.hostName, 12, 'PretendardRegular', Colors.black),
                        ],
                      ),
                    ),

                    const Center(
                      child: SizedBox(
                        child: Divider(
                          color: Color(0xffF0F1F5),
                          thickness: 1.0,
                        ),
                      ),
                    ), //구분선

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Image.asset('assets/images/User_Picture/User_pic_null.png',
                              width: 26, height: 26),  //사용자 사진
                          const SizedBox(width: 10,),
                          StringText(test.hostName, 12, 'PretendardRegular', Colors.black),
                        ],
                      ),
                    ),

                    const Center(
                      child: SizedBox(
                        child: Divider(
                          color: Color(0xffF0F1F5),
                          thickness: 1.0,
                        ),
                      ),
                    ), //구분선

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Image.asset('assets/images/User_Picture/User_pic_null.png',
                              width: 26, height: 26),  //사용자 사진
                          const SizedBox(width: 10,),
                          StringText(test.hostName, 12, 'PretendardRegular', Colors.black),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
  );
}