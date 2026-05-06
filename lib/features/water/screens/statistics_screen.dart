import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/home/widgets/custom_app_bar.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  // Пример данных по дням
  final List<Map<String, dynamic>> stats = [
    {"date": DateTime(2026, 9, 30), "ml": 900},
    {"date": DateTime(2026, 10, 1), "ml": 900},
    {"date": DateTime(2026, 10, 2), "ml": 1350},
    {"date": DateTime(2026, 10, 3), "ml": 1250},
    {"date": DateTime(2026, 10, 4), "ml": 600},
  ];

  // История напитков за выбранный день
  final List<Map<String, String>> history = [
    {"time": "7:32", "title": "Вода", "ml": "300 мл"},
    {"time": "8:33", "title": "Чёрный чай", "ml": "200 мл"},
    {"time": "9:00", "title": "Вода", "ml": "300 мл"},
  ];

  int selectedIndex = 4;

  @override
  Widget build(BuildContext context) {
    final maxValue = stats.map((e) => e['ml'] as int).reduce((a, b) => a > b ? a : b);
    final dateFormatter = DateFormat('dd.MM');

    return Scaffold(
      backgroundColor: Color(0xffF8F1EA),
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: "Статистика"),
            const SizedBox(height: 20),

            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                  left: 10,
                  right: 10
                ),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusGeometry.circular(30),
                  color: Color(0xffFFFDFA),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      offset: Offset(1, 1)
                    ),
                  ]
                ),
                child: Column(
                  children: [
                    // --- График ---
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _arrowButton("assets/home/left_icon.png", onPressed: () {
                            setState(() {
                              if(selectedIndex != 0) {
                                selectedIndex--;
                              }
                            });
                          }),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: List.generate(stats.length, (index) {
                                  final item = stats[index];
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
                          _arrowButton("assets/home/right_icon.png", onPressed: () {
                            setState(() {
                              if(selectedIndex != 4) {
                                selectedIndex++;
                              }
                            });
                          }),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // --- История ---
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Color(0xffF8F1EA),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "История",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'ActayWide',
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Expanded(
                              child: ListView.builder(
                                itemCount: history.length,
                                itemBuilder: (context, index) {
                                  final drink = history[index];
                                  return Container(
                                    margin: const EdgeInsets.symmetric(vertical: 6),
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF8F1EA),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${drink['time']} ${drink['title']}",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Actay',
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        Text(
                                          drink['ml']!,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Actay',
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _arrowButton(String path, {required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color(0xff209BED),
          shape: BoxShape.circle,
        ),
        child: Image.asset(path, width: 12),
      ),
    );
  }
}
