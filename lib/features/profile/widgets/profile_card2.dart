import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';

class ProfileCard2 extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const ProfileCard2({
    super.key,
    required this.title,
    required this.imagePath,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xffF6EEE9),
      borderRadius: const BorderRadius.all(Radius.circular(11)),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(11)),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              Image.asset(imagePath, width: 30),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 15,
                    fontFamily: 'Actay',
                  ),
                ),
              ),
              InkWell(
                onTap: onDelete,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Image.asset("assets/home/close.png", width: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
