import 'package:flutter/material.dart';

import '../../../../components/hamburger_menu_button.dart';
import '../../../../components/side_menu.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../../auth/domain/entities/partner_entity.dart';
import 'job_request_card.dart';

class OnlineHome extends StatelessWidget {
  const OnlineHome({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required this.partner,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final PartnerEntity partner;

  @override
  Widget build(BuildContext context) {
    final primaryColor =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? kDarkPrimaryColor
            : kPrimaryColor;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
          width: getProportionateScreenWidth(260),
          child: SideMenu(
            currentPartner: partner,
          )),
      // body: OfflineHome(scaffoldKey: _scaffoldKey, primaryColor: primaryColor),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(32)),
        child: Stack(
          children: [
            Positioned(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(114)),
                    Center(
                      child: Text(
                        "JOB REQUESTS",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: primaryColor),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    JobRequestCard(
                      primaryColor: primaryColor,
                      pfpURL:
                          "https://firebasestorage.googleapis.com/v0/b/servisgo-fyp.appspot.com/o/Default_PFP.png?alt=media&token=c6cec350-3a9b-4c85-a219-a9d5a8a1a3db",
                      name: "Ayodele Fagbami",
                      date: "Sep 15",
                      time: "14:00",
                      eta: 15,
                      service: "Cleaning",
                      price: 2000,
                      address: "14C Ola Crescent, High Gardens Estate, Ikota",
                      city: "Lekki",
                    ),
                    SizedBox(height: getProportionateScreenHeight(60)),
                    JobRequestCard(
                      primaryColor: primaryColor,
                      pfpURL:
                          "https://firebasestorage.googleapis.com/v0/b/servisgo-fyp.appspot.com/o/Default_PFP.png?alt=media&token=c6cec350-3a9b-4c85-a219-a9d5a8a1a3db",
                      name: "Ugochi Nkem",
                      date: "Sep 13",
                      time: "11:00",
                      eta: 15,
                      service: "Cleaning",
                      price: 1000,
                      address: "8B Ododo Rd, Surulere",
                      city: "Surulere",
                    ),
                    SizedBox(height: getProportionateScreenHeight(60)),
                    JobRequestCard(
                      primaryColor: primaryColor,
                      pfpURL:
                          "https://firebasestorage.googleapis.com/v0/b/servisgo-fyp.appspot.com/o/Default_PFP.png?alt=media&token=c6cec350-3a9b-4c85-a219-a9d5a8a1a3db",
                      name: "Ugochi Nkem",
                      date: "Sep 13",
                      time: "11:00",
                      eta: 15,
                      service: "Cleaning",
                      price: 1000,
                      address: "8B Ododo Rd, Surulere",
                      city: "Surulere",
                    ),
                    SizedBox(height: getProportionateScreenHeight(60)),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 58,
              child: HamburgerMenuButton(
                scaffoldKey: _scaffoldKey,
                primaryColor: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
