import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/controller/CompletedDateController.dart';
import 'package:shipper_app/controller/navigationIndexController.dart';
import 'package:shipper_app/functions/bookingApiCallsOrders.dart';
import 'package:get/get.dart';
import 'package:shipper_app/providerClass/providerData.dart';
import 'package:shipper_app/screens/navigationScreen.dart';
import 'package:shipper_app/widgets/alertDialog/CompletedDialog.dart';
import 'package:shipper_app/widgets/alertDialog/loadingAlertDialog.dart';
import 'package:shipper_app/widgets/alertDialog/orderFailedAlertDialog.dart';
import 'package:provider/provider.dart';

import '../completedTextField.dart';

class OkButtonCompletedDate extends StatelessWidget {
  CompletedDateController completedDateController =
      Get.find<CompletedDateController>();
  NavigationIndexController navigationIndexController = Get.find<NavigationIndexController>();
  final String bookingId;
  OkButtonCompletedDate({Key? key, required this.bookingId}) : super(key: key);
  BookingApiCallsOrders bookingApiCallsOrders = BookingApiCallsOrders();

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    getPutData() async {
      String? putResponse = '';
      if (putResponse == "") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return LoadingAlertDialog();
          },
        );
      }
      putResponse = await bookingApiCallsOrders.updateBookingApi(
          completedDateController.completedDate.value, bookingId);
      if (putResponse == "completed") {
        print(putResponse);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return completedDialog(
              upperDialogText: "congratulations the order is completed",
              lowerDialogText: "wait for the shippers response",
            );
          },
        );
        Timer(
            Duration(seconds: 3),
            () => {
                  providerData.updateUpperNavigatorIndex(2),
                  Get.offAll(() => NavigationScreen()),
                  navigationIndexController.updateIndex(3),
                  providerData.updateBidButtonSendRequest(false),
                  completedController.text = ""
                });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return OrderFailedAlertDialog();
          },
        );
        // Get.snackbar("${postLoadErrorController.error.value}", "failed");
        // postLoadErrorController.resetPostLoadError();
        // print(postLoadErrorController.error.value.toString());
        // Timer(
        //     Duration(seconds: 1),
        //     () => {
        //           showDialog(
        //             context: context,
        //             builder: (BuildContext context) {
        //               return OrderFailedAlertDialog(
        //                   postLoadErrorController.error.value.toString());
        //             },
        //           )
        //         });
      }
    }

    return Container(
      width: space_16,
      height: space_6,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(space_10),
        child: ElevatedButton(
          style: ButtonStyle(backgroundColor: activeButtonColor),
          onPressed: () {
            getPutData();
          },
          child: Text(
            'OK',
            style: TextStyle(
              fontSize: size_6,
            ),
          ),
        ),
      ),
    );
  }
}
