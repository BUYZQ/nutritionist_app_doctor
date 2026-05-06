import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';

class ProfileCard extends StatelessWidget {

  final String title;
  final String imagePath;

  const ProfileCard({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffF6EEE9),
      borderRadius: BorderRadius.all(Radius.circular(11)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.all(Radius.circular(11)),
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Image.asset(imagePath, width: 40),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 15,
                      fontFamily: 'Actay',
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
