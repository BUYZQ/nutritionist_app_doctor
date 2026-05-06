import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/auth/screens/change_password_screen.dart';
import 'package:nutritionist_app/features/auth/screens/register_screen.dart';
import 'package:nutritionist_app/features/auth/validators/auth_validators.dart';
import 'package:nutritionist_app/features/home/screens/food_screen.dart';
import 'package:nutritionist_app/features/root/root_screen.dart';
import 'package:nutritionist_app/widgets/my_button.dart';
import 'package:nutritionist_app/widgets/my_outlined_button.dart';
import 'package:nutritionist_app/widgets/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  String? _phoneError;
  String? _passwordError;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/auth/bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/app/logo.svg",
                  width: 120,
                ),
              ],
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
                            horizontal: 30
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: kPrimaryColor,
                          ),
                          child: Column(
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                "Авторизация",
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
                                controller: _phoneController,
                                hintText: "Номер телефона",
                                errorText: _phoneError,
                                keyboardType: TextInputType.phone,
                                onChanged: (_) {
                                  setState(() {
                                    _phoneError = null;
                                  });
                                },
                              ),
                              SizedBox(height: 10),
                              MyTextField(
                                controller: _passwordController,
                                hintText: "Индивидуальный пароль",
                                errorText: _passwordError,
                                obscureText: true,
                                onChanged: (_) {
                                  setState(() {
                                    _passwordError = null;
                                  });
                                },
                              ),
                              SizedBox(height: 30),
                              InkWell(
                                onTap: navToChangePasswordScreen,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Забыли пароль',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                    fontSize: 16,
                                    letterSpacing: 0.2,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'ActayWide',
                                    color: Colors.white
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                height: 45,
                                width: double.infinity,
                                child: MyButton(
                                  bgColor: Color(0xffFFFDFA),
                                  foregroundColor: kPrimaryColor,
                                  title: "Войти",
                                  onPressed: navToRootScreen,
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                height: 45,
                                width: double.infinity,
                                child: MyOutlinedButton(
                                  bgColor: kPrimaryColor,
                                  foregroundColor: Colors.white,
                                  title: "Зарегестрироваться",
                                  onPressed: navToRegisterScreen,
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

  void navToRootScreen() {
    // Валидация данных
    setState(() {
      _phoneError = AuthValidators.validatePhone(_phoneController.text);
      _passwordError = AuthValidators.validatePassword(_passwordController.text);
    });

    // Если есть ошибки, не переходим дальше
    if (_phoneError != null || _passwordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Пожалуйста, исправьте ошибки'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return RootScreen();
        })
    );
  }


  void navToRegisterScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return RegisterScreen();
        })
    );
  }

  void navToChangePasswordScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return ChangePasswordScreen();
      })
    );
  }
}
