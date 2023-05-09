import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class JobRequestCard extends StatelessWidget {
  const JobRequestCard({
    Key? key,
    required this.primaryColor,
    required this.pfpURL,
    required this.name,
    required this.date,
    required this.time,
    required this.eta,
    required this.service,
    required this.price,
    required this.address,
    required this.city,
  }) : super(key: key);

  final Color primaryColor;
  final String pfpURL;
  final String name;
  final String date;
  final String time;
  final int eta;
  final String service;
  final double price;
  final String address;
  final String city;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
        vertical: getProportionateScreenHeight(16),
      ),
      width: double.infinity,
      height: getProportionateScreenHeight(296),
      decoration: BoxDecoration(
        border: Border.all(
          color: kOutlineVariant,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: getProportionateScreenWidth(32),
                child: Image.network(pfpURL),
              ),
              SizedBox(width: getProportionateScreenWidth(8)),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        Row(
                          children: [
                            Text(
                              date,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: kGreys,
                                  ),
                            ),
                            SizedBox(width: getProportionateScreenWidth(12)),
                            Text(
                              time,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: kGreys,
                                  ),
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "ETA",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: getProportionateScreenHeight(12)),
                        Text(
                          "$eta Mins",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: kGreys,
                                  ),
                        ),
                        SizedBox(width: getProportionateScreenWidth(16))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Service",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: kGreys),
                  ),
                  SizedBox(height: getProportionateScreenHeight(4)),
                  Text(
                    service,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(width: getProportionateScreenWidth(100)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Price Per Hour",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: kGreys),
                  ),
                  SizedBox(height: getProportionateScreenHeight(4)),
                  Text(
                    "#$price",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          const Divider(color: kOutlineVariant),
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/Location.svg",
                height: getProportionateScreenHeight(48),
                width: getProportionateScreenWidth(48),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(height: getProportionateScreenHeight(4)),
                    Text(
                      city,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: getProportionateScreenWidth(136),
                  decoration: BoxDecoration(
                      color: kLightGreys,
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(8))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(24),
                      vertical: getProportionateScreenHeight(8),
                    ),
                    child: Center(
                      child: Text(
                        "Decline",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: kGreys,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: getProportionateScreenWidth(136),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(8))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(24),
                      vertical: getProportionateScreenHeight(8),
                    ),
                    child: Center(
                      child: Text(
                        "Accept",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.dark
                                      ? kBlacks
                                      : kBgColor,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
