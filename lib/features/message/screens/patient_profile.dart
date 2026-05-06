import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/home/widgets/calendar_mini.dart';
import 'package:nutritionist_app/features/home/widgets/food_tiles.dart';
import 'package:nutritionist_app/features/home/widgets/user_strick.dart';
import 'package:nutritionist_app/features/medicine/screens/taking_medications_nav_panel.dart';
import 'package:nutritionist_app/features/message/data/user_chat_info.dart';
import 'package:nutritionist_app/features/medicine/widgets/medicine_calendar_mini.dart';
import 'package:nutritionist_app/features/profile/widgets/profile_card.dart';
import 'package:nutritionist_app/features/water/widgets/statistic_nav_panel.dart';
import 'package:nutritionist_app/features/water/widgets/water_calendar_mini.dart';
import 'package:nutritionist_app/features/water/widgets/water_tiles.dart';
import 'package:nutritionist_app/widgets/my_button.dart';
import 'package:nutritionist_app/widgets/my_outlined_button_light.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({super.key, this.patient});

  final UserChatInfo? patient;

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {

  int currentMenuIndex = 0;
  final ScrollController _scroll = ScrollController();
  UserChatInfo get _patient => widget.patient ?? kDoctorChats.first;

  // Пример данных по дням
  final List<Map<String, dynamic>> stats = [
    {"date": DateTime(2026, 9, 30), "ml": 900},
    {"date": DateTime(2026, 10, 1), "ml": 900},
    {"date": DateTime(2026, 10, 2), "ml": 1350},
    {"date": DateTime(2026, 10, 3), "ml": 1250},
    {"date": DateTime(2026, 10, 4), "ml": 600},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F1EA),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              controller: _scroll,
              child: Column(
                children: [
                  SizedBox(height: 150),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                    child: Column(
                      spacing: 10,
                      children: [
                        SizedBox(height: 50),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusGeometry.circular(20),
                            color: Color(0xffFFFDFA),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withAlpha(50),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(-1, 1)
                              )
                            ],
                          ),
                          child: Column(
                            spacing: 10,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Text(
                                    "Персональные данныe",
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 18,
                                      fontFamily: 'ActayWide',
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Color(0xffF6EEE9),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Text(
                                  _patient.fullName,
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 14,
                                    fontFamily: 'Actay',
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Color(0xffF6EEE9),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Text(
                                  "13.03.1999",
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 14,
                                    fontFamily: 'Actay',
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Color(0xffF6EEE9),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Text(
                                  "Россия",
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 14,
                                    fontFamily: 'Actay',
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Color(0xffF6EEE9),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Text(
                                  "г. Нерюнгри",
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 14,
                                    fontFamily: 'Actay',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusGeometry.circular(20),
                            color: Color(0xffFFFDFA),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withAlpha(50),
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  offset: Offset(-1, 1)
                              )
                            ],
                          ),
                          child: Column(
                            spacing: 10,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Медицинская документация",
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 17,
                                      fontFamily: 'ActayWide',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              ProfileCard(
                                title: "Биохимический анализ крови",
                                imagePath: "assets/info/galery2.png",
                              ),
                              ProfileCard(
                                title: "Биохимический анализ крови",
                                imagePath: "assets/info/galery2.png",
                              ),
                              ProfileCard(
                                title: "Медицинское заключение",
                                imagePath: "assets/info/galery2.png",
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: 20),
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Врач",
                        //       style: TextStyle(
                        //         color: kPrimaryColor,
                        //         fontSize: 20,
                        //         fontFamily: 'ActayWide',
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Material(
                        //   color: Color(0xffFEF8F1),
                        //   borderRadius: BorderRadius.all(Radius.circular(40)),
                        //   child: InkWell(
                        //     borderRadius: BorderRadius.all(Radius.circular(40)),
                        //     onTap: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) {
                        //             return ProfileScreen();
                        //           },
                        //         ),
                        //       );
                        //     },
                        //     child: Container(
                        //       padding: const EdgeInsets.all(20),
                        //       child: Row(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Image.asset(
                        //             "assets/users/evgeniya.png",
                        //             width: 70,
                        //           ),
                        //           const SizedBox(width: 10),
                        //           Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: const [
                        //               Text(
                        //                 "Бикетова Евения\nАлександровна",
                        //                 style: TextStyle(
                        //                   fontSize: 13,
                        //                   letterSpacing: 0.2,
                        //                   fontWeight: FontWeight.w700,
                        //                   fontFamily: 'ActayWide',
                        //                   color: kPrimaryColor,
                        //                 ),
                        //               ),
                        //               SizedBox(height: 10),
                        //               Text(
                        //                 "Нажмите для просмотра",
                        //                 style: TextStyle(
                        //                   fontSize: 12,
                        //                   letterSpacing: 0.2,
                        //                   fontWeight: FontWeight.w700,
                        //                   fontFamily: 'ActayWide',
                        //                   color: kPrimaryColor,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 0),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusGeometry.circular(20),
                            color: Color(0xffFFFDFA),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withAlpha(50),
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  offset: Offset(-1, 1)
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    currentMenuIndex == 0 ? MyButton(
                                      title: "Питание",
                                      onPressed: () {},
                                    ) : MyOutlinedButtonLight(
                                      bgColor: Color(0xffFFFDFA),
                                      foregroundColor: Color(0xff313F3F),
                                      title: "Питание",
                                      onPressed: () {
                                        setState(() {
                                          currentMenuIndex = 0;
                                        });
                                      },
                                    ),
                                    currentMenuIndex == 1 ? MyButton(
                                      title: "Вода",
                                      onPressed: () {},
                                    ) : MyOutlinedButtonLight(
                                      bgColor: Color(0xffFFFDFA),
                                      foregroundColor: Color(0xff313F3F),
                                      title: "Вода",
                                      onPressed: () {
                                        setState(() {
                                          currentMenuIndex = 1;
                                        });
                                      },
                                    ),
                                    currentMenuIndex == 2 ? MyButton(
                                      title: "Витамины",
                                      onPressed: () {},
                                    ) : MyOutlinedButtonLight(
                                      bgColor: Color(0xffFFFDFA),
                                      foregroundColor: Color(0xff313F3F),
                                      title: "Витамины",
                                      onPressed: () {
                                        setState(() {
                                          currentMenuIndex = 2;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              currentMenuIndex == 0 ? Column(
                                children: [
                                  UserStrick(
                                    background: Color(0xffF3FFCF),
                                    foreground: Color(0xffA4C639),
                                  ),
                                  const SizedBox(height: 10),
                                  const CalendarMini(foreground: Color(0xffA4C639)),
                                  const SizedBox(height: 10),
                                  const FoodTiles(),
                                  const SizedBox(height: 10),
                                ],
                              ) : currentMenuIndex == 1 ?
                              Column(
                                children: [
                                  const UserStrick(
                                    background: Color(0xffD8EFFF),
                                    foreground: Color(0xff209BED),
                                  ),
                                  const SizedBox(height: 10),
                                  const WaterCalendarMini(foreground: Color(0xff209BED)),
                                  const SizedBox(height: 10),
                                  const WaterTiles(),
                                  StatisticsNavigationPanel(stats: stats),
                                  const SizedBox(height: 10),
                                ],
                              ) : Column(
                                children: [
                                  const UserStrick(
                                    background: Color(0xffFFFACD),
                                    foreground: Color(0xffF0BC00),
                                  ),
                                  const SizedBox(height: 10),
                                  const MedicineCalendarMini(foreground: Color(0xffF0BC00)),
                                  const SizedBox(height: 10),
                                  const TakingMedicationsNavPanel(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          // App Bar
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(20),
              color: Color(0xffFFFDFA),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withAlpha(50),
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(-1, 1)
                )
              ],
            ),
            width: double.infinity,
            height: 180,
          ),

          AnimatedBuilder(
            animation: _scroll,
            builder: (context, _) {
              final offset = _scroll.hasClients ? _scroll.offset : 0.0;

              // насколько проскроллили (0 → 1)
              final progress = (offset / 80).clamp(0.0, 1.0);

              // едет вверх
              final top = 80 - (25 * progress);

              // уменьшается
              final size = 150 - (40 * progress);

              return Positioned(
                top: top,
                left: 0,
                right: 0,
                child: Center(
                  child: SizedBox(
                    width: size,
                    height: size,
                    child: Image.asset(
                      _patient.avatarPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),

          Positioned(
            top: 80,
            left: 20,
            child: Center(
              child: SizedBox(
                width: 50,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    "assets/message/left_icon.png",
                    width: 32,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorInfoCard extends StatelessWidget {

  final String title;

  const DoctorInfoCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffFEF8F1),
      borderRadius: BorderRadius.all(Radius.circular(40)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(40),
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Image.asset("assets/info/pdf.png", width: 30),
                ),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 14,
                    fontFamily: 'ActayWide',
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
