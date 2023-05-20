import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.primaryColor,
    required this.image,
    required this.name,
    required this.email,
  }) : super(key: key);

  final Color primaryColor;
  final String image;
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white24,
            radius: getProportionateScreenWidth(20),
            backgroundImage: NetworkImage(
              image,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: getProportionateScreenWidth(10),
              height: getProportionateScreenHeight(10),
              decoration: BoxDecoration(
                color: const Color(0xFF12B76A),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
            ),
          ),
        ],
      ),
      title: Text(
        name,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
      ),
      subtitle: Text(
        email,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: kGreys,
            ),
      ),
    );
  }
}
