import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/widgets/buttons/CancelLogoutButton.dart';
import 'package:shipper_app/widgets/buttons/LogoutOkButton.dart';

class LogoutDialogue extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      title: new Text(
        'logoutDialog'.tr,
        // "Are you sure? You want to logout" ,
          style: TextStyle(
      color: liveasyBlackColor,
          fontSize: size_9,
          fontFamily: 'montserrat',
          fontWeight: regularWeight)),
      actions: <Widget>[
        LogoutOkButton(),
        CancelLogoutButton(),
        SizedBox(
          height: space_3
        )
      ]
    );
  }
}