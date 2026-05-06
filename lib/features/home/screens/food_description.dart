import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/home/widgets/custom_app_bar.dart';

class FoodDescriptionScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<String> details;

  const FoodDescriptionScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.details,
  });

  @override
  State<FoodDescriptionScreen> createState() => _FoodDescriptionScreenState();
}

class _FoodDescriptionScreenState extends State<FoodDescriptionScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color((0xffF8F1EA)),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: widget.title),
            Expanded(
              child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xffFFFDFA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              widget.subtitle,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'ActayWide',
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xffFFFDFA),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(40),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: widget.details.map((item) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: '• ',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900, // жирная точка
                                              fontFamily: 'Actay',
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                          TextSpan(
                                            text: item,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Actay',
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

