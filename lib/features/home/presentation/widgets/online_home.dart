import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import '../../domain/entities/job_request_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../bloc/job_requests_cubit/job_requests_cubit.dart';
import '../bloc/user_cubit/user_cubit.dart';
import '../../../tracker/presentation/pages/tracker_screen.dart';

import '../../../../components/hamburger_menu_button.dart';
import '../../../../components/side_menu.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../../auth/domain/entities/partner_entity.dart';
import '../../../tracker/presentation/bloc/accepted_service_cubit/accepted_service_cubit.dart';
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
  LocationData? currentLocation;
  @override
  void initState() {
    BlocProvider.of<JobRequestsCubit>(context).getJobRequests();
    BlocProvider.of<UserCubit>(context).getUsers();
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;

      if (mounted) {
        setState(() {});
      }
    });
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
      body: BlocConsumer<AcceptedServiceCubit, AcceptedServiceState>(
        listener: (context, state) {
          if (state is AcceptedServiceSuccess) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        TrackerScreen(currentPartner: widget.partner)));
          }
        },
        builder: (context, state) {
          if (state is AcceptedServiceLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(32)),
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
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenHeight(58),
                  child: HamburgerMenuButton(
                    scaffoldKey: widget._scaffoldKey,
                    primaryColor: primaryColor,
                  ),
                ),
              ],
            ),
          );
        },
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
            acceptRequest: () async {
              await BlocProvider.of<AcceptedServiceCubit>(context)
                  .acceptJobRequest(
                customerId: user.uid,
                serviceClass: availableJobRequests[index].serviceClass,
                serviceStatus: "Pending",
                scheduledDate: availableJobRequests[index].scheduledDate,
                scheduledTime: availableJobRequests[index].scheduledTime,
                servicePrice: availableJobRequests[index].price,
                serviceRating: 0.0,
                additionalDetails:
                    availableJobRequests[index].additionalDetails,
                customerAddress: availableJobRequests[index].address,
                latitudeCustomer: availableJobRequests[index].latitude,
                longitudeCustomer: availableJobRequests[index].longitude,
                latitudePartner: currentLocation!.latitude,
                longitudePartner: currentLocation!.longitude,
                jobRequestId: availableJobRequests[index].id,
              );
            },
          ),
        );
      }),
    );
  }
}
