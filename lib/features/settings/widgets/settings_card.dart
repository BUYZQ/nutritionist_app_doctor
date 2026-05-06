import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';

class SettingsCard extends StatelessWidget {

  final String title;
  final String subtitle;
  final String imagePath;

  const SettingsCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffFFFDFA),
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child:Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontFamily: 'ActayWide',
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(30),
                child: Row(
                  children: [
                    Image.asset(imagePath, width: 30),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontFamily: 'Actay',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
