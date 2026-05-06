import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';

class UserStrick extends StatelessWidget {

  final Color? background;
  final Color? foreground;

  const UserStrick({
    super.key,
    this.background,
    this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background ?? Color(0xffFEF8F1),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Прогресс",
            style: TextStyle(
              fontSize: 24,
              letterSpacing: 0.2,
              fontWeight: FontWeight.w700,
              fontFamily: 'ActayWide',
              color: kPrimaryColor,
            ),
          ),
          Stack(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: 1,
                  strokeWidth: 8,
                  color: foreground ?? Color(0xff3E8A35),
                ),
              ),
              Positioned(
                top: 19,
                left: 19,
                child: Text(
                  "7\nдней",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'ActayWide',
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}