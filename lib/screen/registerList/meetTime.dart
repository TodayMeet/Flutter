// 시간 선택 위젯

// 최종 수정일 : 2023.5.28
// 작업자 : 김혁

// 추가 작업 예정 사항

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';

import '../setting/registerMeeting.dart' as meet;
import 'meetWho.dart';

class MeetingTime extends StatefulWidget {
  const MeetingTime({Key? key}) : super(key: key);

  @override
  State<MeetingTime> createState() => _MeetingTimeState();
}

class _MeetingTimeState extends State<MeetingTime> {
  List<DateTime?> _singleDateValue = [
    DateTime.now(),
  ];
  bool enabled = true;
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top:Radius.circular(30)),
      ),
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top:Radius.circular(30)),
      ),
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
                    _selectedTime = TimeOfDay(
                        hour: _selectedHour, minute: _selectedMinute);
                  }else{
                    _selectedTime = TimeOfDay(
                        hour: _selectedHour + 12, minute: _selectedMinute);
                  }

                  final singleTimeValue = _singleDateValue.last!;
                  _showTime = DateFormat('yyyy-MM-dd').format(singleTimeValue);
                  if(_selectedPeriodIndex == 0){
                    _showTime += ' 오전 ';
                  }else{
                    _showTime += ' 오후 ';
                  }
                  _showTime += _selectedTime.format(context);
                  _showTime = _showTime.substring(0, _showTime.length-2);

                  var dateTime = DateTime(
                    singleTimeValue.year,
                    singleTimeValue.month,
                    singleTimeValue.day,
                    _selectedTime.hour,
                    _selectedTime.minute,
                  );
                  var formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime);
                  meet.meetInfo.time = formattedDate;

                  setState(() {
                    enabled = false;
                    isChecked = true;
                  });

                  Navigator.pop(builder);
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
        enabled?Column(
          children: [
            meet.Title(content:"언제 만날까요?"),
            Container(
              width: size.width,
              height: 50,
              margin: const EdgeInsets.fromLTRB(24, 5, 24, 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFFF5F6FA)),
                    shadowColor: MaterialStateProperty.all(Colors.transparent)
                ),
                onPressed: () {
                  _showDatePicker(context);
                },
                child: Row(
                  children: const [
                    Text("날짜를 선택해 주세요.",
                      style: TextStyle(
                          fontFamily: "PretendardRegular",
                          fontSize: 15,
                          color: Color(0xFFC8C8CB)),
                    ),
                    Spacer(flex: 30),
                    Icon(Icons.event, color: Color(0xFF49454F),)
                  ],
                ),
              ),
            ),
          ],
        ):Container(
          margin: const EdgeInsets.fromLTRB(24, 5, 24, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: TextButton(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(_showTime,
                  style: const TextStyle(
                      fontFamily: "PretendardBold",
                      fontSize:16,
                      color: Color(0xFF2F3036))
              ),
            ),
            onPressed: () {
              setState(() {
                enabled = true;
              });
            },
          ),
        ),
        isChecked? MeetingWho()
            :const SizedBox.shrink(),
      ],
    );
  }
}
