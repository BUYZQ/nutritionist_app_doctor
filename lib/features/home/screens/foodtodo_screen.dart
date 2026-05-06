import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/home/data/food_details.dart';
import 'package:nutritionist_app/features/home/screens/food_description.dart';
import 'package:nutritionist_app/features/home/widgets/custom_app_bar.dart';

class FoodTodoScreen extends StatefulWidget {
  final Map<String, List<FoodDetails>> foodDetails;
  final String title;

  const FoodTodoScreen({
    super.key,
    required this.title,
    required this.foodDetails,
  });

  @override
  State<FoodTodoScreen> createState() => _FoodTodoScreenState();
}

class _FoodTodoScreenState extends State<FoodTodoScreen> {

  late final List<FoodDetails> _foods;

  @override
  void initState() {
    _foods = widget.foodDetails[widget.title] ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color((0xffF8F1EA)),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: widget.title),
            Expanded(
              child: _foods.isEmpty
                  ? const Center(child: Text("Список блюд пуст"))
                  : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _foods.length,
                itemBuilder: (context, index) {
                  final todo = _foods[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => navToFoodDescScreen(_foods[index]),
                    child: Container(
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
                          children: [
                            Text(
                              DateFormat('HH:mm').format(todo.dateTime),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Actay',
                                color:  Color(0xff656E6E),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              todo.desc,
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
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void navToFoodDescScreen(FoodDetails item) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return FoodDescriptionScreen(
          title: "Блюдо",
          subtitle: item.title,
          details: item.foodDetails,
        );
      })
    );
  }
}

// class TodoBottomBar extends StatefulWidget {
//   const TodoBottomBar({super.key});
//
//   @override
//   State<TodoBottomBar> createState() => _TodoBottomBarState();
// }
//
// class _TodoBottomBarState extends State<TodoBottomBar> {
//   bool isClickNameField = false;
//   bool isClickDescriptionField = false;
//
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descController = TextEditingController();
//
//   void _saveTodo() {
//     final title = _titleController.text.trim();
//     final desc = _descController.text.trim();
//
//     if (title.isEmpty || desc.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Заполните все поля")),
//       );
//       return;
//     }
//
//     final todo = TodoItem(
//       title: title,
//       description: desc,
//       createdAt: DateTime.now(),
//     );
//
//     Navigator.pop(context, todo);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Color(0xffFEF8F1),
//       insetPadding:
//       const EdgeInsets.only(top: 170, left: 20, right: 20, bottom: 20),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: SingleChildScrollView(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom + 20,
//         ),
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               InkWell(
//                 onTap: () {
//                   setState(() => isClickNameField = true);
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                   child: isClickNameField
//                       ? TextField(
//                     controller: _titleController,
//                     decoration: const InputDecoration(
//                       hintText: "Название блюда",
//                       border: InputBorder.none,
//                     ),
//                   )
//                       : Text(
//                     "Напишите название\nблюда",
//                     style: const TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.w700,
//                       fontFamily: 'ActayWide',
//                       color: kPrimaryColor,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Container(height: 1, color: Colors.black),
//               const SizedBox(height: 10),
//               InkWell(
//                 onTap: () {
//                   setState(() => isClickDescriptionField = true);
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                   child: isClickDescriptionField
//                       ? TextField(
//                     controller: _descController,
//                     maxLines: 6,
//                     decoration: const InputDecoration(
//                       hintText: "Описание",
//                       border: InputBorder.none,
//                     ),
//                   )
//                       : Text(
//                     "Подробно опишите что входит в блюдо",
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                       fontFamily: 'ActayWide',
//                       color: kPrimaryColor,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   MyButton(
//                     title: "Закрыть",
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   const SizedBox(width: 10),
//                   MyButton(
//                     title: "Сохранить",
//                     onPressed: _saveTodo,
//                   ),
//                   const SizedBox(width: 10),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class TodoItem {
  final String title;
  final String description;
  final DateTime createdAt;
  final List<String> details;

  TodoItem({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.details,
  });
}
