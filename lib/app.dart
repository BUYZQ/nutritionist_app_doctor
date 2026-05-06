import 'package:flutter/material.dart';
import 'package:nutritionist_app/features/home/screens/foodtodo_screen.dart';
import 'package:nutritionist_app/features/onboarding/screens/welcome_screen.dart';
import 'package:nutritionist_app/features/root/root_screen.dart';

class NutritionistApp extends StatefulWidget {
  const NutritionistApp({super.key});

  @override
  State<NutritionistApp> createState() => _NutritionistAppState();
}

class _NutritionistAppState extends State<NutritionistApp> {

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: const WelcomeScreen(),
      );
  }
}
