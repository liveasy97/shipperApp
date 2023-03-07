import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';

class LiveasyTitleTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: space_8,
      child: Center(
        child: Text(
          "liveasy".tr,
          style: TextStyle(
              fontSize: size_15,
              color: darkBlueColor,
              fontWeight: normalWeight),
        ),
      ),
    );
  }
}
