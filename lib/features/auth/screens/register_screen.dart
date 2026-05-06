import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/auth/screens/login_screen.dart';
import 'package:nutritionist_app/features/auth/screens/otp_number_screen.dart';
import 'package:nutritionist_app/features/auth/validators/auth_validators.dart';
import 'package:nutritionist_app/widgets/my_button.dart';
import 'package:nutritionist_app/widgets/my_outlined_button.dart';
import 'package:nutritionist_app/widgets/my_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dateBirthController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  
  // Ошибки валидации
  String? fullNameError;
  String? genderError;
  String? dateOfBirthError;
  String? countryError;
  String? phoneError;
  String? passwordError;
  String? confirmPasswordError;
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
                                "Регистрация",
                                style: TextStyle(
                                  fontSize: 23,
                                  letterSpacing: 0.2,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'ActayWide',
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 50),
                              MyTextField(
                                controller: fullNameController,
                                hintText: "ФИО",
                                errorText: fullNameError,
                                onChanged: (_) {
                                  setState(() => fullNameError = null);
                                },
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                controller: genderController,
                                hintText: "Пол",
                                errorText: genderError,
                                onChanged: (_) {
                                  setState(() => genderError = null);
                                },
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                controller: dateBirthController,
                                hintText: "Дата рождения",
                                errorText: dateOfBirthError,
                                onChanged: (_) {
                                  setState(() => dateOfBirthError = null);
                                },
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                controller: countryController,
                                hintText: "Страна",
                                errorText: countryError,
                                onChanged: (_) {
                                  setState(() => countryError = null);
                                },
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                controller: phoneController,
                                hintText: "Номер телефона",
                                errorText: phoneError,
                                keyboardType: TextInputType.phone,
                                onChanged: (_) {
                                  setState(() => phoneError = null);
                                },
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                controller: passwordController,
                                hintText: "Пароль",
                                errorText: passwordError,
                                obscureText: true,
                                onChanged: (_) {
                                  setState(() => passwordError = null);
                                },
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                controller: confirmPasswordController,
                                hintText: "Повторите пароль",
                                errorText: confirmPasswordError,
                                obscureText: true,
                                onChanged: (_) {
                                  setState(() => confirmPasswordError = null);
                                },
                              ),
                              SizedBox(height: 50),
                              SizedBox(
                                height: 45,
                                width: double.infinity,
                                child: MyButton(
                                  bgColor: Color(0xffFFFDFA),
                                  foregroundColor: kPrimaryColor,
                                  title: "Зарегестрироваться",
                                  onPressed: navToOTPNumberScreen,
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                height: 45,
                                width: double.infinity,
                                child: MyOutlinedButton(
                                  bgColor: kPrimaryColor,
                                  foregroundColor: Colors.white,
                                  title: "Войти",
                                  onPressed: navToLoginScreen,
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

  void navToOTPNumberScreen() {
    // Валидация всех полей
    final errors = AuthValidators.validateRegistration(
      fullName: fullNameController.text,
      gender: genderController.text,
      dateOfBirth: dateBirthController.text,
      country: countryController.text,
      phone: phoneController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    setState(() {
      fullNameError = errors['fullName'];
      genderError = errors['gender'];
      dateOfBirthError = errors['dateOfBirth'];
      countryError = errors['country'];
      phoneError = errors['phone'];
      passwordError = errors['password'];
      confirmPasswordError = errors['confirmPassword'];
    });

    // Если есть ошибки, не переходим дальше
    if (AuthValidators.hasValidationErrors(errors)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Пожалуйста, исправьте ошибки'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return OtpNumberScreen();
        },
      ),
    );
  }

  void navToLoginScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ),
    );
  }
}
