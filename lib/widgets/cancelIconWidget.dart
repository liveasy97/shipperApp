import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/spaces.dart';

class CancelIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: space_4,
      width: space_4,
      child: Center(
        child: Icon(
          Icons.cancel_rounded,
          color: darkBlueColor,
        ),
      ),
    );
  }
}
