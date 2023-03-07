import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';

class OrderSectionTitleName extends StatelessWidget {
  String name;
  OrderSectionTitleName({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
          fontWeight: normalWeight,
          fontSize: size_7,
          color: liveasyBlackColor,
          fontFamily: "Montserrat"),
    );
  }
}
