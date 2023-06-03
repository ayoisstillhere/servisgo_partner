// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servisgo_partner/features/home/domain/entities/user_entity.dart';
import 'package:servisgo_partner/features/home/presentation/bloc/user_cubit/user_cubit.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({
    Key? key,
    required this.status,
    required this.price,
    required this.service,
    required this.date,
    required this.customerId,
  }) : super(key: key);
  final String? status, price, service, date;
  final String customerId;

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          final UserEntity user = state.users
              .firstWhere((user) => user.uid == widget.customerId);
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(12),
                  vertical: getProportionateScreenHeight(16),
                ),
                width: double.infinity,
                height: getProportionateScreenHeight(148),
                decoration: BoxDecoration(
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? const Color(0xFF2A2A2A)
                      : kBgColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? const BoxShadow(
                            color: Colors.transparent,
                          )
                        : BoxShadow(
                            color: kBlacks.withOpacity(0.06),
                            spreadRadius: 0,
                            blurRadius: 30,
                            offset: const Offset(0, 8),
                          ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: kGreys,
                                  ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(4)),
                            Text(
                              "#${widget.price}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.dark
                                        ? kGreys
                                        : kBlacks,
                                  ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(8),
                            vertical: getProportionateScreenHeight(4),
                          ),
                          decoration: BoxDecoration(
                            color: widget.status == "Complete"
                                ? kPrimaryColor
                                : kCallToAction,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            widget.status!,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: widget.status == "Complete"
                                          ? kBgColor
                                          : kBlacks,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/work.svg",
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark
                              ? kGreys
                              : kBlacks,
                        ),
                        SizedBox(width: getProportionateScreenWidth(4)),
                        Text(
                          "${widget.service} Service",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/calendar.svg",
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark
                              ? kGreys
                              : kBlacks,
                        ),
                        SizedBox(width: getProportionateScreenWidth(4)),
                        Text(
                          widget.date!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(28)),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}
