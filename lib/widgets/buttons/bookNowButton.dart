import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/radius.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/controller/transporterIdController.dart';
import 'package:shipper_app/functions/driverApiCalls.dart';
import 'package:shipper_app/functions/truckApis/truckApiCalls.dart';
import 'package:shipper_app/models/driverModel.dart';
import 'package:shipper_app/models/loadDetailsScreenModel.dart';
import 'package:shipper_app/models/truckModel.dart';
import 'package:shipper_app/screens/myLoadPages/bookLoadScreen.dart';
import 'package:shipper_app/widgets/alertDialog/bookLoadAlertDialogBox.dart';
import 'package:shipper_app/widgets/alertDialog/verifyAccountNotifyAlertDialog.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BookNowButton extends StatefulWidget {
  LoadDetailsScreenModel loadDetailsScreenModel;

  BookNowButton({required this.loadDetailsScreenModel});

  @override
  _BookNowButtonState createState() => _BookNowButtonState();
}

class _BookNowButtonState extends State<BookNowButton> {
  // List truckDetailsList = [];
  // List driverDetailsList = [];

  List<TruckModel> truckDetailsList = [];
  List<DriverModel> driverDetailsList = [];

  TruckApiCalls truckApiCalls = TruckApiCalls();
  DriverApiCalls driverApiCalls = DriverApiCalls();
  TransporterIdController transporterIdController =
      Get.find<TransporterIdController>();

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
    return GestureDetector(
        onTap: () async {
          await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) =>
                transporterIdController.transporterApproved.value
                    ? BookLoadScreen(
                        truckModelList: truckDetailsList,
                        driverModelList: driverDetailsList,
                        loadDetailsScreenModel: widget.loadDetailsScreenModel,
                        directBooking: true,
                      )
                    : VerifyAccountNotifyAlertDialog(),
          );
        },
        child: Container(
          height: space_8,
          width: (space_16 * 2) + 3,
          decoration: BoxDecoration(
              color: darkBlueColor,
              borderRadius: BorderRadius.circular(radius_6)),
          child: Center(
            child: Text(
              'bookNow'.tr,
              // AppLocalizations.of(context)!.bookNow,
              style: TextStyle(
                  fontSize: size_8, fontWeight: mediumBoldWeight, color: white),
            ),
          ),
        ));
  }
}
