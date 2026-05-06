import 'package:flutter/material.dart';
import 'package:nutritionist_app/features/home/widgets/food_tiles.dart';
import 'package:nutritionist_app/features/home/widgets/person_container.dart';
import 'package:nutritionist_app/features/home/widgets/user_strick.dart';
import 'package:nutritionist_app/features/medicine/screens/taking_medications_nav_panel.dart';
import 'package:nutritionist_app/features/medicine/widgets/medicine_calendar_mini.dart';
import 'package:nutritionist_app/features/water/widgets/statistic_nav_panel.dart';
import 'package:nutritionist_app/features/water/widgets/water_calendar_mini.dart';
import 'package:nutritionist_app/features/water/widgets/water_tiles.dart';
import '../widgets/calendar_mini.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // ✅ Используем Column + Expanded + ListView (фиксит RenderFlex overflow)
        child: Column(
          children: [
            const PersonContainer(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                physics: const BouncingScrollPhysics(),
                children: [
                  const UserStrick(),
                  const SizedBox(height: 10),
                  const CalendarMini(),
                  const SizedBox(height: 10),
                  const FoodTiles(),
                  const SizedBox(height: 10),
                  const UserStrick(
                    background: Color(0xffDFF9FF),
                    foreground: Color(0xff4CC6E5),
                  ),
                  const SizedBox(height: 10),
                  const WaterCalendarMini(foreground: Color(0xff4CC6E5)),
                  const SizedBox(height: 10),
                  const WaterTiles(),
                  const SizedBox(height: 10),
                  // const StatisticsNavigationPanel(),
                  const SizedBox(height: 10),
                  const UserStrick(
                    background: Color(0xffF2F2B7),
                    foreground: Color(0xff808A35),
                  ),
                  const SizedBox(height: 10),
                  const MedicineCalendarMini(foreground: Color(0xff808A35)),
                  const SizedBox(height: 10),
                  const TakingMedicationsNavPanel(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
