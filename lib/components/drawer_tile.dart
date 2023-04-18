// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../size_config.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key? key,
    required this.primaryColor,
    required this.iconUrl,
    required this.title,
    required this.press,
  }) : super(key: key);

  final Color primaryColor;
  final String iconUrl;
  final String title;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
          vertical: getProportionateScreenHeight(10),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconUrl,
              color: primaryColor,
            ),
            SizedBox(width: getProportionateScreenWidth(12)),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
