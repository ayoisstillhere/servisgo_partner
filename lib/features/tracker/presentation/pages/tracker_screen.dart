import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/accepted_service_model.dart';
import '../bloc/accepted_service_cubit/accepted_service_cubit.dart';

import '../../../auth/domain/entities/partner_entity.dart';

import '../../../../components/hamburger_menu_button.dart';
import '../../../../components/side_menu.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';

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
            return Stack(
              children: [
                Positioned(
                  top: 58,
                  left: 32,
                  child: HamburgerMenuButton(
                    scaffoldKey: scaffoldKey,
                    primaryColor: primaryColor,
                  ),
                ),
                // const NoResultsBody(),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
