import 'package:flutter/material.dart';
import 'package:registration_app/app_styles.dart';
import 'package:registration_app/main.dart';
import 'package:registration_app/model/onboard_data.dart';
import 'package:registration_app/views/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets.dart';


class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: 6,
      width: 6,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : kGreyColor,
        shape: BoxShape.circle
      ),
    );
  }

 /* Future setSeenOnboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    seenOnboard = await prefs.setBool('seenOnboard', true);
  }

  @override
  void initState() {
    super.initState();
    setSeenOnboard();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OnBoardNavBtn(
                  name: 'Back',
                  onPressed: () {
                    _pageController.previousPage(duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                  },
                ),

                OnBoardNavBtn(
                  name: 'Skip',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpPage()),
                    );
                  },
                ),
              ],
            ),
            Expanded(
                flex: 4,
                child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
              },
                    itemCount: onboardingContents.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        const SizedBox(height: 100),
                        Container(
                          height: 180,
                          child: Image.asset(
                            onboardingContents[index].image,
                            fit: BoxFit.contain
                          ),
                        ),

                        const SizedBox(height: 60),

                        Text(
                            onboardingContents[index].title,
                            style: kTitle,
                            textAlign: TextAlign.center),
                        const SizedBox(height: 10),
                        Text(
                            onboardingContents[index].subTitle,
                            style: kBodyText1,
                            textAlign: TextAlign.center),

                        SizedBox(height: 20),

                      ],
                    )
                )),

            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(onboardingContents.length, (index) => dotIndicator(index))
                  ),

                  SizedBox(height: 20),

                  currentPage == onboardingContents.length - 1
                      ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomOutlinedButton(text: 'SIGN IN', onPressed: () {}),

                      CustomElevatedButton(text: 'NEW ACCOUNT', onPressed: () {})


                    ],
                  ) :

                  longButtons('NEXT', () {
                    _pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                  },
                  color: kPrimaryColor)

                ],
              ),
            ),








          ],
        ),
      ),

    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(150, 50),
            side: const BorderSide(width: 2, color: kPrimaryColor),
            foregroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: kPrimaryColor),
                borderRadius: BorderRadius.circular(12)
          )
        ),
        onPressed: onPressed,
        child: Text(text, style: kTitle.copyWith(fontSize: 14),),
      ),
    );
  }
}


class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 50),
            side: const BorderSide(width: 2, color: kPrimaryColor),
            foregroundColor: kPrimaryColor,
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            )
        ),
        onPressed: onPressed,
        child: Text(text, style: kTitle.copyWith(fontSize: 14, color: Colors.white),),
      ),
    );
  }
}


class OnBoardNavBtn extends StatelessWidget {
  const OnBoardNavBtn({
    Key? key,
    required this.name,
    required this.onPressed,
  }) : super(key: key);
  final String name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      splashColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          name,
          style: kBodyText1.copyWith(color: kBlackMainColor),
        ),
      ),
    );
  }
}






