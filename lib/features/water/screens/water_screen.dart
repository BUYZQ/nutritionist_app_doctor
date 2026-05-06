import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/home/widgets/person_container.dart';
import 'package:nutritionist_app/features/home/widgets/user_strick.dart';
import 'package:nutritionist_app/features/water/widgets/water_tiles.dart';
import 'package:nutritionist_app/features/water/widgets/statistic_nav_panel.dart';
import 'package:nutritionist_app/features/water/widgets/water_calendar_mini.dart';


class WaterScreen extends StatelessWidget {
  const WaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PersonContainer(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20,
            ),
            child: ListView(
              children: [
                UserStrick(
                  background: Color(0xffDFF9FF),
                  foreground: Color(0xff4CC6E5),
                ),
                SizedBox(height: 10),
                WaterCalendarMini(foreground: Color(0xff4CC6E5)),
                SizedBox(height: 10),
                WaterTiles(),
                // StatisticsNavigationPanel(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}












