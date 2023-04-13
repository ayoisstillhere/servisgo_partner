import 'package:flutter/material.dart';

import '../../../../components/default_button.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../../auth/presentation/pages/sign_in_screen.dart';
import 'onboarding_content.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/Onboarding1.png",
      "header": "Welcome to ServisGo User",
      "text":
          "Thank you for joining our community of home service providers. With this app, you can easily connect with customers in need of home services, manage your appointments and earnings, and build your reputation.",
    },
    {
      "image": "assets/images/Onboarding2.png",
      "header": "Boost Your Earnings",
      "text":
          "As a service provider on our platform, you can earn extra income by offering your skills and expertise to customers who need them. With our app, you can manage your availability, receive appointment requests, and track your earnings in real-time.",
    },
    {
      "image": "assets/images/Onboarding3.png",
      "header": "Join a Growing Community",
      "text":
          "Our app is a hub for home service providers who want to connect with customers, showcase their work, and grow their businesses. Whether you're a cleaner, a handyman, or a landscaper, you'll find a supportive community of like-minded professionals here.",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(56)),
          Expanded(
            flex: 5,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) => OnboardingContent(
                image: onboardingData[index]['image'],
                header: onboardingData[index]['header'],
                text: onboardingData[index]['text'],
                index: currentPage,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _buildSliderIndicator(),
                SizedBox(height: getProportionateScreenHeight(32)),
                DefaultButton(
                  text: 'Get Started',
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildSliderIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildDot(0),
        SizedBox(width: getProportionateScreenWidth(4)),
        _buildDot(1),
        SizedBox(width: getProportionateScreenWidth(4)),
        _buildDot(2)
      ],
    );
  }

  Container _buildDot(int index) {
    final primaryColor =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? kDarkPrimaryColor
            : kPrimaryColor;
    return currentPage == index
        ? Container(
            height: getProportionateScreenHeight(8),
            width: getProportionateScreenWidth(32),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(
                  getProportionateScreenWidth(24),
                )),
          )
        : Container(
            height: getProportionateScreenHeight(8),
            width: getProportionateScreenWidth(8),
            decoration: const BoxDecoration(
              color: kGreys,
              shape: BoxShape.circle,
            ),
          );
  }
}
