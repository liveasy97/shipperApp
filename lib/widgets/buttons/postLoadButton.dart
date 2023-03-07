import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:get/get.dart';
import 'package:shipper_app/controller/transporterIdController.dart';
import 'package:shipper_app/widgets/alertDialog/verifyAccountNotifyAlertDialog.dart';
import 'package:provider/provider.dart';
import 'package:shipper_app/providerClass/providerData.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/screens/PostLoadScreens/postloadnavigation.dart';
import 'package:shipper_app/screens/PostLoadScreens/PostLoadScreenLoacationDetails.dart';

// ignore: must_be_immutable
class PostButtonLoad extends StatelessWidget {
  TransporterIdController transporterIdController =
      Get.find<TransporterIdController>();

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Container(
      height: space_8,
      width: space_33,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(liveasyGreen),
        ),
        onPressed: () {
          providerData.resetPostLoadScreenOne();
          providerData.resetPostLoadFilters();
          providerData.resetPostLoadScreenMultiple();
          providerData.updateEditLoad(false, "");
          transporterIdController.companyApproved.value?
               Get.to(() => postloadnav())
              : showDialog(
                  context: context,
                  builder: (context) => VerifyAccountNotifyAlertDialog());
        },
        child: Container(
          child: Text(
            'postLoad'.tr,
            // AppLocalizations.of(context)!.postLoad,
            style: TextStyle(
              fontWeight: mediumBoldWeight,
              color: white,
              fontSize: size_8,
            ),
          ),
        ),
      ),
    );
  }
}
