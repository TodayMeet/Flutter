import 'package:flutter/material.dart';
import 'package:front/model/TextPrint.dart';
import 'package:front/screen/profile/profileMain.dart';
// import 'mainListView.dart';



class oftenQuestion extends StatefulWidget {
  const oftenQuestion({Key? key}) : super(key: key);

  @override
  State<oftenQuestion> createState() => _oftenQuestionState();
}

class _oftenQuestionState extends State<oftenQuestion> {
  List<String> entries = <String>['건수 등록은 어떻게 하나요?','건수 등록은 어떻게 하나요?','건수 등록은 어떻게 하나요?','건수 등록은 어떻게 하나요?'];
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
          '자주 묻는 질문',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600
          ),
        ),
        actions: null,
        centerTitle: true,
      ),
      body:ListView.builder(
          padding:const EdgeInsets.all(8),
          itemCount:entries.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
              child: Row(
                children: [
                  Text("Q",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w600),),
                  SizedBox(width: 10,),
                  Text('${entries[index]}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
                  Spacer(),
                  IconButton(onPressed: (){}, icon: Icon(Icons.expand_more))
                ],
              ),
            );
          }

      ),
    );
  }
}
