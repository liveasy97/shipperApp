import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/screens/myDriversScreen.dart';
import 'package:shipper_app/widgets/alertDialog/addDriverAlertDialog.dart';

class AddDriverButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: space_33,
      height: space_8,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(truckGreen),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AddDriverAlertDialog(notifyParent: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyDrivers()));
              },));
        },
        child: Text(
          'addDriver'.tr,
          // 'Add Driver',
          style: TextStyle(
            fontWeight: mediumBoldWeight,
            fontSize: size_9,
            color: white,
          ),
        ),
      ),
    );
  }
}
