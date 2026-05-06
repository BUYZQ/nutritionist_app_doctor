import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/widgets/my_button.dart';

class DrinkTile extends StatefulWidget {
  final String title;
  final void Function(String title, int ml)? onDrinkSelected; // <── добавили

  const DrinkTile({
    super.key,
    required this.title,
    this.onDrinkSelected,
  });

  @override
  State<DrinkTile> createState() => _DrinkTileState();
}


class _DrinkTileState extends State<DrinkTile> {
  int selectedNumber = 1; // выбранное значение

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffFEF8F1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: addDrink,
        child: Container(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: 'ActayWide',
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addDrink() {
    // контроллер с начальной позицией (selectedNumber - 1)
    final FixedExtentScrollController controller = FixedExtentScrollController(
      initialItem: selectedNumber - 1,
    );

    showDialog(
      context: context,
      builder: (context) {
        // локальная переменная для состояния выбора внутри диалога
        int localSelected = selectedNumber;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: const Color(0xffFEF8F1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 10,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'ActayWide',
                      color: kPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // карусель
                  SizedBox(
                    height: 150,
                    child: Stack(
                      children: [
                        // колесо
                        ListWheelScrollView.useDelegate(
                          controller: controller,
                          itemExtent: 50,
                          diameterRatio: 1.8,
                          perspective: 0.005,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              localSelected = index + 1;
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              if (index < 0 || index >= 300) return null;
                              final isSelected = localSelected == index + 1;
                              return Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontSize: isSelected ? 26 : 20,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    color: isSelected
                                        ? kPrimaryColor
                                        : Colors.grey.shade500,
                                  ),
                                ),
                              );
                            },
                            childCount: 300,
                          ),
                        ),

                        // опциональная линия/рамка для центра (визуальный маркер)
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: kPrimaryColor, width: 1),
                                bottom: BorderSide(
                                  color: kPrimaryColor,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 150.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "МЛ",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'ActayWide',
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  MyButton(
                    title: "Готово",
                    onPressed: () {
                      Navigator.pop(context); // Закрываем диалог
                      widget.onDrinkSelected?.call(widget.title, localSelected); // <── передаём данные
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
