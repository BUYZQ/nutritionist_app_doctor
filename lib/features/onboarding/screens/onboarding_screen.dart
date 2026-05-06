import 'package:flutter/material.dart';
import 'package:nutritionist_app/constants.dart';
import 'package:nutritionist_app/features/auth/screens/login_screen.dart';
import 'package:nutritionist_app/widgets/my_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  List<Map<String, String>> onboardingData = [
    {
      "title": "Питайся осознанно",
      "disc": "Осознанное питание — это не строгая диета, а новый взгляд на то, что вы едите.",
      "imagePath": "assets/onboarding/onboarding_first.png",
    },
    {
      "title": "Твое тело скажет спасибо",
      "disc": "Ощутите, каково это — просыпаться с легкостью, иметь ясность мыслей и энергию для свершений",
      "imagePath": "assets/onboarding/onboarding_second.png",
    },
    {
      "title": "Здоровье начинается внутри",
      "disc": "Подарите своему телу правильные питательные вещества, и оно расцветет энергией и сияющим самочувствием",
      "imagePath": "assets/onboarding/onboarding_third.png",
    },
  ];
  final PageController _pageController = PageController();
  int _currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: onboardingBG,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 30),
              _currentScreen != 2 ?
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: navToLogin,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Пропустить',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'ActayWide',
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ) : SizedBox(),
              Expanded(
                child: PageView.builder(
                  onPageChanged: (page) {
                    _currentScreen = page;
                    setState(() {});
                  },
                  controller: _pageController,
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Image.asset(
                            onboardingData[index]["imagePath"]!,
                            width: 320,
                          ),
                          SizedBox(height: 30),
                          Text(
                            textAlign: TextAlign.center,
                            onboardingData[index]["title"]!,
                            style: TextStyle(
                              fontSize: 23,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'ActayWide',
                              color: kPrimaryColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            textAlign: TextAlign.center,
                            onboardingData[index]["disc"]!,
                            style: TextStyle(
                              fontSize: 17,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'ActayWide',
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                height: 50,
                width: double.infinity,
                child: MyButton(
                  title: 'Дальше',
                  onPressed: () {
                   if(_currentScreen == 2) {
                     navToLogin();
                   }
                   _pageController.nextPage(
                     duration: Duration(milliseconds: 500),
                     curve: Curves.ease,
                   );
                  },
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  void navToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }),
    );
  }
}
