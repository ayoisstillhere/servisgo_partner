import 'package:flutter/material.dart';

import '../../../auth/domain/entities/partner_entity.dart';

import '../../../../components/hamburger_menu_button.dart';
import '../../../../components/side_menu.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../widgets/no_results_body.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({
    Key? key,
    required this.currentPartner,
  }) : super(key: key);
  final PartnerEntity currentPartner;

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final primaryColor =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? kDarkPrimaryColor
            : kPrimaryColor;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        width: getProportionateScreenWidth(260),
        child: SideMenu(
          currentPartner: widget.currentPartner,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: getProportionateScreenHeight(58)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(32)),
            child: HamburgerMenuButton(
              scaffoldKey: _scaffoldKey,
              primaryColor: primaryColor,
            ),
          ),
          const NoResultsBody(),
        ],
      ),
    );
  }
}
