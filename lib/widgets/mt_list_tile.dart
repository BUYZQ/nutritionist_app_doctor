import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const MyListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(20),
        color: Color(0xffF8F1EA),
      ),
      child: ListTile(
        onTap: onTap,
        tileColor: Color(0xffda7004),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 17,
            letterSpacing: 0.2,
            fontWeight: FontWeight.w700,
            fontFamily: 'ActayWide',
            color: kPrimaryColor,
          ),
        ),
        subtitle: Text(
          subtitle ?? "",
          style: TextStyle(
            fontSize: 13,
            letterSpacing: 0.2,
            fontWeight: FontWeight.w500,
            fontFamily: 'Actay',
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}