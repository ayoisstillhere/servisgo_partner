
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../components/default_button.dart';
import '../../../../components/hamburger_menu_button.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';

class OfflineHome extends StatelessWidget {
  const OfflineHome({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required this.primaryColor,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: getProportionateScreenHeight(58)),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(32)),
          child: HamburgerMenuButton(
            scaffoldKey: _scaffoldKey,
            primaryColor: primaryColor,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(8)),
        Center(
          child: SizedBox(
            width: getProportionateScreenWidth(390),
            height: getProportionateScreenHeight(283.65),
            child: SvgPicture.asset(
              "assets/images/goOnline.svg",
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        Center(
          child: Text(
            "Go Online",
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: primaryColor),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(16)),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(32)),
          child: Center(
            child: Text(
              "Go online for Customers to contact you and start earning with ServisGo!",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: kGreys),
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(60)),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(32)),
          child: DefaultButton(
            text: "Go Online",
            press: () {},
          ),
        ),
      ],
    );
  }
}
