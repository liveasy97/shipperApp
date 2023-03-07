import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';

class HeadingTextWidget extends StatelessWidget {
  final String headingText;

  HeadingTextWidget(this.headingText);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        headingText,
        style: TextStyle(
            fontSize: size_10,
            fontWeight: mediumBoldWeight,
            color: liveasyBlackColor,
            letterSpacing: -0.408),
      ),
    );
  }
}
