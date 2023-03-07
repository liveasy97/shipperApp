import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/functions/getImageFromCamera.dart';
import 'package:shipper_app/providerClass/providerData.dart';
import 'package:shipper_app/screens/accountScreens/accountVerificationPage2.dart';
import 'package:shipper_app/widgets/accountVerification/elevatedButtonWidget.dart';
import 'package:shipper_app/widgets/headingTextWidget.dart';
import 'package:shipper_app/widgets/buttons/helpButton.dart';
import 'package:shipper_app/widgets/accountVerification/idInputWidget.dart';
import 'package:shipper_app/widgets/accountVerification/profilePhoto.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../widgets/accountVerification/image_display.dart';

class AccountVerificationPage1 extends StatefulWidget {
  @override
  _AccountVerificationPage1State createState() =>
      _AccountVerificationPage1State();
}

class _AccountVerificationPage1State extends State<AccountVerificationPage1> {
  @override
  void initState() {
    super.initState();
    Permission.camera.request();
  }

  @override
  Widget build(BuildContext context) {
    var providerData = Provider.of<ProviderData>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: space_2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadingTextWidget("my_account".tr),
                    HelpButtonWidget(),
                  ],
                ),
              ),
              SizedBox(
                height: space_3,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    providerData.profilePhotoFile!=null?
                    Get.to(ImageDisplay(providerData: providerData.profilePhotoFile,imageName: "profilePhoto64"))
                        :showPicker(providerData.updateProfilePhoto,
                        providerData.updateProfilePhotoStr, context);
                  },
                  child: ProfilePhotoWidget(
                    providerData: providerData,
                  ),
                ),
              ),
              SizedBox(
                height: space_4,
              ),
              IdInputWidget(
                providerData: providerData,
              ),
              ElevatedButtonWidget(
                  condition: providerData.profilePhoto64 != null &&
                      providerData.addressProofFrontPhoto64 != null &&
                      providerData.addressProofBackPhoto64 != null &&
                      providerData.panFrontPhoto64 != null,
                  text: "next".tr,
                  onPressedConditionTrue: () {
                    Get.to(() => AccountVerificationPage2());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
