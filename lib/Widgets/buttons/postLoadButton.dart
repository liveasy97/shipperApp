import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import 'package:get/get.dart';
import '/controller/transporterIdController.dart';
import '/widgets/alertDialog/verifyAccountNotifyAlertDialog.dart';
import 'package:provider/provider.dart';
import '/providerClass/providerData.dart';
import '/constants/spaces.dart';
import '/screens/PostLoadScreens/postloadnavigation.dart';
import '/screens/PostLoadScreens/PostLoadScreenLoacationDetails.dart';

// ignore: must_be_immutable
class PostButtonLoad extends StatelessWidget {
  TransporterIdController transporterIdController =
      Get.put(TransporterIdController());

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
