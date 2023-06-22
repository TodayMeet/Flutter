import 'package:flutter/material.dart';

import '../../screen/login/login.dart';

class logoutDialog extends StatelessWidget {
  const logoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color __myBlue = Color(0xff4874EA);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
        width: MediaQuery.of(context).size.width - 55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 75.0,vertical: 36.0),
              child: Column(
                children: [
                  Center(child: Text('탈퇴 신청',style: TextStyle(fontWeight: FontWeight.w700),),),
                  SizedBox(height: 12.0,),
                  Center(
                      child: Text(
                        '탈퇴 후 서비스 이용이 불가능 합니다.',
                        style: TextStyle(fontSize: 14),
                      )),
                  Center(
                      child: Text(
                        '탈퇴 하시겠습니까?',
                        style: TextStyle(fontSize: 14.0,),
                      )),
                ],
              ),
            ),
            Divider(thickness: 0.5,height: 0,color: Colors.grey,),
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 18.5),
                      decoration: BoxDecoration(
                        color: __myBlue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.8),
                        ),
                      ),
                      child: Text(
                        "취소",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => login()),
                              (route) => false);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 18.5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15.8),
                        ),
                      ),
                      child: Text(
                        "확인",
                        style: TextStyle(
                            color: __myBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
