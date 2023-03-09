import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/functions/driverApiCalls.dart';
import '/functions/truckApis/truckApiCalls.dart';
import '/models/biddingModel.dart';
import '/models/driverModel.dart';
import '/models/truckModel.dart';
import '/widgets/alertDialog/bookLoadAlertDialogBox.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ConfirmOrderButton extends StatefulWidget {
  BiddingModel biddingModel;
  final String? postLoadId;
  bool? shipperApproval;
  bool? transporterApproval;

  ConfirmOrderButton({
    this.transporterApproval,
    this.shipperApproval,
    required this.biddingModel,
    required this.postLoadId,
  });

  @override
  _ConfirmOrderButtonState createState() => _ConfirmOrderButtonState();
}

class _ConfirmOrderButtonState extends State<ConfirmOrderButton> {
  List<TruckModel> truckDetailsList = [];

  List<DriverModel> driverDetailsList = [];

  TruckApiCalls truckApiCalls = TruckApiCalls();
  DriverApiCalls driverApiCalls = DriverApiCalls();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    truckDetailsList = await truckApiCalls.getTruckData();
    driverDetailsList = await driverApiCalls.getDriversByTransporterId();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: space_3),
      height: 31,
      child: TextButton(
        child: Text(
          "confirm".tr,
          style: TextStyle(
              letterSpacing: 1,
              fontSize: size_6 + 1,
              color: white,
              fontWeight: mediumBoldWeight),
        ),
        onPressed: (widget.shipperApproval == false &&
                widget.transporterApproval == true)
            ? null
            : () async {
                if (widget.shipperApproval == true &&
                    widget.transporterApproval == false) {
                  // putBidForAccept(bidId);
                }
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return BookLoadAlertDialogBox(
                          truckModelList: truckDetailsList,
                          driverModelList: driverDetailsList,
                          postLoadId: widget.postLoadId,
                          biddingModel: widget.biddingModel,
                          directBooking: false);
                    });
              },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius_6),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(
              (widget.shipperApproval == false &&
                      widget.transporterApproval == true)
                  ? unselectedGrey
                  : liveasyGreen),
        ),
      ),
    );
  }
}
