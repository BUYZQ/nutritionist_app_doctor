import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';

class NotificationCard extends StatelessWidget {

  final String title;
  final String imagePath;
  final String time;

  const NotificationCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffFFFDFA),
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Image.asset(imagePath, width: 55),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Actay',
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  time,
                  style: TextStyle(
                    color: Color(0xff656E6E),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Actay',
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
