import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';

class MyButton extends StatelessWidget {

  final String title;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? foregroundColor;

  const MyButton({
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
