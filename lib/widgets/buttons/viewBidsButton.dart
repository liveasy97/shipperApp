import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/screens/myLoadPages/biddingScreen.dart';

// ignore: must_be_immutable
class ViewBidsButton extends StatelessWidget {

  final String? loadId;
  final String? loadingPointCity;
  final String? unloadingPointCity;

  ViewBidsButton({required this.loadId , required this.loadingPointCity , required this.unloadingPointCity});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23),
              )),
          backgroundColor: MaterialStateProperty.all<Color>(darkBlueColor),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 0 , horizontal: space_5),
          child:  Text(
            'viewBids'.tr,
            // 'View Bids',
            style: TextStyle(
              letterSpacing: 0.7,
              fontWeight: mediumBoldWeight,
              color: white,
              fontSize: size_7,
            ),
          ),
        ),
        onPressed: () {
          print(loadId);
          Get.to(() => BiddingScreens(loadId: loadId,loadingPointCity: loadingPointCity, unloadingPointCity: unloadingPointCity,));
        },
      ),
    );
  }
}
