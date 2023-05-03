import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../widgets/history_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> jobData = [
      {
        "customerName": "Ayodele Fagbami",
        "status": "Pending",
        "price": "2000",
        "address": "14C Ola Crescent, High Gardens Estate, Ikota",
        "date": "Aug 26",
      },
      {
        "customerName": "James John",
        "status": "Complete",
        "price": "3000",
        "address": "No 9, Bello Street, Surulere",
        "date": "Sep 16",
      },
      {
        "customerName": "Glory Akinbobola",
        "status": "Pending",
        "price": "4000",
        "address": "14C Ola Crescent, High Gardens Estate, Ikota",
        "date": "Jul 14",
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order History",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(32)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: getProportionateScreenWidth(48),
                  height: getProportionateScreenHeight(48),
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(
                    child: Text(
                      "All",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: kBgColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
                Container(
                  width: getProportionateScreenWidth(126.39),
                  height: getProportionateScreenHeight(48),
                  decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(
                    child: Text(
                      "Completed",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: kBlacks,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
                Container(
                  width: getProportionateScreenWidth(126.39),
                  height: getProportionateScreenHeight(48),
                  decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(
                    child: Text(
                      "Pending",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: kBlacks,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(32)),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => HistoryCard(
                  customerName: jobData[index]["customerName"],
                  status: jobData[index]["status"],
                  price: jobData[index]["price"],
                  address: jobData[index]["address"],
                  date: jobData[index]["date"],
                ),
                itemCount: jobData.length,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
