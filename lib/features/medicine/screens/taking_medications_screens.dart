import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/home/widgets/custom_app_bar.dart';
import 'package:nutritionist_app/features/medicine/data/taking_medication_info.dart';
import 'package:nutritionist_app/widgets/my_button.dart';

class TakingMedicationsScreens extends StatefulWidget {
  final TakingMedicationInfo takingMedInfo;

  const TakingMedicationsScreens({super.key, required this.takingMedInfo});

  @override
  State<TakingMedicationsScreens> createState() => _TakingMedicationsScreensState();
}

class _TakingMedicationsScreensState extends State<TakingMedicationsScreens> {
  late List<String> editableDetails;
  late List<String> originalDetails;
  late List<bool> checked;

  bool isEditMode = false;

  @override
  void initState() {
    super.initState();

    editableDetails = List.from(widget.takingMedInfo.details);
    originalDetails = List.from(widget.takingMedInfo.details);

    // Изначально все пункты «актуальны»
    checked = List.generate(editableDetails.length, (_) => false);
  }

  void onTextChanged(int index, String value) {
    editableDetails[index] = value;

    // Если текст изменился — снимаем галочку
    if (value.trim() != originalDetails[index].trim()) {
      checked[index] = false;
    } else {
      checked[index] = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F1EA),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "Курс приёма витаминов"),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    // Заголовок
                    Container(
                      alignment: Alignment.center,
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffFFFDFA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        widget.takingMedInfo.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'ActayWide',
                          color: kPrimaryColor,
                        ),
                      ),
                    ),

                    // Список
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xffFFFDFA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListView.builder(
                          itemCount: editableDetails.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Круглый неактивный checkbox
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Checkbox(
                                      fillColor: MaterialStateProperty.resolveWith((states) {
                                        if (states.contains(MaterialState.selected)) {
                                          return kPrimaryColor; // когда отмечен
                                        }
                                        return Colors.transparent; // когда не отмечен
                                      }),
                                      value: checked[index],
                                      onChanged: null,
                                      shape: const CircleBorder(),
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  // Текст или редактирование
                                  Expanded(
                                    child: isEditMode
                                        ? TextFormField(
                                      initialValue: editableDetails[index],
                                      maxLines: null,
                                      onChanged: (value) =>
                                          onTextChanged(index, value),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Actay',
                                        color: kPrimaryColor,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    )
                                        : Text(
                                      editableDetails[index],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Actay',
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Кнопка
                    SizedBox(
                      height: 50,
                      child: MyButton(
                        title:
                        isEditMode ? "Сохранить" : "Редактировать список",
                        onPressed: () {
                          setState(() {
                            isEditMode = !isEditMode;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}