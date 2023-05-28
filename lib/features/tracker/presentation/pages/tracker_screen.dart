import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servisgo_partner/features/tracker/data/models/accepted_service_model.dart';
import 'package:servisgo_partner/features/tracker/presentation/bloc/accepted_service_cubit/accepted_service_cubit.dart';

import '../../../auth/domain/entities/partner_entity.dart';

import '../../../../components/hamburger_menu_button.dart';
import '../../../../components/side_menu.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../widgets/no_results_body.dart';

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
    return BlocBuilder<AcceptedServiceCubit, AcceptedServiceState>(
      builder: (_, state) {
        if (state is AcceptedServiceLoaded) {
          return _scaffoldBody(scaffoldKey, state);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Scaffold _scaffoldBody(GlobalKey<ScaffoldState> scaffoldKey,
      AcceptedServiceLoaded acceptedServices) {
    final currentService = acceptedServices.acceptedRequests.firstWhere(
        (acceptedRequest) =>
            acceptedRequest.partnerId == widget.currentPartner.partnerId,
        orElse: () =>  const AcceptedServiceModel(
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
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        width: getProportionateScreenWidth(260),
        child: SideMenu(
          currentPartner: widget.currentPartner,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: getProportionateScreenHeight(58)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(32)),
            child: HamburgerMenuButton(
              scaffoldKey: scaffoldKey,
              primaryColor: primaryColor,
            ),
          ),
          const NoResultsBody(),
        ],
      ),
    );
  }
}
