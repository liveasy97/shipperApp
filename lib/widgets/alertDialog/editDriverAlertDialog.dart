import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/radius.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/functions/driverApiCalls.dart';
import 'package:shipper_app/models/driverModel.dart';
import 'package:shipper_app/models/responseModel.dart';
import 'package:shipper_app/providerClass/providerData.dart';
import 'package:shipper_app/screens/myDriversScreen.dart';
import 'package:shipper_app/widgets/buttons/cancelButtonForAddNewDriver.dart';
import 'package:shipper_app/widgets/buttons/editButton.dart';
import 'package:provider/provider.dart';
import 'CompletedDialog.dart';

class EditDriverAlertDialog extends StatefulWidget {
  late DriverModel driverEditData;

  EditDriverAlertDialog({required this.driverEditData});

  @override
  _EditDriverAlertDialogState createState() => _EditDriverAlertDialogState();
}

class _EditDriverAlertDialogState extends State<EditDriverAlertDialog> {
  DriverApiCalls driverApiCalls = DriverApiCalls();
  TextEditingController driverEditNameController = TextEditingController();

  @override
  void initState() {
    driverEditNameController.text = widget.driverEditData.driverName!;
    super.initState();
  }

  @override
  void dispose() {
    driverEditNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return AlertDialog(
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "driverName".tr,
          style: TextStyle(
              fontSize: size_9,
              fontWeight: normalWeight,
              color: liveasyBlackColor),
        ),
        SizedBox(
          height: space_2,
        ),
        Container(
          height: space_7 + 2,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius_4 + 2),
              border: Border.all(color: darkGreyColor)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: space_2),
            child: TextField(
              controller: driverEditNameController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  hintText: "Type here",
                  //labelText: widget.driverEditData.driverName,
                  hintStyle: TextStyle(
                      color: textLightColor,
                      fontSize: size_8,
                      fontWeight: regularWeight),
                  border: InputBorder.none),
            ),
          ),
        )
      ]),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            EditButton(onTap: () async {
              EasyLoading.instance
                ..indicatorType = EasyLoadingIndicatorType.ring
                ..indicatorSize = 45.0
                ..radius = 10.0
                ..maskColor = darkBlueColor
                ..userInteractions = false
                ..backgroundColor = darkBlueColor
                ..dismissOnTap = false;
              EasyLoading.show(
                status: "Loading...",
              );
              ResponseModel? Editresponse = await driverApiCalls.editDriver(
                  driverId: widget.driverEditData.driverId,
                  driverName: driverEditNameController.text.toString());

              if (Editresponse != null) {
                EasyLoading.dismiss();
                if (Editresponse.statusCode == 200) {
                  // driver edited successfully
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return completedDialog(
                        upperDialogText: "Driver Edited successfully",
                        lowerDialogText: "",
                      );
                    },
                  );
                  Timer(Duration(milliseconds: 1000),
                      () => {Get.to(MyDrivers())});

                  var totalResponses =
                      await driverApiCalls.getDriversByTransporterId();

                  providerData.updateDriverList(totalResponses);
                } else {
                  //response is null so error with api
                  return Get.defaultDialog(
                    content: Container(
                      child: Column(
                        children: [
                          Text("Oops!! Error!"),
                          Text(Editresponse.message.toString())
                        ],
                      ),
                    ),
                  );
                }
              }
            }),
            CancelButtonForAddNewDriver()
          ],
        )
      ],
      contentPadding:
          EdgeInsets.symmetric(horizontal: space_3, vertical: space_4),
      actionsPadding: EdgeInsets.only(top: space_8, bottom: space_3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius_2 - 2)),
      ),
      insetPadding: EdgeInsets.only(left: space_4, right: space_4),
    );
  }
}
