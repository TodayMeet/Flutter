import 'package:flutter/material.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/screen/profile/profileMain.dart';
// import 'mainListView.dart';



class blockManage extends StatefulWidget {
  const blockManage({Key? key}) : super(key: key);

  @override
  State<blockManage> createState() => _blockManageState();
}

class _blockManageState extends State<blockManage> {
  List<String> entries = <String>['개굴개굴','꺄르르','보라돌이','오늘만산다','심심해'];
  List<String> entries1 = <String>['googlelogin','kakao_login_large_wide','logoimage','naverlogin','titleimage'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);

        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: Text(
          '차단 관리',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600
          ),
        ),
        actions: null,
        centerTitle: true,
      ),
      body: ListView.builder(
          padding:const EdgeInsets.symmetric(horizontal: 24,vertical: 22),
          itemCount:entries.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                children: [
                  CircleAvatar(radius: 18, backgroundImage: AssetImage("assets/images/LoginImage/${entries1[index]}.png"),),
                  SizedBox(width: 10,),
                  Text('${entries[index]}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
                  Spacer(),
                  ElevatedButton(onPressed: () {},
                    child: Text('차단해제',style: TextStyle(color: Colors.white,fontSize: 14),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFD6D6DD)),
                      elevation: MaterialStateProperty.all<double>(0),
                      side: MaterialStateProperty.all<BorderSide>(BorderSide(color: Color(0xFFD8D8D8), width: 2.0),),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),),
                    ),
                  ),
                ],
              ),
            );
          }

      ),
    );
  }
}