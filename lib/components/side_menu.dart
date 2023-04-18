
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import 'drawer_tile.dart';
import 'info_card.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? kDarkPrimaryColor
            : kPrimaryColor;
    return Scaffold(
      body: Container(
        width: getProportionateScreenWidth(260),
        height: double.infinity,
        // color: Colors.blue,
        child: SafeArea(
          child: Column(
            children: [
              InfoCard(
                primaryColor: primaryColor,
                image:
                    "https://firebasestorage.googleapis.com/v0/b/servisgo-fyp.appspot.com/o/Default_PFP.png?alt=media&token=c6cec350-3a9b-4c85-a219-a9d5a8a1a3db",
                name: "Ajayi George",
                email: "george.ajayi@stu.cu.edu.ng",
              ),
              const Divider(color: kOutlineVariant),
              DrawerTile(
                primaryColor: primaryColor,
                iconUrl: "assets/icons/drawer/profile.svg",
                title: "View Profile",
                press: () {},
              ),
              DrawerTile(
                primaryColor: primaryColor,
                iconUrl: "assets/icons/drawer/notifications.svg",
                title: "Notifications",
                press: () {},
              ),
              const Divider(color: kOutlineVariant),
              DrawerTile(
                primaryColor: primaryColor,
                iconUrl: "assets/icons/drawer/tracker.svg",
                title: "Tracker",
                press: () {},
              ),
              DrawerTile(
                primaryColor: primaryColor,
                iconUrl: "assets/icons/drawer/history.svg",
                title: "History",
                press: () {},
              ),
              DrawerTile(
                primaryColor: primaryColor,
                iconUrl: "assets/icons/drawer/messages.svg",
                title: "Messages",
                press: () {},
              ),
              const Divider(color: kOutlineVariant),
              DrawerTile(
                primaryColor: primaryColor,
                iconUrl: "assets/icons/drawer/earnings.svg",
                title: "Earnings",
                press: () {},
              ),
              DrawerTile(
                primaryColor: primaryColor,
                iconUrl: "assets/icons/drawer/security.svg",
                title: "Security",
                press: () {},
              ),
              DrawerTile(
                primaryColor: primaryColor,
                iconUrl: "assets/icons/drawer/support.svg",
                title: "Support",
                press: () {},
              ),
              const Divider(color: kOutlineVariant),
              DrawerTile(
                primaryColor: primaryColor,
                iconUrl: "assets/icons/drawer/log-out.svg",
                title: "Log Out",
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
