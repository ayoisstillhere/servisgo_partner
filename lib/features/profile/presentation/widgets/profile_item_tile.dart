import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class ProfileItemTile extends StatelessWidget {
  const ProfileItemTile({
    Key? key,
    required this.field,
    required this.value,
  }) : super(key: key);
  final String field;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: getProportionateScreenWidth(66),
          child: Text(
            field,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(color: kGreys),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(60)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Divider(),
            ],
          ),
        ),
      ],
    );
  }
}
