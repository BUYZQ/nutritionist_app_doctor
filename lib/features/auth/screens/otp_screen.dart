import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/auth/screens/login_screen.dart';
import 'package:nutritionist_app/features/auth/validators/auth_validators.dart';
import 'package:nutritionist_app/features/root/root_screen.dart';
import 'package:nutritionist_app/widgets/my_button.dart';
import 'package:nutritionist_app/widgets/my_text_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();
  final TextEditingController _codePassword = TextEditingController();

  bool isConfirmCode = false;
  
  // Ошибки валидации
  String? _codeError;
  String? _newPasswordError;
  String? _confirmPasswordError;

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
                                isConfirmCode
                                    ? "Изменить пароль"
                                    : "Подтверждение",
                                style: TextStyle(
                                  fontSize: 23,
                                  letterSpacing: 0.2,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'ActayWide',
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 40),
                              isConfirmCode
                                  ? Column(children: [
                                MyTextField(
                                  controller: _newPassword,
                                  hintText: "Новый пароль",
                                  errorText: _newPasswordError,
                                  obscureText: true,
                                  onChanged: (_) {
                                    setState(() => _newPasswordError = null);
                                  },
                                ),
                                SizedBox(height: 10),
                                MyTextField(
                                  controller: _confirmNewPassword,
                                  hintText: "Повторите пароль",
                                  errorText: _confirmPasswordError,
                                  obscureText: true,
                                  onChanged: (_) {
                                    setState(() => _confirmPasswordError = null);
                                  },
                                ),
                              ])
                                  : Column(
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
                                          controller: _codePassword,
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
                                  title: isConfirmCode ? "Войти" : "Продолжить",
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
    if (isConfirmCode) {
      // Валидация новых паролей
      setState(() {
        _newPasswordError = AuthValidators.validatePassword(_newPassword.text);
        _confirmPasswordError = AuthValidators.validatePasswordMatch(
          _confirmNewPassword.text,
          _newPassword.text,
        );
      });

      if (_newPasswordError != null || _confirmPasswordError != null) {
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
            return RootScreen();
          },
        ),
      );
    } else {
      // Валидация кода подтверждения
      setState(() {
        _codeError = AuthValidators.validateOtpCode(_codePassword.text);
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

      isConfirmCode = true;
      setState(() {});
    }
  }
}
