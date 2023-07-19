// 시간 선택 위젯

// 최종 수정일 : 2023.7.19
// 작업자 : 김혁

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../setting/registerMeeting.dart' as meet;
import 'meetWho.dart';

class MeetingTime extends ConsumerStatefulWidget {
  const MeetingTime({Key? key}) : super(key: key);

  @override
  MeetingTimeState createState() => MeetingTimeState();
}

class MeetingTimeState extends ConsumerState<MeetingTime> {
  List<DateTime?> _singleDateValue = [
    DateTime.now(),
  ];
  bool enabled = true;
  bool isChecked = false;
  String _showTime = "";

  // 날짜 선택 위젯 설정
  final config = CalendarDatePicker2Config(
    selectedDayHighlightColor: const Color(0xFF006FFD),
    weekdayLabels: ['일', '월', '화', '수', '목', '금', '토'],
    weekdayLabelTextStyle: const TextStyle(
      color: Color(0xFF8F9098),
      fontWeight: FontWeight.w700,
      fontSize: 12,
      letterSpacing: -0.5
    ),
    dayTextStyle: const TextStyle(
      color: Color(0xFF494A50),
      fontFamily: "Inter",
      fontWeight: FontWeight.w700,
      fontSize: 12,
    ),
  );

  // 날짜 선택 bottomsheet
  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top:Radius.circular(24)),
      ),
      context: context,
      builder: (BuildContext builder) {
        Size size = MediaQuery.of(context).size;
        return Container(
          height: 521,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 30,
                    blurStyle: BlurStyle.inner,
                    offset: const Offset(0, 8),
                )
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top:Radius.circular(24)),
          ),
          child: Column(
            children: [
              AppBar(
                toolbarHeight: 50,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top:Radius.circular(24))
                ),
                backgroundColor: Colors.white,
                centerTitle: true,
                elevation: 0,
                title: const Text("날짜 선택",
                  style: TextStyle(
                      color: Color(0xFF1F2024),
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      letterSpacing: 0.09
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/close.svg",
                          height: 20,
                          width: 20,
                        )
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // 날짜 선택 위젯 출력
                      Expanded(
                        child: CalendarDatePicker2(
                          value: _singleDateValue,
                          config: config,
                          onValueChanged: (dates) => setState(() => _singleDateValue = dates),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 다음 버튼
                      SizedBox(
                        height: 46,
                        width: size.width,
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFF0F1F5)),
                              alignment: Alignment.center,
                              shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))
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
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          )
        );
      },
    );
  }

  int _selectedPeriodIndex = 0;
  int _selectedHour = 0;
  int _selectedMinute = 0;
  late TimeOfDay _selectedTime;

  // 시간 선택 bottomsheet
  void _showTimePicker(BuildContext context) async {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top:Radius.circular(24)),
      ),
      context: context,
      builder: (BuildContext builder) {
        Size size = MediaQuery.of(context).size;
        return Container(
          height: 521,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 30,
                blurStyle: BlurStyle.inner,
                offset: const Offset(0, 8),
              )
            ],
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top:Radius.circular(24)),
          ),
          child: Column(
            children: [
              AppBar(
                toolbarHeight: 50,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top:Radius.circular(24))
                ),
                backgroundColor: Colors.white,
                centerTitle: true,
                elevation: 0,
                title: const Text("시간 선택",
                  style: TextStyle(
                      color: Color(0xFF1F2024),
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      letterSpacing: 0.09
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/close.svg",
                          height: 20,
                          width: 20,
                        )
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // 시간 선택 위젯
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 오전 or 오후 선택 위젯
                            Expanded(
                              child: CupertinoPicker(
                                backgroundColor: Colors.white,
                                itemExtent: 44,
                                diameterRatio: 1,
                                selectionOverlay: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color(0xFF006FFD)
                                            )
                                        )
                                    ),
                                ),
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    _selectedPeriodIndex = index;
                                  });
                                },
                                children: const [
                                  Center(
                                      child: Text('오전',
                                        style: TextStyle(
                                            color: Color(0xFF4E4E4E),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                        ),
                                      )
                                  ),
                                  Center(
                                      child: Text('오후',
                                        style: TextStyle(
                                          color: Color(0xFF4E4E4E),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),

                            // 시 선택 위젯
                            Expanded(
                              child: CupertinoPicker(
                                backgroundColor: Colors.white,
                                itemExtent: 44,
                                diameterRatio: 1,
                                selectionOverlay: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xFF006FFD)
                                        )
                                      )
                                    ),
                                ),
                                onSelectedItemChanged: (int value) {
                                  setState(() {
                                    _selectedHour = value+1;
                                  });
                                },
                                children: List<Widget>.generate(12, (int index) {
                                  return Center(
                                      child: Text('${index+1}시',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20
                                        ),
                                      )
                                  );
                                }),
                              ),
                            ),

                            // 분 선택 위젯
                            Expanded(
                              child: CupertinoPicker(
                                backgroundColor: Colors.white,
                                itemExtent: 44,
                                diameterRatio: 1,
                                selectionOverlay: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color(0xFF006FFD)
                                            )
                                        )
                                    ),
                                ),
                                onSelectedItemChanged: (int value) {
                                  setState(() {
                                    _selectedMinute = value * 10;
                                  });
                                },
                                children: List<Widget>.generate(6, (int index) {
                                  final minute = index * 10;
                                  return Center(
                                      child: Text('$minute분',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20
                                        ),
                                      )
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 완료 버튼
                      SizedBox(
                        width: size.width,
                        height: 46,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFF0F1F5)),
                            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                            ),
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
                            var formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
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
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.5,
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
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
            const meet.Title(content:"언제 만날까요?"),

            // 날짜, 시간 선택 버튼
            Container(
              width: size.width,
              height: 50,
              margin: const EdgeInsets.fromLTRB(24, 12, 24, 12),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFFF5F6FA)),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                  ),
                ),
                onPressed: () {
                  _showDatePicker(context);
                },
                child: Row(
                  children: [
                    const Text("날짜를 선택해 주세요.",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFFC8C8CB),
                          letterSpacing: -0.5,
                      ),
                    ),
                    const Spacer(flex: 30),
                    SvgPicture.asset(
                        "assets/icons/calendar.svg"
                    )
                  ],
                ),
              ),
            ),
          ],
        ):Container(                              // 선택 완료 후 출력 버튼
          margin: const EdgeInsets.fromLTRB(24, 12, 24, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            border: Border.all(
                color: const Color(0xFFC5C6CC),
                width: 1
            ),
          ),
          child: TextButton(
            style: const ButtonStyle(
                padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                  EdgeInsets.all(16),
                )
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(_showTime,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize:14,
                      color: Color(0xFF2F3036),
                      letterSpacing: -0.5
                  )
              ),
            ),
            onPressed: () {
              setState(() {
                enabled = true;
              });
            },
          ),
        ),
        isChecked? const MeetingWho()
            :const SizedBox.shrink(),
      ],
    );
  }
}
