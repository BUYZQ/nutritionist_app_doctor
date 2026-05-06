import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/auth/screens/login_screen.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    navToLogin();
    super.initState();
  }

  Future<void> navToLogin() async {
   await Future.delayed(Duration(seconds: 2));
   Navigator.of(context).push(
     MaterialPageRoute(builder: (context) {
       return LoginScreen();
     }),
   );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: onboardingBG,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/app/logo.svg', width: 200),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              height: 5,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffB88F57),
                borderRadius: BorderRadius.circular(0.1),
              ),
            ),
            SizedBox(height: 22),
            Text(
              softWrap: false,
              textAlign: TextAlign.center,
              'Ваш карманный нутрициолог',
              style: TextStyle(
                  fontSize: 19,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'ActayWide',
                  color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
