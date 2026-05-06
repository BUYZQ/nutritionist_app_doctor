import 'package:flutter/material.dart';
import 'package:nutritionist_app/features/home/widgets/person_container.dart';
import 'package:nutritionist_app/features/home/widgets/user_strick.dart';
import 'package:nutritionist_app/features/medicine/screens/taking_medications_nav_panel.dart';
import 'package:nutritionist_app/features/medicine/widgets/medicine_calendar_mini.dart';
import 'package:nutritionist_app/features/water/widgets/water_tiles.dart';
import 'package:nutritionist_app/features/water/widgets/statistic_nav_panel.dart';
import 'package:nutritionist_app/features/water/widgets/water_calendar_mini.dart';


class MedicineScreen extends StatelessWidget {
  const MedicineScreen({super.key});

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
                  background: Color(0xffF2F2B7),
                  foreground: Color(0xff808A35),
                ),
                SizedBox(height: 10),
                MedicineCalendarMini(foreground: Color(0xff808A35)),
                SizedBox(height: 10),
                TakingMedicationsNavPanel(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}












