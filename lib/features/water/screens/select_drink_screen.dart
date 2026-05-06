import 'package:flutter/material.dart';
import 'package:nutritionist_app/features/home/widgets/custom_app_bar.dart';
import 'package:nutritionist_app/features/water/widgets/drink_tile.dart';

class SelectDrinkScreen extends StatefulWidget {
  const SelectDrinkScreen({super.key});

  @override
  State<SelectDrinkScreen> createState() => _SelectDrinkScreenState();
}

class _SelectDrinkScreenState extends State<SelectDrinkScreen> {
  List<String> drinks = [
    "Вода",
    "Газированная вода",
    "Чёрный чай",
    "Зелёный чай",
    "Эспрессо",
    "Американо",
    "Капучино",
    "Латте",
    "Макиато",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: "Выбор напитка"),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.builder(
                  itemCount: drinks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: DrinkTile(
                        title: drinks[index],
                        onDrinkSelected: (title, ml) {
                          Navigator.pop(context, {
                            'title': title,
                            'ml': ml,
                            'createdAt': DateTime.now(),
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
