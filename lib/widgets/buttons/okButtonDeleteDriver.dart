import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/radius.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/functions/driverApiCalls.dart';
import 'package:shipper_app/models/driverModel.dart';
import 'package:shipper_app/screens/myDriversScreen.dart';

class OkButtonDeleteDriver extends StatelessWidget {
  DriverModel driverData;

  OkButtonDeleteDriver({required this.driverData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        disableActionOnDriver(driverId: driverData.driverId);
        Timer(Duration(milliseconds: 1), () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyDrivers()));
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: space_3),
        height: space_7,
        width: space_16,
        decoration: BoxDecoration(
            color: darkBlueColor,
            borderRadius: BorderRadius.circular(radius_6),
            boxShadow: [
              BoxShadow(color: darkGreyColor, offset: Offset(2.0, 2.0))
            ]),
        child: Center(
          child: Text(
            "Ok",
            style: TextStyle(
                color: white, fontWeight: mediumBoldWeight, fontSize: size_8),
          ),
        ),
      ),
    );
  }
}
