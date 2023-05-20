// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:servisgo_partner/features/auth/domain/entities/partner_entity.dart';
import 'package:servisgo_partner/features/home/presentation/bloc/partner_cubit/partner_cubit.dart';
import 'package:servisgo_partner/features/home/presentation/pages/home_screen.dart';
import 'package:servisgo_partner/features/profile/presentation/bloc/partner_pfp_cubit/partner_pfp_cubit.dart';

import '../../../../components/default_button.dart';
import '../../../../components/hamburger_menu_button.dart';
import '../../../../components/side_menu.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../widgets/profile_item_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
    required this.currentPartner,
  }) : super(key: key);
  final PartnerEntity currentPartner;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    _nameController =
        TextEditingController(text: widget.currentPartner.partnerName);
    _phoneController =
        TextEditingController(text: widget.currentPartner.partnerPhone);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? kDarkPrimaryColor
            : kPrimaryColor;
    final List ratings = widget.currentPartner.ratings;
    double sum = 0;
    for (int rating in ratings) {
      sum += rating;
    }
    final double avgRating = sum / ratings.length;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        width: getProportionateScreenWidth(260),
        child: SideMenu(
          currentPartner: widget.currentPartner,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(32),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getProportionateScreenHeight(58)),
              HamburgerMenuButton(
                scaffoldKey: _scaffoldKey,
                primaryColor: primaryColor,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                      height: getProportionateScreenHeight(172),
                      width: getProportionateScreenWidth(172),
                      decoration: BoxDecoration(
                        color: kBgColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xFF9CA3AF).withOpacity(0.12),
                              blurRadius: 85.5,
                              offset: const Offset(8.55, 26.65)),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          widget.currentPartner.partnerPfpURL,
                        ),
                      ),
                    ),
                    Positioned(
                      top: getProportionateScreenHeight(112),
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                title: const Text(
                                  "Edit Profile Picture",
                                  textAlign: TextAlign.center,
                                ),
                                children: [
                                  SimpleDialogOption(
                                    padding: EdgeInsets.all(
                                        getProportionateScreenWidth(20)),
                                    onPressed: () async {
                                      pickImage(ImageSource.camera, context);
                                    },
                                    child: const Text(
                                      "Take a Photo",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SimpleDialogOption(
                                    padding: EdgeInsets.all(
                                        getProportionateScreenWidth(20)),
                                    onPressed: () {
                                      pickImage(ImageSource.gallery, context);
                                    },
                                    child: const Text(
                                      "Choose From Gallery",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SimpleDialogOption(
                                    padding: EdgeInsets.all(
                                        getProportionateScreenWidth(20)),
                                    child: const Text(
                                      "Cancel",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          height: getProportionateScreenHeight(48),
                          width: getProportionateScreenWidth(48),
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(8)),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: kCallToAction,
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/Camera.svg",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0XFFFA99D3),
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(6),
                          vertical: getProportionateScreenHeight(6),
                        ),
                        child: Image.asset(
                          "assets/icons/CleaningIcon.png",
                          height: getProportionateScreenHeight(20.54),
                          width: getProportionateScreenWidth(20.54),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      Text(
                        widget.currentPartner.serviceClass,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "$avgRating",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.dark
                                      ? kBgColor
                                      : kBlacks,
                            ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Row(
                        children: [
                          Text(
                            "Rating",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SvgPicture.asset("assets/icons/profileRatingStar.svg")
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        widget.currentPartner.completed.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.dark
                                      ? kBgColor
                                      : kBlacks,
                            ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Text(
                        "Completed",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(48)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: getProportionateScreenWidth(66),
                    child: Text(
                      "Name",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: kGreys),
                    ),
                  ),
                  SizedBox(width: getProportionateScreenWidth(60)),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(30),
                          child: TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              fillColor: Colors.transparent,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(16)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: getProportionateScreenWidth(66),
                    child: Text(
                      "Phone",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: kGreys),
                    ),
                  ),
                  SizedBox(width: getProportionateScreenWidth(60)),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(30),
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              fillColor: Colors.transparent,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(24)),
              ProfileItemTile(
                field: "Email",
                value: widget.currentPartner.partnerEmail,
              ),
              SizedBox(height: getProportionateScreenHeight(100)),
              DefaultButton(
                text: "Save Changes",
                press: () {
                  _updateName(context);
                  _updatePhone(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateName(BuildContext context) async {
    await BlocProvider.of<PartnerCubit>(context).updateName(
      _nameController.text.trim(),
    );
  }

  Future<void> _updatePhone(BuildContext context) async {
    await BlocProvider.of<PartnerCubit>(context).updatePhone(
      _phoneController.text.trim(),
    );
  }

  pickImage(ImageSource source, BuildContext context) async {
    final ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: source);
    Uint8List image = await file!.readAsBytes();

    String pfpUrl =
        await BlocProvider.of<PartnerPfpCubit>(context).uploadImage(image);

    await BlocProvider.of<PartnerPfpCubit>(context).updatePartnerPfpUrl(pfpUrl);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}
