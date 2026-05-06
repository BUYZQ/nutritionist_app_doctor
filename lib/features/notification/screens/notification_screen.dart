import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/home/widgets/custom_app_bar.dart';
import 'package:nutritionist_app/features/notification/widgets/notification_card.dart';
import 'package:nutritionist_app/features/profile/widgets/profile_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F1E9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(title: "Уведомления"),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Посмотренные",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'ActayWide',
                      color: kPrimaryColor,
                    ),
                  ),
                  NotificationCard(
                    title: "На платформе зарегистрировался новый пациент, прикреплённый к вам",
                    imagePath: "assets/root/community.png",
                    time: "7:00",
                  ),
                  NotificationCard(
                    title: "На платформе зарегистрировался новый пациент, прикреплённый к вам.",
                    imagePath: "assets/root/community.png",
                    time: "6:50",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
