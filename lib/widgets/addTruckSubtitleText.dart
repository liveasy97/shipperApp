import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';

// ignore: must_be_immutable
class AddTruckSubtitleText extends StatelessWidget {
  final String text;

  AddTruckSubtitleText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: TextStyle(
        color: liveasyGreen,
        fontWeight: mediumBoldWeight,
        fontSize: size_8,
      ),
    );
  }
}
