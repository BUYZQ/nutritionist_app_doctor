import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/home/widgets/person_container.dart';
import 'package:nutritionist_app/features/message/data/user_chat_info.dart';
import 'package:nutritionist_app/features/message/screens/chat_screen.dart';
import 'package:nutritionist_app/widgets/my_button.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PersonContainer(),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: MyButton(
              bgColor: const Color(0xff313F3F),
              foregroundColor: const Color(0xffFFFDFA),
              title: title ?? 'Профили клиентов',
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 20),
          ...kDoctorChats.map(
            (patient) => Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                bottom: 2.0,
              ),
              child: Card(
                color: const Color(0xffFFFDFA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(patient: patient),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Image.asset(patient.avatarPath, width: 70),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            patient.fullName,
                            style: const TextStyle(
                              fontSize: 15,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'ActayWide',
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
