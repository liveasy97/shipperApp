import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/screens/PostLoadScreens/PostLoadScreenLoadDetails.dart';
import 'package:get/get.dart';

class CancelButtonProductType extends StatelessWidget {
  const CancelButtonProductType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: space_16,
      height: space_6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(space_10),
          border: Border.all(width: 1, color: bidBackground)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(space_10),
        child: ElevatedButton(
          style: ButtonStyle(backgroundColor: greyishWhiteColorM),
          onPressed: () {
            Get.back();
            controllerOthers.text = "";
          },
          child: Text(
            'cancel'.tr,
            style: TextStyle(
              fontSize: size_6,
              color: loadingPointTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
