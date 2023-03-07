import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';

class HeadingTextWidgetBlue extends StatelessWidget {
  final String headingText;

  HeadingTextWidgetBlue(this.headingText);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        headingText,
        style: TextStyle(
            fontSize: size_9,
            fontWeight: FontWeight.bold,
            color: darkBlueColor,
            letterSpacing: -0.408),
      ),
    );
  }
}
