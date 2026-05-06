import 'package:flutter/material.dart';
import 'package:horizontal_list_calendar/horizontal_list_calendar.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/water/screens/water_calendar_screen.dart';

class WaterCalendarMini extends StatelessWidget {

  final Color? foreground;

  const WaterCalendarMini({
    super.key,
    this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xffF8F1EA),
        borderRadius: BorderRadius.circular(30),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return WaterCalendarScreen(foreground: foreground);
            }),
          );
        },
        child: HorizontalListCalendar(
          moveToPreviousMonthIconBackgroundColor: kPrimaryColor,
          moveToNextMonthIconBackgroundColor: kPrimaryColor,
          moveToNextMonthIcon: Icon(Icons.arrow_forward),
          moveToPreviousMonthIcon: Icon(Icons.arrow_back_outlined),
          todayTextStyle: TextStyle(
            letterSpacing: 0.2,
            fontWeight: FontWeight.w700,
            fontFamily: 'ActayWide',
            color: Colors.white,
            fontSize: 18,
          ),
          unSelectedTextStyle: TextStyle(
            letterSpacing: 0.2,
            fontWeight: FontWeight.w700,
            fontFamily: 'ActayWide',
            color: kPrimaryColor,
            fontSize: 18,
          ),
          selectedTextStyle: TextStyle(
            letterSpacing: 0.2,
            fontWeight: FontWeight.w700,
            fontFamily: 'ActayWide',
            color: kPrimaryColor,
            fontSize: 18,
          ),
          headerTextStyle: TextStyle(
            letterSpacing: 0.2,
            fontWeight: FontWeight.w700,
            fontFamily: 'ActayWide',
            color: kPrimaryColor,
            fontSize: 18,
          ),
          selectedColor: foreground ?? kPrimaryColor,
          todayFillColor: foreground ?? kPrimaryColor,
          scrollController: ScrollController(),
          onTap: (val) {},
        ),
      ),
    );
  }
}