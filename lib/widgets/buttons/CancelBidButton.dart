import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/controller/navigationIndexController.dart';
import 'package:shipper_app/functions/bidApiCalls.dart';
import 'package:shipper_app/models/biddingModel.dart';
import 'package:shipper_app/providerClass/providerData.dart';
import 'package:shipper_app/screens/navigationScreen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CancelBidButton extends StatelessWidget {
  BiddingModel biddingModel;

  final bool? active;

  CancelBidButton({required this.biddingModel, required this.active});

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    NavigationIndexController navigationIndexController =
        Get.find<NavigationIndexController>();
    return Container(
      height: 31,
      width: 80,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(
              active! ? bidBackground : inactiveBidding),
        ),
        onPressed: active!
            ? () {
                declineBidFromTransporterSideSide(
                    bidId: biddingModel.bidId!,
                    approvalVariable: biddingModel.transporterApproval == true
                        ? 'transporterApproval'
                        : 'shipperApproval');
                Get.offAll(NavigationScreen());
                navigationIndexController.updateIndex(3);
              }
            : null,
        child: Container(
          child: Text(
            "cancel".tr,
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
