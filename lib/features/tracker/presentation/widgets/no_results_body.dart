import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:servisgo_partner/features/auth/domain/entities/partner_entity.dart';

import '../../../../components/default_button.dart';
import '../../../../components/hamburger_menu_button.dart';
import '../../../../components/side_menu.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../../home/presentation/pages/home_screen.dart';

class NoResultsBody extends StatefulWidget {
  const NoResultsBody({
    Key? key,
    required this.currentPartner,
  }) : super(key: key);
  final PartnerEntity currentPartner;

  @override
  State<NoResultsBody> createState() => _NoResultsBodyState();
}

class _NoResultsBodyState extends State<NoResultsBody> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final primaryColor =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? kDarkPrimaryColor
            : kPrimaryColor;
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        width: getProportionateScreenWidth(260),
        child: SideMenu(
          currentPartner: widget.currentPartner,
        ),),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(32),
            ).copyWith(
              top: getProportionateScreenHeight(170),
            ),
            child: Column(
              children: [
                SvgPicture.asset("assets/images/notFound.svg"),
                SizedBox(height: getProportionateScreenHeight(60)),
                Text(
                  "No Results",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: primaryColor),
                ),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text(
                  "Seems like you don’t have any active bookings at the moment",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: kGreys),
                ),
                SizedBox(height: getProportionateScreenHeight(32)),
                DefaultButton(
                  text: "Return Home",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: getProportionateScreenHeight(58),
            left: getProportionateScreenWidth(32),
            child: HamburgerMenuButton(
              scaffoldKey: scaffoldKey,
              primaryColor: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
