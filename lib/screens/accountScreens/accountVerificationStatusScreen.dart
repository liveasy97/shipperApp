import 'package:flutter/material.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/constants/colors.dart';
import '/controller/transporterIdController.dart';
import '/widgets/accountWidgets/accountDetailVerificationPending.dart';
import '/widgets/accountWidgets/accountDetailVerified.dart';
import '/widgets/accountWidgets/waitForReviewCard.dart';
import '/widgets/buttons/helpButton.dart';
import '/widgets/buyGpsLongWidget.dart';
import '/widgets/headingTextWidget.dart';
import 'package:get/get.dart';

class AccountVerificationStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransporterIdController transporterIdController =
        Get.put(TransporterIdController());
    return Scaffold(
      backgroundColor: statusBarColor,
      body: SafeArea(
        child: Container(
          color: backgroundColor,
          padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: space_2,
                      ),
                      HeadingTextWidget('my_account'.tr
                          // AppLocalizations.of(context)!.my_account
                          ),
                    ],
                  ),
                  HelpButtonWidget(),
                ],
              ),
              SizedBox(
                height: space_3,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: space_4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(space_1 + 3),
                  color: darkBlueColor,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: space_3),
                      child: CircleAvatar(
                        radius: radius_11,
                        backgroundColor: white,
                        child: Container(
                          height: space_8,
                          width: space_8,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/icons/defaultAccountIcon.png"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    transporterIdController.accountVerificationInProgress.value
                        ? AccountDetailVerificationPending(
                            mobileNum: transporterIdController.mobileNum.value,
                          )
                        : AccountDetailVerified(
                            mobileNum: transporterIdController.mobileNum.value,
                            name: transporterIdController.name.value,
                            companyName:
                                transporterIdController.companyName.value,
                            address: transporterIdController
                                .transporterLocation.value,
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: space_3,
              ),
              transporterIdController.accountVerificationInProgress.value
                  ? WaitForReviewCard()
                  : Container(),
              transporterIdController.accountVerificationInProgress.value
                  ? SizedBox(
                      height: space_3,
                    )
                  : Container(),
              BuyGpsLongWidget()
            ],
          ),
        ),
      ),
    );
  }
}
