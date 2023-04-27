// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servisgo_partner/features/home/presentation/pages/home_screen.dart';
import 'package:servisgo_partner/features/profile/presentation/pages/profile_screen.dart';
import 'package:servisgo_partner/features/tracker/presentation/pages/tracker_screen.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import '../features/auth/presentation/bloc/signin_cubit/signin_cubit.dart';
import '../main.dart';
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
                iconUrl: "assets/icons/homeDrawer.svg",
                title: "Home",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
              ),
              DrawerTile(
                primaryColor: primaryColor,
                iconUrl: "assets/icons/drawer/profile.svg",
                title: "View Profile",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                },
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
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  TrackerScreen()));
                },
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
                press: () async {
                  await BlocProvider.of<AuthCubit>(context).loggedOut();
                  await BlocProvider.of<SigninCubit>(context).submitSignOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyApp()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
