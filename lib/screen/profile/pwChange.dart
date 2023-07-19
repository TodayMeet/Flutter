
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front/screen/dialog/dialoglist.dart';
import '../../model/UI/widget/button/blueButton.dart';
import '../../model/UI/widget/button/svgButton.dart';
import '../../model/UI/widget/customAppBar.dart';
import '../../model/UI/widget/text/textfieldTitle.dart';
import '../../screen/profile/profileMain.dart';
import '../../data/designconst/constants.dart';



class pwChange extends StatefulWidget {
  const pwChange({Key? key}) : super(key: key);

  @override
  State<pwChange> createState() => _pwChangeState();
}

class _pwChangeState extends State<pwChange> {
  //컨트롤러
  final ScrollController _scrollController = ScrollController();
  final _currentpwController = TextEditingController();
  final _changepwController = TextEditingController();
  final _confirmpwController = TextEditingController();



  // 초기상태는 전부 텍스트는 안보이게
  bool obscureText1 = true;
  bool obscureText2 = true;
  bool obscureText3 = true;

  


  //컨트롤러 제거
  @override
  void dispose() {
    _currentpwController.dispose();
    _changepwController.dispose();
    _confirmpwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,// 현재 작동되지 않음 - 저장 버튼이 안올라오게 해야하는데 올라와짐
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leadingWidget: SvgButton(
          imagePath: backarrow,
          onPressed:() {
            Navigator.pop(context);
            },
        ),
        title: '비밀번호 변경',
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            //현재 비밀번호
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //현재 비밀번호 텍스트필드 제목
                textfieldTitle(title: '현재 비밀번호',star: true,),
                // 사이 여백
                SizedBox(height: 8.0),
                // 텍스트필드
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 48.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: TextField(
                    obscureText: obscureText1,
                    controller: _currentpwController,
                    decoration: InputDecoration(
                      hintText: pwTitle,
                      hintStyle: TextStyle(
                          fontSize: 13.0, color: hinttextColor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12.0)),
                      filled: true,
                      fillColor: textfieldColor,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText1 = !obscureText1;
                          });
                        },
                        icon: SvgPicture.asset(
                          obscureText1
                              ?   'assets/icons/detail/Visibility_off.svg'
                              :   'assets/icons/detail/Visibility.svg',
                          color: Color(0xFFD0D0D0),
                        ),
                      ),
                    ),
                  ),
                ),
                //텍스트필드와 메시지 사이 여백
                SizedBox(height: 8.0),
                // 2자 이상 12자 이하 영문숫자특수기호만 입력가능 메시지
                textfieldTitle(title: pwTitle, star: true,reverse: true,)
              ],
            ),

            //현재 비밀번호 - 새 비밀번호 사이 여백
            SizedBox(height: 24,),

            //새 비밀번호
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.0),
                textfieldTitle(title: '새 비밀번호', star: true),
                SizedBox(height: 8.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 48.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: TextField(
                    obscureText: obscureText1,
                    controller: _changepwController,
                    decoration: InputDecoration(
                      hintText: pwTitle,
                      hintStyle: TextStyle(
                          fontSize: 13.0, color: hinttextColor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12.0)),
                      filled: true,
                      fillColor: Color(0xFFF5F6FA),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText2 = !obscureText2;
                          });
                        },
                          icon: SvgPicture.asset(
                            obscureText2
                                ?   'assets/icons/detail/Visibility_off.svg'
                                :   'assets/icons/detail/Visibility.svg',
                            color: Color(0xFFD0D0D0),
                          )
                      ),
                    ),
                  ),
                ),//텍스트필드
                SizedBox(height: 8.0),
                textfieldTitle(title: pwTitle, star: true,reverse: true,)
              ],
            ),

            //새 비밀번호 - 새비밀번호 확인 사이 여백
            SizedBox(height: 24,),
            
            //새 비밀번화 확인
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.0),
                textfieldTitle(title: '새 비밀번호 확인',star: true,),
                SizedBox(height: 8.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 48.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: TextField(
                    obscureText: obscureText3,
                    controller: _confirmpwController,
                    decoration: InputDecoration(
                      hintText: pwTitle,
                      hintStyle: TextStyle(fontSize: 13.0, color: hinttextColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF5F6FA),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText3 = !obscureText3;
                          });
                        },
                        icon: SvgPicture.asset(
                          obscureText3 ? 'assets/icons/detail/Visibility_off.svg' : 'assets/icons/detail/Visibility.svg' ,
                          color: Color(0xFFD0D0D0),
                        ),
                      ),
                    ),
                  ),
                ), //텍스트필드
                SizedBox(height: 8.0),
                textfieldTitle(title: pwTitle, star: true, reverse: true,),

              ],
            ),//새 비밀번호 확인
            
            //새 비밀번호 확인  - 저장 부분 사이 여백
            Spacer(),
            
            //저장 버튼
            blueButton(buttonText: '저장', onPressed: (){onebutton.pwChangeDialog(context);})//변경 버튼
          ],
        ),
      ),
    );
  }
}
