import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/medicine/data/taking_medication_info.dart';
import 'package:nutritionist_app/features/medicine/screens/taking_medications_screens.dart';

class TakingMedicationsNavPanel extends StatefulWidget {

  const TakingMedicationsNavPanel({
    super.key,
  });

  @override
  State<TakingMedicationsNavPanel> createState() => _TakingMedicationsNavPanelState();
}

class _TakingMedicationsNavPanelState extends State<TakingMedicationsNavPanel> {

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        TakingMedicationsNavPanelCard(
          title: "Приём лекарств",
          dayTime: "Утро",
        ),
        TakingMedicationsNavPanelCard(
          title: "Приём лекарств",
          dayTime: "День",
        ),
        TakingMedicationsNavPanelCard(
          title: "Приём лекарств",
          dayTime: "Вечер",
        ),
        TakingMedicationsNavPanelCard(
          title: "Приём лекарств",
          dayTime: "На ночь",
        ),
      ],
    );
  }
}

class TakingMedicationsNavPanelCard extends StatefulWidget {
  final String title;
  final String dayTime;

  const TakingMedicationsNavPanelCard({super.key, required this.title, required this.dayTime});

  @override
  State<TakingMedicationsNavPanelCard> createState() => _TakingMedicationsNavPanelCardState();
}

class _TakingMedicationsNavPanelCardState extends State<TakingMedicationsNavPanelCard> {

  final Map<String, TakingMedicationInfo> medicationsDetails = {
    "Утро": TakingMedicationInfo(
      title: "Утренний прием",
      details: [
        "Витамин Д3 принят после еды с продуктами, содержащими жиры (яйца, авокадо, сыр, орехи, растительное масло)",
        "Витамины группы В (В1, В2, В3, В5, В6, В9, В12) приняты после еды",
        "Витамины запиты чистой водой комнатной температуры (не кофе, не чай, не молоко)",
        "Витамин Д3 и витамины группы В приняты вместе (допустимо, негативных взаимодействий нет)",
      ],
    ),
    "День": TakingMedicationInfo(
      title: "Дневной прием",
      details: [
        "Вторая часть витамина Д3 принята (если назначена высокая дозировка 2000–4000 МЕ и выше) ",
        "Часть витаминов группы В принята в обед (если утренний приём вызвал дискомфорт в желудке)",
        "Магний с витамином В6 принят (если рекомендовано для поддержки нервной системы)",
      ],
    ),
    "Вечер": TakingMedicationInfo(
      title: "Вечерний прием",
      details: [
        "Витамин Д3 и витамины группы В НЕ приняты вечером (чтобы не нарушить сон)",
        "Витамин В6 НЕ принят после 18:00",
        "Если работаю в ночную смену: витамины приняты в начале моего активного периода",
      ],
    ),
    "На ночь": TakingMedicationInfo(
      title: "Приём на ночь",
      details: [
        "Магний (цитрат, глицинат или малат) принят для расслабления нервной системы",
        "Успокаивающие травы (пустырник, валериана, мелисса) приняты (если рекомендовано врачом)",
      ],
    ),
  };


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffF8F1EA),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return TakingMedicationsScreens(takingMedInfo: medicationsDetails[widget.dayTime] ?? TakingMedicationInfo(title: "", details: []));
              })
          );
        },
        child: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 17,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'ActayWide',
                  color: kPrimaryColor,
                ),
              ),
              Text(
                widget.dayTime,
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 0.2,
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
  }
}
