import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/data/models/partner_model.dart';
import '../widgets/offline_home.dart';
import '../bloc/partner_cubit/partner_cubit.dart';
import '../widgets/online_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    BlocProvider.of<PartnerCubit>(context).getPartners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartnerCubit, PartnerState>(
      builder: (_, state) {
        if (state is PartnerLoaded) {
          return _homeBody(context, state);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _homeBody(BuildContext context, PartnerLoaded partners) {
    final partner = partners.partners.firstWhere(
      (partner) => partner.partnerId == FirebaseAuth.instance.currentUser!.uid,
      orElse: () => const PartnerModel(
        partnerId: "",
        partnerName: "",
        partnerEmail: "",
        partnerPhone: "",
        status: "",
        serviceClass: "",
        partnerPfpURL: "",
      ),
    );
    if (partner.status == "offline") {
      return OfflineHome(scaffoldKey: _scaffoldKey, partner: partner);
    } else {
      return OnlineHome(scaffoldKey: _scaffoldKey, partner: partner);
    }
  }
}
