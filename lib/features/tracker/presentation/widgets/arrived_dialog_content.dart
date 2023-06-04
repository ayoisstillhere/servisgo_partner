import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../../../../size_config.dart';

import '../bloc/accepted_service_cubit/accepted_service_cubit.dart';

class ArrivedDialogContent extends StatelessWidget {
  const ArrivedDialogContent({
    Key? key,
    required this.acceptedSericeId,
  }) : super(key: key);
  final String acceptedSericeId;

  @override
  Widget build(BuildContext context) {
    final primaryColor =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? kDarkPrimaryColor
            : kPrimaryColor;
    return Container(
      height: getProportionateScreenHeight(284),
      width: getProportionateScreenWidth(320),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(6),
        vertical: getProportionateScreenWidth(16),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/celebration.svg"),
                Text(
                  "You Have Arrived!",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Meet the customer to start the job. You will receive pay and a rating after the job is done.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: const Color(0xFF878C94)),
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<AcceptedServiceCubit>(context)
                        .updateServiceToOnGoing(
                      acceptedSericeId,
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  },
                  child: Container(
                    width: getProportionateScreenWidth(224),
                    height: getProportionateScreenHeight(36),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: primaryColor,
                    ),
                    child: Center(
                        child: Text(
                      "Return Home",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark
                              ? kBlacks
                              : kBgColor),
                    )),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<AcceptedServiceCubit>(context)
                    .updateServiceToOnGoing(
                  acceptedSericeId,
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              child: Container(
                alignment: Alignment.center,
                width: getProportionateScreenWidth(24),
                height: getProportionateScreenWidth(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    color: kOutlineVariant,
                  ),
                ),
                child: Icon(
                  Icons.close,
                  color: kOutlineVariant,
                  size: getProportionateScreenWidth(24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
