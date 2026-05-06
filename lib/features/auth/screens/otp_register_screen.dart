import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/auth/validators/auth_validators.dart';
import 'package:nutritionist_app/features/root/root_screen.dart';
import 'package:nutritionist_app/widgets/my_button.dart';
import 'package:nutritionist_app/widgets/my_text_field.dart';

class OtpRegisterScreen extends StatefulWidget {
  const OtpRegisterScreen({super.key});

  @override
  State<OtpRegisterScreen> createState() => _OtpRegisterScreenState();
}

class _OtpRegisterScreenState extends State<OtpRegisterScreen> {

  final TextEditingController _codeController = TextEditingController();
  String? _codeError;

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
                  minHeight: MediaQuery.of(context).size.height,
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
                              SizedBox(height: 40),
                              Column(
                                children: [
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Пожалуйста, введите код из SMS",
                                    style: TextStyle(
                                      fontSize: 12,
                                      letterSpacing: 0.2,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'ActayWide',
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  MyTextField(
                                    controller: _codeController,
                                    hintText: "Введите код",
                                    errorText: _codeError,
                                    keyboardType: TextInputType.number,
                                    onChanged: (_) {
                                      setState(() => _codeError = null);
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      'Отправить код повторно',
                                      style: TextStyle(
                                        decoration:
                                        TextDecoration.underline,
                                        decorationColor: Colors.white,
                                        fontSize: 14,
                                        letterSpacing: 0.2,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'ActayWide',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 34),
                              SizedBox(
                                height: 45,
                                width: double.infinity,
                                child: MyButton(
                                  foregroundColor: kPrimaryColor,
                                  bgColor: Color(0xffFFFDFA),
                                  title: "Продолжить",
                                  onPressed: confirmCode,
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

  void confirmCode() {
    // Валидация кода подтверждения
    setState(() {
      _codeError = AuthValidators.validateOtpCode(_codeController.text);
    });

    if (_codeError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Пожалуйста, введите корректный код'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return RootScreen();
        },
      ),
    );
  }
}
