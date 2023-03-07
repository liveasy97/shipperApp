import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/controller/navigationIndexController.dart';
import 'package:shipper_app/functions/bidApiCalls.dart';
import 'package:shipper_app/providerClass/providerData.dart';
import 'package:shipper_app/screens/myLoadPages/biddingScreen.dart';
import 'package:shipper_app/screens/navigationScreen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DeclineButton extends StatelessWidget {
  String? bidId;
  String? loadId;
  bool? isBiddingDetails;
  bool? shipperApproved;
  bool? transporterApproved;
  bool? fromTransporterSide;

  DeclineButton(
      {required this.bidId,
      this.loadId,
      required this.isBiddingDetails,
      this.shipperApproved,
      this.transporterApproved,
      this.fromTransporterSide});

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    NavigationIndexController navigationIndexController =
        Get.find<NavigationIndexController>();
    return Container(
      height: isBiddingDetails! ? null : 31,
      width: isBiddingDetails! ? null : 80,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(
              !(transporterApproved == false && shipperApproved == false)
                  ? declineButtonRed
                  : inactiveBidding),
        ),
        onPressed: !(transporterApproved == false && shipperApproved == false)
            ? () {
                declineBidFromShipperSide(bidId!);
                if (fromTransporterSide!) {
                  // providerData.updateIndex(3);
                  providerData.updateLowerAndUpperNavigationIndex(3, 0);
                  navigationIndexController.updateIndex(3);
                  Get.offAll(NavigationScreen());
                } else {
                  Get.offAll(NavigationScreen());
                  navigationIndexController.updateIndex(2);
                  Get.to(() => BiddingScreens(
                      loadId: loadId,
                      loadingPointCity: providerData.bidLoadingPoint,
                      unloadingPointCity: providerData.bidUnloadingPoint));
                }

                // putBidForAccept(bidId);
              }
            : null,
        child: Container(
          margin: isBiddingDetails!
              ? EdgeInsets.symmetric(vertical: space_1, horizontal: space_3)
              : null,
          child: Text(
            'Decline',
            style: TextStyle(
              letterSpacing: 0.7,
              fontWeight: mediumBoldWeight,
              color: white,
              fontSize: size_7,
            ),
          ),
        ),
      ),
    );
  }
}
