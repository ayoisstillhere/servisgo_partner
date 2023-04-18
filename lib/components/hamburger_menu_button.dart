
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../size_config.dart';

class HamburgerMenuButton extends StatelessWidget {
  const HamburgerMenuButton({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required this.primaryColor,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _scaffoldKey.currentState!.openDrawer();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
          vertical: getProportionateScreenHeight(20),
        ),
        height: getProportionateScreenHeight(56),
        width: getProportionateScreenWidth(56),
        decoration: BoxDecoration(
          color: MediaQuery.of(context).platformBrightness ==
                  Brightness.dark
              ? kDarkBgColor
              : kBgColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              offset: const Offset(0, 8),
              blurRadius: 30,
              spreadRadius: 0,
            ),
          ],
        ),
        child: SvgPicture.asset(
          "assets/icons/hamBurgMenu.svg",
          color: primaryColor,
        ),
      ),
    );
  }
}
