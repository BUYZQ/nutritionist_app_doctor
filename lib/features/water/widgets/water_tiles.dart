import 'package:flutter/material.dart';
import 'package:nutritionist_app/features/home/screens/foodtodo_screen.dart';
import 'package:nutritionist_app/features/water/data/water_item.dart';
import 'package:nutritionist_app/features/water/screens/water_todo_screen.dart';
import 'package:nutritionist_app/widgets/mt_list_tile.dart';

class WaterTiles extends StatefulWidget {
  const WaterTiles({
    super.key,
  });

  @override
  State<WaterTiles> createState() => _WaterTilesState();
}

class _WaterTilesState extends State<WaterTiles> {

  final Map<String, List<WaterItem>> _todos = {
    "Вода": [
      WaterItem(
        title: "Вода",
        ml: "300",
        createdAt: DateTime(
            2026,
            05,
            03,
            07,
            32
        ),
      ),
      WaterItem(
        title: "Вода",
        ml: "300",
        createdAt: DateTime(
            2026,
            05,
            03,
            09,
            00,
        ),
      ),
    ],
    "Другие напитки": [
      WaterItem(
        title: "Чёрный чай",
        ml: "250",
        createdAt: DateTime(
            2026,
            05,
            03,
            08,
            30
        ),
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyListTile(
          title: "Вода",
          subtitle: "Всего выпито воды: 600 мл",
          onTap: () => navToTodoScreen("Вода"),
        ),
        SizedBox(height: 10),
        MyListTile(
          title: "Другие напитки",
          subtitle: "Выпито других напитков: 250 мл",
          onTap: () => navToTodoScreen("Другие напитки"),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  void navToTodoScreen(String title) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return WaterTodoScreen(title: title, items: _todos);
      }),
    );
  }
}