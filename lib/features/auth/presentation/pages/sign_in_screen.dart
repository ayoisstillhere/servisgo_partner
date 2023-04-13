import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../components/default_button.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../widgets/form_header.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(32)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: getProportionateScreenHeight(106)),
            const FormHeader(
              title: 'Sign In',
              subtitle: 'Welcome back, Sign into your account',
            ),
            SizedBox(height: getProportionateScreenHeight(40)),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildEmailTextFormField(context),
                  SizedBox(height: getProportionateScreenHeight(24)),
                  _buildPasswordTextFormField(context),
                  SizedBox(height: getProportionateScreenHeight(24)),
                  _buildForgotPassword(context),
                  SizedBox(height: getProportionateScreenHeight(24)),
                  DefaultButton(
                    text: "Sign In",
                    press: () {},
                  ),
                  SizedBox(height: getProportionateScreenHeight(42)),
                  Center(child: SvgPicture.asset("assets/images/or.svg")),
                  SizedBox(height: getProportionateScreenHeight(42)),
                  Container(
                    height: getProportionateScreenHeight(56),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFE5E7EB)),
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(20)),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/google_icon.svg",
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(123)),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: "Don't have an account? ",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: kGreys,
                                  ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign Up',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: kCallToAction,
                                  ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildForgotPassword(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        "Forgot Password?",
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: kCallToAction),
      ),
    );
  }

  TextFormField _buildPasswordTextFormField(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w600,
            color: kPrimaryColor,
          ),
      decoration: InputDecoration(
        hintText: "Password",
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(16),
              horizontal: getProportionateScreenWidth(16)),
          child: SvgPicture.asset(
            "assets/icons/eye-suffix.svg",
          ),
        ),
        hintStyle: TextStyle(
          fontSize: getProportionateScreenWidth(16),
          fontWeight: FontWeight.normal,
          letterSpacing: 0,
          color: kGreys,
        ),
      ),
      obscureText: true,
    );
  }

  TextFormField _buildEmailTextFormField(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w600,
            color: kPrimaryColor,
          ),
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: TextStyle(
          fontSize: getProportionateScreenWidth(16),
          fontWeight: FontWeight.normal,
          letterSpacing: 0,
          color: kGreys,
        ),
      ),
    );
  }
}