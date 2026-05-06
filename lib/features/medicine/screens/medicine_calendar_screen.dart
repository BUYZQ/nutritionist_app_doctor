import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicineCalendarScreen extends StatefulWidget {

  final Color? foreground;

  const MedicineCalendarScreen({super.key, this.foreground});

  @override
  State<MedicineCalendarScreen> createState() => _MedicineCalendarScreenState();
}

class _MedicineCalendarScreenState extends State<MedicineCalendarScreen> {
  final CleanCalendarController _calendarController = CleanCalendarController(
    minDate: DateTime(2025),
    maxDate: DateTime(2050),
  );

  /// список посещённых дней
  final List<DateTime> visitedDays = [];

  /// сравнение только по дате, без времени
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  void initState() {
    super.initState();
    _loadVisitedDays(); // загружаем сохранённые посещения
  }

  /// загрузка посещённых дней из SharedPreferences
  Future<void> _loadVisitedDays() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('visited_days') ?? [];
    visitedDays.addAll(saved.map((s) => DateTime.parse(s)));

    final today = DateTime.now();

    // если сегодня ещё не добавлен — добавляем
    if (!visitedDays.any((d) => isSameDay(d, today))) {
      visitedDays.add(today);
    }

    // сохраняем обратно
    await prefs.setStringList(
      'visited_days',
      visitedDays.map((d) => d.toIso8601String()).toList(),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Верхняя панель
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                color: Colors.white,
                boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2)],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Material(
                        color: Color(0xffFEF8F1),
                        borderRadius: BorderRadius.circular(40),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            height: 60,
                            width: 60,
                            child: const Icon(Icons.arrow_back, size: 40),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.center,
                          "Календарь\nприёма лекарств",
                          style: TextStyle(
                            fontSize: 22,
                            letterSpacing: 0.2,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'ActayWide',
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Заголовки дней недели
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _WeekDayLabel("Вс"),
                      _WeekDayLabel("Пн"),
                      _WeekDayLabel("Вт"),
                      _WeekDayLabel("Ср"),
                      _WeekDayLabel("Чт"),
                      _WeekDayLabel("Пт"),
                      _WeekDayLabel("Сб"),
                    ],
                  ),
                ],
              ),
            ),

            // Сам календарь
            Expanded(
              child: ScrollableCleanCalendar(
                locale: "ru",
                calendarController: _calendarController,
                layout: Layout.BEAUTY,
                showWeekdays: false,
                calendarCrossAxisSpacing: 20,

                // Название месяца
                monthBuilder: (context, month) {
                  final monthName = month.split(' ').first;
                  return Text(
                    monthName,
                    style: TextStyle(
                      fontSize: 26,
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'ActayWide',
                      color: kPrimaryColor,
                    ),
                  );
                },

                // Кастомизация дней
                dayBuilder: (context, values) {
                  final currentDay = values.day;

                  final visited = visitedDays.any((d) => isSameDay(d, currentDay));
                  final isSelected = values.isSelected;
                  final isToday = isSameDay(currentDay, DateTime.now()); // ← исправлено!

                  Color bgColor = Colors.transparent;
                  Color textColor = kPrimaryColor;

                  if (visited) {
                    bgColor = Colors.green.withOpacity(0.3);
                  }
                  if (isToday) {
                    bgColor = Colors.grey.shade300;
                  }
                  if (isSelected) {
                    bgColor = widget.foreground ?? kPrimaryColor;
                    textColor = Colors.white;
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${currentDay.day}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'ActayWide',
                        color: textColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeekDayLabel extends StatelessWidget {
  final String label;
  const _WeekDayLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w700,
        fontFamily: 'ActayWide',
        color: kPrimaryColor,
      ),
    );
  }
}
