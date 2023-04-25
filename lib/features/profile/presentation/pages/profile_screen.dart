import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servisgo_partner/features/profile/presentation/widgets/profile_item_tile.dart';

import '../../../../components/default_button.dart';
import '../../../../components/hamburger_menu_button.dart';
import '../../../../components/side_menu.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        child: const SideMenu(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(32),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getProportionateScreenHeight(58)),
              HamburgerMenuButton(
                scaffoldKey: _scaffoldKey,
                primaryColor: primaryColor,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                      height: getProportionateScreenHeight(172),
                      width: getProportionateScreenWidth(172),
                      decoration: BoxDecoration(
                        color: kBgColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xFF9CA3AF).withOpacity(0.12),
                              blurRadius: 85.5,
                              offset: const Offset(8.55, 26.65)),
                        ],
                      ),
                      child: Center(
                        child: Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/servisgo-fyp.appspot.com/o/Default_PFP.png?alt=media&token=c6cec350-3a9b-4c85-a219-a9d5a8a1a3db",
                        ),
                      ),
                    ),
                    Positioned(
                      top: getProportionateScreenHeight(112),
                      right: 0,
                      child: Container(
                        height: getProportionateScreenHeight(48),
                        width: getProportionateScreenWidth(48),
                        padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kCallToAction,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/Camera.svg",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0XFFFA99D3),
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(6),
                          vertical: getProportionateScreenHeight(6),
                        ),
                        child: Image.asset(
                          "assets/icons/CleaningIcon.png",
                          height: getProportionateScreenHeight(20.54),
                          width: getProportionateScreenWidth(20.54),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      Text(
                        "Cleaner",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "4.2",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.dark
                                      ? kBgColor
                                      : kBlacks,
                            ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Row(
                        children: [
                          Text(
                            "Rating",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SvgPicture.asset("assets/icons/profileRatingStar.svg")
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "6",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.dark
                                      ? kBgColor
                                      : kBlacks,
                            ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Text(
                        "Completed",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(32)),
              const ProfileItemTile(
                field: "Name",
                value: "Blessing Ornu",
              ),
              SizedBox(height: getProportionateScreenHeight(16)),
              const ProfileItemTile(
                field: "Phone",
                value: "08093449931",
              ),
              SizedBox(height: getProportionateScreenHeight(16)),
              const ProfileItemTile(
                field: "Email",
                value: "bornu@gmail.com",
              ),
              SizedBox(height: getProportionateScreenHeight(16)),
              const ProfileItemTile(
                field: "Locatin",
                value: "Lekki",
              ),
              SizedBox(height: getProportionateScreenHeight(114)),
              DefaultButton(
                text: "Save Changes",
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
