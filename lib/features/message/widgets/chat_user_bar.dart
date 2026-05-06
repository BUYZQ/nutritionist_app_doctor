import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/message/data/user_chat_info.dart';
import 'package:nutritionist_app/features/message/screens/patient_profile.dart';

class ChatUserBar extends StatefulWidget {
  const ChatUserBar({
    super.key,
    required this.patient,
  });

  final UserChatInfo patient;

  @override
  State<ChatUserBar> createState() => _ChatUserBarState();
}

class _ChatUserBarState extends State<ChatUserBar> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Material(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Colors.white,
        child: InkWell(
          onTap: navToProfileDoctor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset(
                        'assets/message/left_icon.png',
                        width: 32,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(widget.patient.avatarPath, width: 80),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        widget.patient.fullName,
                        style: const TextStyle(
                          fontSize: 15,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'ActayWide',
                          color: kPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        textAlign: TextAlign.center,
                        widget.patient.lastSeenText,
                        style: const TextStyle(
                          fontSize: 13,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Actay',
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navToProfileDoctor() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return PatientProfile(patient: widget.patient);
        },
      ),
    );
  }
}
