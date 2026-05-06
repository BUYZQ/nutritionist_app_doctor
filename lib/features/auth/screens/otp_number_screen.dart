import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/auth/screens/otp_register_screen.dart';
import 'package:nutritionist_app/features/auth/screens/otp_screen.dart';
import 'package:nutritionist_app/features/auth/validators/auth_validators.dart';
import 'package:nutritionist_app/widgets/my_button.dart';
import 'package:nutritionist_app/widgets/my_text_field.dart';

class OtpNumberScreen extends StatefulWidget {
  const OtpNumberScreen({super.key});
  @override
  State<OtpNumberScreen> createState() => _OtpNumberScreenState();
}

class _OtpNumberScreenState extends State<OtpNumberScreen> {
  final TextEditingController phoneController = TextEditingController();
  String? _phoneError;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/auth/bg.jpg', fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SvgPicture.asset("assets/app/logo.svg", width: 120)],
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery
                      .of(context)
                      .size
                      .height,
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 40,
                            horizontal: 30,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: kPrimaryColor,
                          ),
                          child: Column(
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                "Подтверждение",
                                style: TextStyle(
                                  fontSize: 23,
                                  letterSpacing: 0.2,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'ActayWide',
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                textAlign: TextAlign.center,
                                "Подтвердите свой номер телефона",
                                style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 0.2,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'ActayWide',
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 20),
                              MyTextField(
                                hintText: "Введите номер телефона",
                                controller: phoneController,
                                errorText: _phoneError,
                                keyboardType: TextInputType.phone,
                                onChanged: (_) {
                                  setState(() => _phoneError = null);
                                },
                              ),
                              SizedBox(height: 34),
                              SizedBox(
                                height: 45,
                                width: double.infinity,
                                child: MyButton(
                                  bgColor: Color(0xffFFFDFA),
                                  foregroundColor: kPrimaryColor,
                                  title: "Продолжить",
                                  onPressed: navToOtpScreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navToOtpScreen() {
    // Валидация номера телефона
    setState(() {
      _phoneError = AuthValidators.validatePhone(phoneController.text);
    });

    if (_phoneError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Пожалуйста, введите корректный номер телефона'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return OtpRegisterScreen();
        },
      ),
    );
  }
}
