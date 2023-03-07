import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/radius.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/controller/transporterIdController.dart';
import 'package:shipper_app/models/loadDetailsScreenModel.dart';
import 'package:shipper_app/widgets/alertDialog/bidButtonAlertDialog.dart';
import 'package:shipper_app/widgets/alertDialog/verifyAccountNotifyAlertDialog.dart';

// ignore: must_be_immutable
class BidButton extends StatefulWidget {
  LoadDetailsScreenModel loadDetails;

  BidButton({required this.loadDetails});

  @override
  _BidButtonState createState() => _BidButtonState();
}

class _BidButtonState extends State<BidButton> {
  TransporterIdController tIdController = Get.find<TransporterIdController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (tIdController.transporterApproved.value) {
          await showDialog(
              context: context,
              builder: (context) => BidButtonAlertDialog(
                    isNegotiating: false,
                    isPost: true,
                    loadId: widget.loadDetails.loadId,
                  ));
        } else {
          showDialog(
              context: context,
              builder: (context) => VerifyAccountNotifyAlertDialog());
        }
      },
      child: Container(
        height: space_6 + 1,
        width: space_16,
        decoration: BoxDecoration(
            color: darkBlueColor,
            borderRadius: BorderRadius.circular(radius_4)),
        child: Center(
          child: Text(
            'bids'.tr,
            // AppLocalizations.of(context)!.bids,
            style: TextStyle(
                color: white, fontWeight: normalWeight, fontSize: size_6 + 2),
          ),
        ),
      ),
    );
  }
}
