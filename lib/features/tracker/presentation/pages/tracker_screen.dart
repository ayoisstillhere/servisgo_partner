import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:servisgo_partner/features/home/presentation/bloc/user_cubit/user_cubit.dart';

import '../../../../components/hamburger_menu_button.dart';
import '../../../../components/side_menu.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../../auth/domain/entities/partner_entity.dart';
import '../../data/models/accepted_service_model.dart';
import '../../domain/entities/accepted_service_entity.dart';
import '../bloc/accepted_service_cubit/accepted_service_cubit.dart';
import '../widgets/tracker_info_card.dart';

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
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    BlocProvider.of<AcceptedServiceCubit>(context).getAcceptedRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        width: getProportionateScreenWidth(260),
        child: SideMenu(
          currentPartner: widget.currentPartner,
        ),
      ),
      body: BlocBuilder<AcceptedServiceCubit, AcceptedServiceState>(
        builder: (_, state) {
          if (state is AcceptedServiceLoaded) {
            final currentService = state.acceptedRequests.firstWhere(
                (acceptedRequest) =>
                    acceptedRequest.partnerId ==
                        widget.currentPartner.partnerId &&
                    acceptedRequest.serviceStatus == "Pending",
                orElse: () => const AcceptedServiceModel(
                      id: "",
                      customerId: "",
                      partnerId: "",
                      serviceClass: "",
                      serviceStatus: "",
                      scheduledDate: "",
                      scheduledTime: "",
                      servicePrice: "",
                      serviceRating: 0,
                      additionalDetails: "",
                      customerAddress: "",
                      latitudeCustomer: 0,
                      longitudeCustomer: 0,
                      latitudePartner: 0,
                      longitudePartner: 0,
                    ));
            final primaryColor =
                MediaQuery.of(context).platformBrightness == Brightness.dark
                    ? kDarkPrimaryColor
                    : kPrimaryColor;
            final partnerLocation = LatLng(
              currentService.latitudePartner!,
              currentService.longitudePartner!,
            );
            final customerLocation = LatLng(
              currentService.latitudeCustomer!,
              currentService.longitudePartner!,
            );
            return TrackerMap(
              partnerLocation: partnerLocation,
              polylineCoordinates: polylineCoordinates,
              customerLocation: customerLocation,
              scaffoldKey: scaffoldKey,
              primaryColor: primaryColor,
              customerId: currentService.customerId,
              acceptedService: currentService,
              partner: widget.currentPartner,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class TrackerMap extends StatefulWidget {
  const TrackerMap({
    Key? key,
    required this.partnerLocation,
    required this.polylineCoordinates,
    required this.customerLocation,
    required this.scaffoldKey,
    required this.primaryColor,
    required this.customerId,
    required this.acceptedService,
    required this.partner,
  }) : super(key: key);

  final LatLng partnerLocation;
  final List<LatLng> polylineCoordinates;
  final LatLng customerLocation;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Color primaryColor;
  final String customerId;
  final AcceptedServiceEntity acceptedService;
  final PartnerEntity partner;

  @override
  State<TrackerMap> createState() => _TrackerMapState();
}

class _TrackerMapState extends State<TrackerMap> {
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(
        widget.partnerLocation.latitude,
        widget.partnerLocation.longitude,
      ),
      PointLatLng(
        widget.customerLocation.latitude,
        widget.customerLocation.longitude,
      ),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => widget.polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    getPolyPoints();
    BlocProvider.of<UserCubit>(context).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: widget.partnerLocation,
            zoom: 13.5,
          ),
          polylines: {
            Polyline(
              polylineId: const PolylineId("route"),
              points: widget.polylineCoordinates,
              color: kPrimaryColor,
              width: 6,
            ),
          },
          markers: {
            Marker(
              markerId: const MarkerId("Partner"),
              position: widget.partnerLocation,
            ),
            Marker(
              markerId: const MarkerId("Customer"),
              position: widget.customerLocation,
            ),
          },
        ),
        Positioned(
          top: getProportionateScreenHeight(58),
          left: getProportionateScreenWidth(32),
          child: HamburgerMenuButton(
            scaffoldKey: widget.scaffoldKey,
            primaryColor: widget.primaryColor,
          ),
        ),
        Positioned(
          bottom: getProportionateScreenHeight(66),
          left: getProportionateScreenWidth(32),
          right: getProportionateScreenWidth(32),
          child: BlocBuilder<UserCubit, UserState>(
            builder: (_, state) {
              if (state is UserLoaded) {
                final customer = state.users
                    .firstWhere((user) => user.uid == widget.customerId);
                return TrackerInfoCard(
                  customer: customer,
                  acceptedService: widget.acceptedService,
                  partner: widget.partner,
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        // const NoResultsBody(),
      ],
    );
  }
}
