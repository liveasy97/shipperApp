import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/controller/hudController.dart';
import 'package:shipper_app/controller/navigationIndexController.dart';
import 'package:shipper_app/controller/transporterIdController.dart';
import 'package:shipper_app/functions/documentApi/postAccountVerificationDocuments.dart';
import 'package:shipper_app/functions/trasnporterApis/updateTransporterApi.dart';
import 'package:shipper_app/providerClass/providerData.dart';
import 'package:shipper_app/screens/navigationScreen.dart';
import 'package:shipper_app/widgets/accountVerification/companyIdInputWidget.dart';
import 'package:shipper_app/widgets/accountVerification/elevatedButtonWidget.dart';
import 'package:shipper_app/widgets/alertDialog/conflictDialog.dart';
import 'package:shipper_app/widgets/buttons/backButtonWidget.dart';
import 'package:shipper_app/widgets/buttons/helpButton.dart';
import 'package:shipper_app/widgets/headingTextWidget.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AccountVerificationPage2 extends StatelessWidget {
  TransporterIdController transporterIdController =
      Get.find<TransporterIdController>();
  HudController hudController = Get.put(HudController());

  @override
  Widget build(BuildContext context) {
    NavigationIndexController navigationIndexController =
        Get.find<NavigationIndexController>();
    var providerData = Provider.of<ProviderData>(context);
    return Scaffold(
      backgroundColor: statusBarColor,
      body: SafeArea(
          child: Obx(
        () => ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
          ),
          inAsyncCall: hudController.showHud.value,
          child: Container(
            padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          BackButtonWidget(),
                          SizedBox(
                            width: space_3,
                          ),
                          HeadingTextWidget("my_account".tr),
                        ],
                      ),
                      HelpButtonWidget(),
                    ],
                  ),
                  SizedBox(
                    height: space_4,
                  ),
                  Row(
                    children: [
                      Text(
                        "forPostingLoad".tr,
                        style: TextStyle(
                            fontSize: size_9,
                            color: liveasyBlackColor,
                            fontWeight: mediumBoldWeight),
                      ),
                      Text(
                        "optional".tr,
                        style: TextStyle(
                            fontSize: size_9, color: liveasyBlackColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: space_5,
                  ),
                  CompanyIdInputWidget(
                    providerData: providerData,
                  ),
                  ElevatedButtonWidget(
                      condition: true,
                      text: "verify".tr,
                      onPressedConditionTrue: () async {
                        hudController.updateHud(true);
                        await postAccountVerificationDocuments(
                                profilePhoto: providerData.profilePhoto64,
                                addressProofFront:
                                    providerData.addressProofFrontPhoto64,
                                addressProofBack:
                                    providerData.addressProofBackPhoto64,
                                panFront: providerData.panFrontPhoto64,
                                companyIdProof:
                                    providerData.companyIdProofPhoto64)
                            .then((uploadstatus) async {
                          if (uploadstatus == "Success") {
                            final status = await updateTransporterApi(
                                accountVerificationInProgress: true,
                                transporterId: transporterIdController
                                    .transporterId.value);
                            if (status == "Success") {
                              hudController.updateHud(false);
                              Get.offAll(NavigationScreen());
                              // providerData.updateIndex(4);
                            } else {
                              hudController.updateHud(false);
                              showDialog(
                                  context: context,
                                  builder: (context) => ConflictDialog(
                                      dialog: "Failed Please try again"));
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => ConflictDialog(
                                    dialog: "Failed Please try again"));
                          }
                        });
                      }),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
