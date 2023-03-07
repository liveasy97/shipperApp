import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/radius.dart';

class CancelLogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31,
      width: 80,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius_4),
                  side: BorderSide(color: darkBlueColor))),
          backgroundColor:
              MaterialStateProperty.all(Colors.white.withOpacity(0)),
        ),
        onPressed: () {
          Get.back();
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: darkShadow,
                offset: Offset(0, 4),
                blurRadius: 16,
                spreadRadius: 0,
              )
            ],
          ),
          child: Text(
            'cancel'.tr,
            // AppLocalizations.of(context)!.cancel,
            style: TextStyle(
              letterSpacing: 0.7,
              fontWeight: normalWeight,
              color: darkBlueColor,
              fontSize: size_7,
            ),
          ),
        ),
      ),
    );
  }
}
