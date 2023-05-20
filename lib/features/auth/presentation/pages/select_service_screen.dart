// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servisgo_partner/components/default_button.dart';
import 'package:servisgo_partner/constants.dart';
import 'package:servisgo_partner/features/auth/presentation/bloc/signin_cubit/signin_cubit.dart';
import 'package:servisgo_partner/features/auth/presentation/widgets/form_header.dart';
import 'package:servisgo_partner/features/home/presentation/pages/home_screen.dart';

import '../../../../size_config.dart';

class SelectServiceScreen extends StatefulWidget {
  const SelectServiceScreen({super.key});

  @override
  State<SelectServiceScreen> createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  bool iscleaningSelected = false;
  bool isgardeningSelected = false;
  bool isplumbingSelected = false;
  bool iselectricalSelected = false;
  bool ishandymanSelected = false;
  bool ispaintingSelected = false;
  bool isimprovementSelected = false;
  String selectedClass = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(32)),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(90)),
            const FormHeader(
              title: "Choose Your Service",
              subtitle:
                  "Select the home service that you'd like to offer on our platform.",
            ),
            SizedBox(height: getProportionateScreenHeight(18)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      iscleaningSelected = true;
                      isgardeningSelected = false;
                      isplumbingSelected = false;
                      iselectricalSelected = false;
                      ishandymanSelected = false;
                      ispaintingSelected = false;
                      isimprovementSelected = false;
                      selectedClass = "Cleaning";
                    });
                  },
                  child: ServiceCard(
                    icon: "assets/icons/GardeningIcon.png",
                    title: "Cleaning\nServices",
                    isSelected: iscleaningSelected,
                    color: const Color(0XFFFA99D3),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      iscleaningSelected = false;
                      isgardeningSelected = true;
                      isplumbingSelected = false;
                      iselectricalSelected = false;
                      ishandymanSelected = false;
                      ispaintingSelected = false;
                      isimprovementSelected = false;
                      selectedClass = "Gardening";
                    });
                  },
                  child: ServiceCard(
                    icon: "assets/icons/GardeningIcon.png",
                    title: "Gardening\nServices",
                    isSelected: isgardeningSelected,
                    color: const Color(0XFFF78273),
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(18)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      iscleaningSelected = false;
                      isgardeningSelected = false;
                      isplumbingSelected = true;
                      iselectricalSelected = false;
                      ishandymanSelected = false;
                      ispaintingSelected = false;
                      isimprovementSelected = false;
                      selectedClass = "Plumbing";
                    });
                  },
                  child: ServiceCard(
                    icon: "assets/icons/PlumbingIcon.png",
                    title: "Plumbing\nServices",
                    isSelected: isplumbingSelected,
                    color: const Color(0XFFC45E84),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      iscleaningSelected = false;
                      isgardeningSelected = false;
                      isplumbingSelected = false;
                      iselectricalSelected = true;
                      ishandymanSelected = false;
                      ispaintingSelected = false;
                      isimprovementSelected = false;
                      selectedClass = "Electrical";
                    });
                  },
                  child: ServiceCard(
                    icon: "assets/icons/ElectricalIcon.png",
                    title: "Electrical\nServices",
                    isSelected: iselectricalSelected,
                    color: const Color(0XFFBDA5A6),
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(18)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      iscleaningSelected = false;
                      isgardeningSelected = false;
                      isplumbingSelected = false;
                      iselectricalSelected = false;
                      ishandymanSelected = true;
                      ispaintingSelected = false;
                      isimprovementSelected = false;
                      selectedClass = "Handyman";
                    });
                  },
                  child: ServiceCard(
                    icon: "assets/icons/HandymanIcon.png",
                    title: "Handyman\nServices",
                    isSelected: ishandymanSelected,
                    color: kCallToAction,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      iscleaningSelected = false;
                      isgardeningSelected = false;
                      isplumbingSelected = false;
                      iselectricalSelected = false;
                      ishandymanSelected = false;
                      ispaintingSelected = true;
                      isimprovementSelected = false;
                      selectedClass = "Painting";
                    });
                  },
                  child: ServiceCard(
                    icon: "assets/icons/PaintingIcon.png",
                    title: "Painting\nServices",
                    isSelected: ispaintingSelected,
                    color: const Color(0XFFA05338),
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(18)),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    iscleaningSelected = false;
                    isgardeningSelected = false;
                    isplumbingSelected = false;
                    iselectricalSelected = false;
                    ishandymanSelected = false;
                    ispaintingSelected = false;
                    isimprovementSelected = true;
                    selectedClass = "Improve";
                  });
                },
                child: ServiceCard(
                  icon: "assets/icons/HomeImprovementIcon.png",
                  title: "Home\nImprovement\nServices",
                  isSelected: isimprovementSelected,
                  color: const Color(0XFF5EECBE),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(22)),
            DefaultButton(
                text: "Confirm",
                press: () {
                  if (iscleaningSelected ||
                      isgardeningSelected ||
                      isplumbingSelected ||
                      iselectricalSelected ||
                      ishandymanSelected ||
                      ispaintingSelected ||
                      isimprovementSelected == true) {
                    BlocProvider.of<SigninCubit>(context)
                        .submitServiceClass(serviceClass: selectedClass);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()));
                  }
                })
          ],
        )),
      ),
    );
  }
}

class ServiceCard extends StatefulWidget {
  final String icon;
  final String title;
  final Color color;
  bool isSelected;
  ServiceCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.color,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  @override
  Widget build(BuildContext context) {
    final primaryColor =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? kDarkPrimaryColor
            : kPrimaryColor;
    final bgcolor = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? kDarkBgColor
        : kBgColor;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
        vertical: getProportionateScreenHeight(16),
      ),
      // height: getProportionateScreenHeight(112),
      width: getProportionateScreenWidth(156),
      decoration: BoxDecoration(
        border: Border.all(
          color: kOutlineVariant,
        ),
        borderRadius: BorderRadius.circular(16),
        color: widget.isSelected ? primaryColor : Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(6),
              vertical: getProportionateScreenHeight(6),
            ),
            child: Image.asset(
              widget.icon,
              height: getProportionateScreenHeight(20.54),
              width: getProportionateScreenWidth(20.54),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(8)),
          Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: widget.isSelected ? bgcolor : primaryColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
