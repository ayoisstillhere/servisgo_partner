import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'tracker_info_card.dart';

import '../../../../components/hamburger_menu_button.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../../auth/domain/entities/partner_entity.dart';
import '../../../home/presentation/bloc/user_cubit/user_cubit.dart';
import '../../domain/entities/accepted_service_entity.dart';
import 'arrived_dialog_content.dart';

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
  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints();
    BlocProvider.of<UserCubit>(context).getUsers();
    super.initState();
  }

  final Completer<GoogleMapController> _controller = Completer();

  LocationData? currentLocation;
  bool hasArrived =
      false; // Bool to check whether partner has arrived at customers location

  void getCurrentLocation() async {
    Location location = Location();

    print("getting location");
    await location.getLocation().then(
      (location) {
        setState(() {
          currentLocation = location;
        });
      },
    );
    print("got location");
    print(currentLocation);

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;

      if (mounted) {
        setState(() {});
      }

      try {
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
      } on Exception catch (_) {}

      // Check if the partner has arrived
      double distance = Geolocator.distanceBetween(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
        widget.customerLocation.latitude,
        widget.customerLocation.longitude,
      );
      if (distance <= 100) {
        // Assuming 100 meters is considered "arrived"
        if (mounted) {
          setState(() {
            hasArrived = true;
          });
        }
      }
    });
    // Set loading state to false once the location is retrieved
  }

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
      for (var point in result.points) {
        widget.polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }

      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        currentLocation == null
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    currentLocation!.latitude!,
                    currentLocation!.longitude!,
                  ),
                  zoom: 13.5,
                ),
                onMapCreated: (mapController) {
                  _controller.complete(mapController);
                },
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
                    markerId: const MarkerId("currentLocation"),
                    position: LatLng(
                      currentLocation!.latitude!,
                      currentLocation!.longitude!,
                    ),
                  ),
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
        hasArrived
            ? Center(
                child: AlertDialog(
                  content: ArrivedDialogContent(
                    acceptedSericeId: widget.acceptedService.id,
                  ),
                ),
              )
            : const Center(
                child: SizedBox(
                height: 0,
                width: 0,
              )),

        // const NoResultsBody(),
      ],
    );
  }
}
