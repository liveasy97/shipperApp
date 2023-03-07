import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';

class AvailableLoadsTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
        height: space_5-3,
        child: Center(
        child: Text(
        "Available Loads",
        style: TextStyle(
        fontSize:  size_11,
              color: black,
              fontWeight: mediumBoldWeight),
        ),
      ),
    );
  }
}