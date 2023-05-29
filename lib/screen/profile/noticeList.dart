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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => profileMain()),
          );
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: Text(
          '공지사항',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600
          ),
        ),
        actions: null,
        centerTitle: true,
      ),
      body:ListView.builder(
          padding:const EdgeInsets.symmetric(horizontal: 24,vertical: 22),
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
                            Text('${entries[index]}',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
                            SizedBox(height: 4,),
                            Text('2022.06.15',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w400),),

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
