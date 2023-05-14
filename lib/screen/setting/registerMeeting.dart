import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

import 'package:front/model/bottomBar.dart';

bool meetTime = false;
bool meetWho = false;
bool meetNumberOfPeople = false;
bool meetCost = false;
bool meetTitle = false;
bool meetContent = false;
bool meetImage = false;
bool meetAccept = false;

class RegisterMeeting extends StatefulWidget {
  const RegisterMeeting({Key? key}) : super(key: key);

  @override
  State<RegisterMeeting> createState() => _RegisterMeetingState();
}

class _RegisterMeetingState extends State<RegisterMeeting> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('오늘의 건수등록',
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'PretendardBold')),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: ListView(
          controller: _scrollController,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 5.0),
              height: 70,
              alignment: Alignment.centerLeft,
              child: const Text("어떤 건 수를\n등록해 볼까요?", style: TextStyle(fontFamily:"PretendardRegular",
                  fontSize: 23, color: Color(0xff2f3036))),
            ),
            const MeetingCategory(),
            const MeetingLocation(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: BottomBar()
      ),
    );
  }
}

class MeetingCategory extends StatefulWidget {
  const MeetingCategory({Key? key}) : super(key: key);

  @override
  State<MeetingCategory> createState() => _MeetingCategoryState();
}

class _MeetingCategoryState extends State<MeetingCategory> {
  bool enabled = true;
  String categoryText = "";

  List<Map> categories = [
    {"name": "맛집", "isChecked": false, "image_color": "0xFFE91E63",
      "category_image": "assets/images/Category/CategoryRestaurant.png"},
    {"name": "카페", "isChecked": false, "image_color": "0xFFE91E63",
      "category_image": "assets/images/Category/CategoryCafe.png"},
    {"name": "주류", "isChecked": false, "image_color": "0xFF3F51B5",
      "category_image": "assets/images/Category/CategoryAlcohol.png"},
    {"name": "영화", "isChecked": false, "image_color": "0xFF673AB7",
      "category_image": "assets/images/Category/CategoryMovie.png"},
    {"name": "전시", "isChecked": false, "image_color": "0xFF607D8B",
      "category_image": "assets/images/Category/CategoryExhibition.png"},
    {"name": "공연", "isChecked": false, "image_color": "0xFF607D8B",
      "category_image": "assets/images/Category/CategoryPerformance.png"},
    {"name": "게임", "isChecked": false, "image_color": "0xFFFF5722",
      "category_image": "assets/images/Category/CategoryGame.png"},
    {"name": "봉사", "isChecked": false, "image_color": "0xFF8BC34A",
      "category_image": "assets/images/Category/CategoryService.png"},
    {"name": "독서", "isChecked": false, "image_color": "0xFF374046",
      "category_image": "assets/images/Category/CategoryRead.png"},
    {"name": "스터디", "isChecked": false, "image_color": "0xFF9C27B0",
      "category_image": "assets/images/Category/CategoryStudy.png"},
    {"name": "반려동물", "isChecked": false, "image_color": "0xFF795548",
      "category_image": "assets/images/Category/CategoryPet.png"},
    {"name": "운동", "isChecked": false, "image_color": "0xFFDCA966",
      "category_image": "assets/images/Category/CategorySports.png"},
  ];

  void categoryChange(){
    setState(() {
      if(enabled){
        enabled = false;
      }else{
        for(var i = 0; i < 12; i++) {
          categories[i]["isChecked"] = false;
        }
        enabled = true;
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return enabled? Column(                   // 카테고리
      crossAxisAlignment: CrossAxisAlignment.center,
      children: categories.map((category){
        return Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xFFF7F8FA),
          ),
          child: CheckboxListTile(
            checkboxShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            value: category["isChecked"],
            onChanged: (newValue){
              setState(() {
                category["isChecked"] = newValue;
              });
              categoryText = category["name"];
              categoryChange();
            },
            title: Text(category["name"],style: const TextStyle(fontFamily: "PretendardBold",
                fontSize: 15)),
            secondary: Container(
              alignment: Alignment.center,
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(int.parse(category["image_color"])),
              ),
              child: Image.asset(category["category_image"]),
            ),
            isThreeLine: false,
          ),
        );
      }).toList(),
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
          child: Text(categoryText,
              style: const TextStyle(
                  fontFamily: "PretendardBold",
                  fontSize:15,
                  color: Color(0xFF2F3036))
          ),
        ),
        onPressed: () {
          categoryChange();
        },
      ),
    );
  }
}

class MeetingLocation extends StatefulWidget {
  const MeetingLocation({Key? key}) : super(key: key);

  @override
  State<MeetingLocation> createState() => _MeetingLocationState();
}

class _MeetingLocationState extends State<MeetingLocation> {
  bool enabled = true;
  String meetLocation = "";

  void categoryChange(){
    setState(() {
      if(enabled){
        meetTime = true;
        enabled = false;
      }else{
        meetTime = false;
        enabled = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return enabled?Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20.0, 20.0, 8.0, 5.0),
          height: 50,
          alignment: Alignment.centerLeft,
          child: const Text("어디서 만날까요?", style: TextStyle(fontFamily: "PretendardRegular",
              fontSize: 23, color: Color(0xff2f3036))),
        ),
        Container(
          width: size.width,
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6FA),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextButton(
            onPressed: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)
                )),
                  context: context,
                  builder: (BuildContext barcontext){
                    return Container(
                      height: 600,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Spacer(flex: 30),
                              const Text("위치",
                                style: TextStyle(
                                    color: Color(0xFF1F2024),
                                    fontFamily: "PretendardBold",
                                    fontSize: 16),
                              ),
                              const Spacer(flex : 24),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: (){
                                  Navigator.pop(barcontext);
                                  },
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                            child: TextField(
                              decoration: const InputDecoration(
                                icon: Icon(Icons.search)
                              ),
                              onTap: (){
                                meetLocation = "강남역 2호선";
                                categoryChange();
                                Navigator.pop(barcontext);
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  }
              );
            },
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text("위치를 선택해 주세요.",
                style: TextStyle(
                    fontFamily: "PretendardRegular",
                    fontSize: 15,
                    color: Color(0xFFC8C8CB)),
              ),
            ),
          ),
        ),
      ],
    ): Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xFFF5F6FA),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: TextButton(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(meetLocation,
                  style: const TextStyle(
                      fontFamily: "PretendardBold",
                      fontSize:15,
                      color: Color(0xFF2F3036))
              ),
            ),
            onPressed: () {
              categoryChange();
            },
          ),
        ),
        MeetingTime()
      ],
    );
  }
}

class MeetingTime extends StatefulWidget {
  const MeetingTime({Key? key}) : super(key: key);

  @override
  State<MeetingTime> createState() => _MeetingTimeState();
}

class _MeetingTimeState extends State<MeetingTime> {
  List<DateTime?> _singleDateValue = [
    DateTime.now(),
  ];
  bool isChecked = false;
  String _showTime = "";

  final config = CalendarDatePicker2Config(
    selectedDayHighlightColor: const Color(0xFF006FFD),
    weekdayLabels: ['일', '월', '화', '수', '목', '금', '토'],
    weekdayLabelTextStyle: const TextStyle(
      color: Color(0xFF8F9098),
      fontFamily: 'PretendardBold',
      fontSize: 12,
    ),
    dayTextStyle: const TextStyle(
      color: Color(0xFF494A50),
    ),
  );

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 521.0,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(flex: 30),
                    const Text("날짜 선택",
                      style: TextStyle(
                          color: Color(0xFF1F2024),
                          fontFamily: "PretendardBold",
                          fontSize: 16),
                    ),
                    const Spacer(flex : 24),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              CalendarDatePicker2(
                value: _singleDateValue,
                config: config,
                onValueChanged: (dates) => setState(() => _singleDateValue = dates),
              ),
              TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFF0F1F5)),
                  alignment: Alignment.center,
                ),
                onPressed: (){
                  Navigator.pop(context);
                  print(_singleDateValue);
                  _showTimePicker(context);
                },
                child: const Text('다음',
                    style: TextStyle(
                        color: Color(0xFF2F3036),
                        fontSize: 14,
                        fontFamily: 'PretendardBold')
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  int _selectedPeriodIndex = 0;
  int _selectedHour = 0;
  int _selectedMinute = 0;
  late TimeOfDay _selectedTime;

  void _showTimePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 521.0,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 30),
                  const Text("시간 선택",
                    style: TextStyle(
                        color: Color(0xFF1F2024),
                        fontFamily: "PretendardBold",
                        fontSize: 16),
                  ),
                  const Spacer(flex : 24),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: (){
                      Navigator.pop(builder);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 300,
                      child: CupertinoPicker(
                        backgroundColor: Color(0xFFFFFFFF),
                        itemExtent: 50,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedPeriodIndex = index;
                          });
                        },
                        children: const [
                          Center(child: Text('오전')),
                          Center(child: Text('오후')),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 300,
                      child: CupertinoPicker(
                        backgroundColor: Color(0xFFFFFFFF),
                        itemExtent: 50,
                        onSelectedItemChanged: (int value) {
                          setState(() {
                            _selectedHour = value+1;
                          });
                        },
                        children: List<Widget>.generate(12, (int index) {
                          return Center(child: Text('${index+1}시'));
                        }),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 300,
                      child: CupertinoPicker(
                        backgroundColor: Color(0xFFFFFFFF),
                        itemExtent: 50 ,
                        onSelectedItemChanged: (int value) {
                          setState(() {
                            _selectedMinute = value * 10;
                          });
                        },
                        children: List<Widget>.generate(6, (int index) {
                          final minute = index * 10;
                          return Center(child: Text('$minute분'));
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFF0F1F5)),
                  alignment: Alignment.center,
                ),
                onPressed: (){
                  if(_selectedPeriodIndex == 0) {
                    setState(() {
                      _selectedTime = TimeOfDay(
                          hour: _selectedHour, minute: _selectedMinute);
                    });
                    print(_selectedTime);
                    Navigator.pop(builder);
                  }else{
                    setState(() {
                      _selectedTime = TimeOfDay(
                          hour: _selectedHour+12, minute: _selectedMinute);
                    });
                    print(_selectedTime);
                    Navigator.pop(builder);
                  }
                },
                child: const Text('완료',
                    style: TextStyle(
                        color: Color(0xFF2F3036),
                        fontSize: 14,
                        fontFamily: 'PretendardBold')
                ),
              ),
            ],
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        // 선택된 시간 처리
        print('Selected time: ${value.format(context)}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        meetTime?Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20.0, 20.0, 8.0, 5.0),
                height: 50,
                alignment: Alignment.centerLeft,
                child: const Text("언제 만날까요?", style: TextStyle(fontFamily: "PretendardRegular",
                    fontSize: 23, color: Color(0xff2f3036))),
              ),
              Container(
                width: size.width,
                height: 50,
                margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(0xFFF5F6FA)),
                      shadowColor: MaterialStateProperty.all(Colors.white)
                  ),
                  onPressed: () async {
                    _showDatePicker(context);
                    setState(() {
                      meetTime = false;
                      final _singleTimeValue = _singleDateValue.last!;
                      _showTime = DateFormat('yyyy-MM-dd').format(_singleTimeValue);
                      if(_selectedPeriodIndex == 0){
                        _showTime += ' 오전 ';
                      }else{
                        _showTime += ' 오후 ';
                      }
                      _showTime += _selectedTime.format(context);
                      isChecked = true;
                      meetWho = true;
                    });
                  },
                  child: Expanded(
                    child: Row(
                      children: const [
                        Text("날짜를 선택해 주세요.",
                          style: TextStyle(
                            fontFamily: "PretendardRegular",
                            fontSize: 15,
                            color: Color(0xFFC8C8CB)),
                        ),
                        Spacer(flex: 30),
                        Icon(Icons.event)
                      ],
                    ),
                  ),
                ),
              ),
            ],
        ):const SizedBox(height: 0),
        isChecked? Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xFFF5F6FA),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: TextButton(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(_showTime,
                      style: const TextStyle(
                          fontFamily: "PretendardBold",
                          fontSize:15,
                          color: Color(0xFF2F3036))
                  ),
                ),
                onPressed: () {
                  setState(() {
                    meetTime = true;
                    isChecked = false;
                  });
                },
              ),
            ),
            MeetingWho()
          ],
        ): const SizedBox(height: 0),
      ],
    );
  }
}

class MeetingWho extends StatefulWidget {
  const MeetingWho({Key? key}) : super(key: key);

  @override
  State<MeetingWho> createState() => _MeetingWhoState();
}

class _MeetingWhoState extends State<MeetingWho> {
  bool isChecked = false;
  late String _valueWho;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        meetWho? Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20.0, 20.0, 8.0, 5.0),
                height: 50,
                alignment: Alignment.centerLeft,
                child: const Text("누구와 만날까요?", style: TextStyle(fontFamily: "PretendardRegular",
                  fontSize: 23, color: Color(0xff2f3036))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFF4874EA)),
                      ),
                      onPressed: (){
                        setState(() {
                          _valueWho = '누구나';
                          isChecked = true;
                          meetWho = false;
                        });
                      },
                      child: const Center(child: Text('누구나', style: TextStyle(
                        fontFamily: 'PretendardBold', color: Colors.white, fontSize: 16
                      ))),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFB6B6B6)),
                      ),
                      onPressed: (){
                        setState(() {
                          _valueWho = '또래만';
                          isChecked = true;
                          meetWho = false;
                        });
                      },
                      child: const Center(child: Text('또래만', style: TextStyle(
                          fontFamily: 'PretendardBold', color: Colors.white, fontSize: 16
                      ))),
                    ),
                  ),
                ],
              ),
            ]
        ): const SizedBox(height: 0),
        isChecked? Container(
          child: TextButton(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(_valueWho,
                  style: const TextStyle(
                      fontFamily: "PretendardBold",
                      fontSize:15,
                      color: Color(0xFF2F3036))
              ),
            ),
            onPressed: () {
              setState(() {
                meetWho = true;
                isChecked = false;
              });
            },
          ),
        ): const SizedBox(height: 0),
      ],
    );
  }
}
