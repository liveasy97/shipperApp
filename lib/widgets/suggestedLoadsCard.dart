import 'package:flutter/material.dart';
import 'package:shipper_app/constants/elevation.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/controller/transporterIdController.dart';
import 'package:shipper_app/models/loadDetailsScreenModel.dart';
import 'package:shipper_app/screens/loadDetailsScreen.dart';
import 'alertDialog/verifyAccountNotifyAlertDialog.dart';
import 'loadCardFooter.dart';
import 'loadCardHeader.dart';
import 'package:get/get.dart';

class SuggestedLoadsCard extends StatelessWidget {
  final LoadDetailsScreenModel loadDetailsScreenModel;
  final TransporterIdController tIdController =
      Get.find<TransporterIdController>();

  SuggestedLoadsCard({Key? key, required this.loadDetailsScreenModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: space_2),
      child: Column(children: [
        GestureDetector(
          onTap: () {
            if (tIdController.transporterApproved.value) {
              Get.to(() => LoadDetailsScreen(
                  loadDetailsScreenModel: loadDetailsScreenModel));
            } else {
              showDialog(
                  context: context,
                  builder: (context) => VerifyAccountNotifyAlertDialog());
            }
          },
          child: Card(
            elevation: elevation_2,
            child: Column(
              children: [
                LoadCardHeader(
                  loadDetails: loadDetailsScreenModel,
                ),
                LoadCardFooter(
                    loadPosterCompanyName:
                        loadDetailsScreenModel.loadPosterCompanyName,
                    loadPosterPhoneNo: loadDetailsScreenModel.phoneNo)
              ],
            ),
          ),
        )
      ]),
    );
  }
}
