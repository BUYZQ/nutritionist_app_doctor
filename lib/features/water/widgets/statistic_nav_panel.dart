import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/water/screens/statistics_screen.dart';
import 'package:nutritionist_app/widgets/my_button.dart';

class StatisticsNavigationPanel extends StatefulWidget {
  final List<Map<String, dynamic>>  stats;

  const StatisticsNavigationPanel({
    super.key,
    required this.stats,
  });

  @override
  State<StatisticsNavigationPanel> createState() => _StatisticsNavigationPanelState();
}

class _StatisticsNavigationPanelState extends State<StatisticsNavigationPanel> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final maxValue = widget.stats.map((e) => e['ml'] as int).reduce((a, b) => a > b ? a : b);
    final dateFormatter = DateFormat('dd.MM');
    return Material(
      color: Color(0xffF8F1EA),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.all(15),
        width: double.infinity,
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Статистика",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 17,
                fontFamily: 'ActayWide',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(widget.stats.length, (index) {
                          final item = widget.stats[index];
                          final isSelected = selectedIndex == index;
                          final value = item['ml'] as int;
                          final height = maxValue > 0 ? (value / maxValue) * 150 : 0;

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: GestureDetector(
                              onTap: () => setState(() => selectedIndex = index),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Столбик
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: 35,
                                    height: height + 2,
                                    decoration: BoxDecoration(
                                      color: Color(0xff209BED),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: value > 0
                                          ? Text(
                                        "$value",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      )
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Дата
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: isSelected ? Color(0xff209BED) : Colors.transparent,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      dateFormatter.format(item['date']),
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : kPrimaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        fontFamily: 'ActayWide',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
           SizedBox(height: 10),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               SizedBox(
                 height: 60,
                 width: 200,
                 child: MyButton(
                   title: "Открыть",
                   onPressed: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => StatisticsScreen()));
                   },
                 ),
               ),
             ],
           ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}