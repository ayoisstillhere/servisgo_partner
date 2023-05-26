import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servisgo_partner/features/home/domain/entities/job_request_entity.dart';
import 'package:servisgo_partner/features/home/domain/entities/user_entity.dart';
import 'package:servisgo_partner/features/home/presentation/bloc/job_requests_cubit/job_requests_cubit.dart';
import 'package:servisgo_partner/features/home/presentation/bloc/user_cubit/user_cubit.dart';

import '../../../../components/hamburger_menu_button.dart';
import '../../../../components/side_menu.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../../auth/domain/entities/partner_entity.dart';
import 'job_request_card.dart';

class OnlineHome extends StatefulWidget {
  const OnlineHome({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required this.partner,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final PartnerEntity partner;

  @override
  State<OnlineHome> createState() => _OnlineHomeState();
}

class _OnlineHomeState extends State<OnlineHome> {
  @override
  void initState() {
    BlocProvider.of<JobRequestsCubit>(context).getJobRequests();
    BlocProvider.of<UserCubit>(context).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobRequestsCubit, JobRequestsState>(
      builder: (_, state) {
        if (state is JobRequestsLoaded) {
          return _scaffoldBody(context, state);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Scaffold _scaffoldBody(BuildContext context, JobRequestsLoaded jobRequests) {
    List<JobRequestEntity> availableJobRequests = jobRequests.jobRequests
        .where(
          (jobRequest) =>
              jobRequest.serviceClass == widget.partner.serviceClass &&
              jobRequest.jobRequestStatus == "Pending",
        )
        .toList();
    final primaryColor =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? kDarkPrimaryColor
            : kPrimaryColor;

    return Scaffold(
      key: widget._scaffoldKey,
      drawer: Drawer(
          width: getProportionateScreenWidth(260),
          child: SideMenu(
            currentPartner: widget.partner,
          )),
      // body: OfflineHome(scaffoldKey: _scaffoldKey, primaryColor: primaryColor),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(32)),
        child: Stack(
          children: [
            Positioned(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(114)),
                    Center(
                      child: Text(
                        "JOB REQUESTS",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: primaryColor),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    BlocBuilder<UserCubit, UserState>(
                      builder: (_, state) {
                        if (state is UserLoaded) {
                          return _jobRequestListView(
                              availableJobRequests, state);
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 58,
              child: HamburgerMenuButton(
                scaffoldKey: widget._scaffoldKey,
                primaryColor: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _jobRequestListView(
      List<JobRequestEntity> availableJobRequests, UserLoaded users) {
    final primaryColor =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? kDarkPrimaryColor
            : kPrimaryColor;
    return Column(
      children: List.generate(availableJobRequests.length, (index) {
        UserEntity user = users.users.firstWhere(
          (user) => user.uid == availableJobRequests[index].customerId,
        );
        return Padding(
          padding: EdgeInsets.only(bottom: getProportionateScreenHeight(48)),
          child: JobRequestCard(
            primaryColor: primaryColor,
            pfpURL: user.pfpURL,
            name: user.name,
            date: availableJobRequests[index].scheduledDate,
            time: availableJobRequests[index].scheduledTime,
            eta: 10,
            service: availableJobRequests[index].serviceClass,
            price: availableJobRequests[index].price,
            address: availableJobRequests[index].address,
            city: availableJobRequests[index].city,
          ),
        );
      }),
    );
  }
}
