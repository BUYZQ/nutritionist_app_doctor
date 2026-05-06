import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/home/widgets/custom_app_bar.dart';
import 'package:nutritionist_app/features/water/data/water_item.dart';
import 'package:nutritionist_app/features/water/screens/select_drink_screen.dart';
import 'package:nutritionist_app/widgets/my_button.dart';

class WaterTodoScreen extends StatefulWidget {
  final Map<String, List<WaterItem>> items;
  final String title;

  const WaterTodoScreen({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  State<WaterTodoScreen> createState() => _WaterTodoScreenState();
}

class _WaterTodoScreenState extends State<WaterTodoScreen> {

  late List<WaterItem> _todos = [];

  @override
  void initState() {
    _todos = widget.items[widget.title] ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F1EA),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: widget.title),
            Expanded(
              child: _todos.isEmpty
                  ? const Center(child: Text("Список напитков пуст"))
                  : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  final todo = _todos[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Color(0xffFFFDFA),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        todo.title,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'ActayWide',
                          color: kPrimaryColor,
                        ),
                      ),
                      subtitle: Row(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('HH:mm').format(todo.createdAt),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Actay',
                              color: Color(0xff656E6E),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${todo.ml} мл",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Actay',
                              color: kPrimaryColor,
                            ),
                          ),
                        ],

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

  // void navToSelectDrinkScreen() async {
  //   final result = await Navigator.of(context).push(
  //     MaterialPageRoute(builder: (context) => const SelectDrinkScreen()),
  //   );
  //
  //   if (result != null && result is Map<String, dynamic>) {
  //     setState(() {
  //       _todos.add(
  //         TodoItem(
  //           title: result['title'],
  //           ml: "${result['ml']} мл",
  //           createdAt: result['createdAt'],
  //         ),
  //       );
  //     });
  //   }
  // }

}
