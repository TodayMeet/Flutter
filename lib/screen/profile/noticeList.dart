import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/screen/profile/notice.dart';
import 'package:front/screen/profile/profileMain.dart';
// import 'mainListView.dart';



class noticeList extends StatefulWidget {
  const noticeList({Key? key}) : super(key: key);

  @override
  State<noticeList> createState() => _noticeListState();
}

class _noticeListState extends State<noticeList> {
  List<String> entries = <String>['업데이트 안내드립니다.','업데이트 안내드립니다.','업데이트 안내드립니다.','업데이트 안내드립니다.','업데이트 안내드립니다.'];
  List<String> entries1 = <String>['googlelogin','kakao_login_large_wide','logoimage','naverlogin','titleimage'];
  String appbarText = '공지사항';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        toolbarHeight: 50,
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color : Color(0xFFE3E3E3), // 테두리 선의 색상
            height: 1.0, // 테두리 선의 높이
          ),
        ),
        leading: IconButton(
            iconSize: 14.93,
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => profileMain()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF2F2F2F),
            )),
        //leading아이콘 혹시나 필요하면

        title: Text(appbarText,
          style: TextStyle(fontSize: 16.0,color: Colors.black,fontFamily: 'PretendardBold'),
        ),

        centerTitle: true,
      ),
      body:ListView.builder(
          padding:const EdgeInsets.symmetric(horizontal: 16,vertical: 22),
          itemCount:entries.length,
          itemBuilder: (BuildContext context, int index){
            return Column(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => notice(), // 이동할 페이지의 위젯
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Row(
                      children: [
                        CircleAvatar(radius: 25, backgroundImage: AssetImage("assets/images/LoginImage/${entries1[index]}.png"),),
                        SizedBox(width: 16,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${entries[index]}',style: TextStyle(color: Colors.black,fontSize: 14.0,fontFamily: 'PretendardRegular'),),
                            SizedBox(height: 4,),
                            Text('2022.06.15',style: TextStyle(color: Color(0xFF71727A),fontSize: 12,fontFamily: 'PretendardRegular'),),

                          ],
                        ),



                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32,),
              ],
            );
          }

      ),
    );
  }
}

