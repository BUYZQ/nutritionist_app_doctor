import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';

class CustomAppBar extends StatelessWidget {

  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        color: Color(0xffFFFDFA),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2)],
      ),
      child: Column(
        children: [
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(
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
              Expanded(
                child: Text(
                  textAlign: TextAlign.center,
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'ActayWide',
                    color: kPrimaryColor,
                  ),
                ),
              ),
              const SizedBox(width: 30),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}