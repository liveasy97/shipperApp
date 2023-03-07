import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/functions/PostLoadApi.dart';

class ViewBidButton extends StatelessWidget {
  String? loadFrom;
  int? load;
  String? loadTo;
  ViewBidButton({Key? key, this.load, this.loadTo, this.loadFrom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: space_2, right: space_3),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 127,
          height: 31,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size_10),
            color: bidBackground,
          ),
          child: Center(
            child: Text(
              "View Biddings",
              style: TextStyle(
                  fontWeight: mediumBoldWeight,
                  fontSize: size_6,
                  color: white,
                  fontFamily: "Montserrat"),
            ),
          ),
        ),
      ),
    );
  }
}
