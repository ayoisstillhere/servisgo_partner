// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:servisgo_partner/features/auth/domain/entities/partner_entity.dart';
import 'package:servisgo_partner/features/chat/presentation/pages/messages_screen.dart';
import 'package:servisgo_partner/features/history/presentation/pages/history_screen.dart';
import 'package:servisgo_partner/features/home/presentation/pages/home_screen.dart';
import 'package:servisgo_partner/features/notifications/presentation/pages/notifications_screen.dart';
import 'package:servisgo_partner/features/profile/presentation/pages/profile_screen.dart';
import 'package:servisgo_partner/features/security/presentation/pages/security_screen.dart';
import 'package:servisgo_partner/features/support/presentation/pages/help_support_screen.dart';
import 'package:servisgo_partner/features/tracker/presentation/pages/tracker_screen.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import '../features/auth/presentation/bloc/signin_cubit/signin_cubit.dart';
import '../features/home/presentation/bloc/partner_cubit/partner_cubit.dart';
import '../features/onboarding/presentation/pages/onboarding_screen.dart';
import 'drawer_tile.dart';
import 'info_card.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
    required this.currentPartner,
  }) : super(key: key);
  final PartnerEntity currentPartner;

  @override
  Widget build(BuildContext context) {
    final primaryColor =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? kDarkPrimaryColor
            : kPrimaryColor;
    return Scaffold(
      body: SizedBox(
        width: getProportionateScreenWidth(260),
        height: double.infinity,
        // color: Colors.blue,
        child: SafeArea(
          child: Column(
            children: [
              InfoCard(
                primaryColor: primaryColor,
                image: currentPartner.partnerPfpURL,
                name: currentPartner.partnerName,
                email: currentPartner.partnerEmail,
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
                          builder: (context) => ProfileScreen(currentPartner: currentPartner,)));
                },
              ),
              DrawerTile(
                primaryColor: primaryColor,
                iconUrl: "assets/icons/drawer/notifications.svg",
                title: "Notifications",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationsScreen()));
                },
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
                          builder: (context) => const TrackerScreen()));
                },
              ),
              DrawerTile(
                primaryColor: primaryColor,
                iconUrl: "assets/icons/drawer/history.svg",
                title: "History",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoryScreen()));
                },
              ),
              DrawerTile(
                primaryColor: primaryColor,
                iconUrl: "assets/icons/drawer/messages.svg",
                title: "Messages",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MessagesScreen()));
                },
              ),
              const Divider(color: kOutlineVariant),
              DrawerTile(
                primaryColor: primaryColor,
                iconUrl: "assets/icons/drawer/security.svg",
                title: "Security",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SecurityScreen()));
                },
              ),
              DrawerTile(
                primaryColor: primaryColor,
                iconUrl: "assets/icons/drawer/support.svg",
                title: "Support",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HelpSupportScreen()));
                },
              ),
              const Divider(color: kOutlineVariant),
              DrawerTile(
                primaryColor: primaryColor,
                iconUrl: "assets/icons/drawer/log-out.svg",
                title: "Log Out",
                press: () async {
                  await BlocProvider.of<AuthCubit>(context).loggedOut();
                  await BlocProvider.of<SigninCubit>(context).submitSignOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OnboardingScreen()),
                    (route) => false,
                  );
                },
              ),
              currentPartner.status == "online"
                  ? GestureDetector(
                      onTap: () {
                        update(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(16),
                          vertical: getProportionateScreenHeight(10),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: getProportionateScreenWidth(8),
                              backgroundColor: Colors.red,
                            ),
                            SizedBox(width: getProportionateScreenWidth(12)),
                            Text(
                              "Go Offline",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> update(BuildContext context) async {
    await BlocProvider.of<PartnerCubit>(context).updateStatus("offline");
  }
}
