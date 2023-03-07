import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/controller/transporterIdController.dart';
import 'package:shipper_app/screens/accountScreens/accountVerificationPage1.dart';
import 'package:shipper_app/screens/accountScreens/accountVerificationStatusScreen.dart';

// ignore: must_be_immutable
class AccountPageUtil extends StatelessWidget {
  TransporterIdController transporterIdController =
      Get.find<TransporterIdController>();

  @override
  Widget build(BuildContext context) {
    if (transporterIdController.transporterApproved.value ||
        transporterIdController.accountVerificationInProgress.value) {
      return AccountVerificationStatusScreen(); // When transporter is unverified and hasn't applied for verification
    } else {
      return AccountVerificationPage1();
    }
  }
}
