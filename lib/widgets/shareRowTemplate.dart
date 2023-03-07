import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';

class shareNewRowTemplate extends StatelessWidget {
  final String? label;
  final String? value;
  double? width;

  shareNewRowTemplate({ required this.label , required this.value , this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: space_1),
      child: Row(
        children: [
          Container(
            child: Text(
              label!,
              style: TextStyle(
                color: white,
                fontSize: size_6,
                fontWeight: regularWeight
              ),
            ),
          ),
          Text(
            ' : ${value!}',
            style: TextStyle(
              color: white,
              fontWeight: mediumBoldWeight,
              fontSize: size_6,
            ),
          )
        ],
      ),
    );
  }
}
