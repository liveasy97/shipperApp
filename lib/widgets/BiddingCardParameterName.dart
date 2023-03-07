import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';

// ignore: must_be_immutable
class BiddingCardParameterName extends StatelessWidget {
  String paraName;
  BiddingCardParameterName({Key? key, required this.paraName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      paraName,
      style: TextStyle(
          fontWeight: mediumBoldWeight,
          fontSize: size_7,
          color: veryDarkGrey,
          fontFamily: "Montserrat"),
    );
  }
}
