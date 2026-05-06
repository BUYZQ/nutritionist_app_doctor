import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';

class MyOutlinedButton extends StatelessWidget {

  final String title;
  final VoidCallback onPressed;
  final Color? bgColor;
  final Color? foregroundColor;

  const MyOutlinedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.bgColor,
    this.foregroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
        backgroundColor: bgColor == null ? kPrimaryColor : bgColor!,
        foregroundColor: foregroundColor ?? kPrimaryColor,
        side: BorderSide(
          style: BorderStyle.solid,
          color: foregroundColor ?? kPrimaryColor,
          width: 2,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          letterSpacing: 0.2,
          fontWeight: FontWeight.w700,
          fontFamily: 'ActayWide',
        ),
      ),
    );
  }
}
