import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';

class LoadLabelValueRowTemplate extends StatelessWidget {
  final String? label;
  final String? value;

  LoadLabelValueRowTemplate({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: space_1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label',
            style: TextStyle(
                fontSize: size_6,
                fontWeight:
                    label == "Booking date" ? regularWeight : normalWeight),
          ),
          Container(
              width: MediaQuery.of(context).size.width / 2.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    ":  $value",
                    style: TextStyle(
                        fontSize: size_6,
                        fontWeight: label == "Booking date"
                            ? regularWeight
                            : mediumBoldWeight,
                        color: veryDarkGrey),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
