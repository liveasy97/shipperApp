import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';

class CancelButtonBidDialogBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31,
      width: 80,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                      color: darkBlueColor))),
          backgroundColor:                MaterialStateProperty.all(Colors.white),
        ),
        onPressed: (){
          Navigator.pop(context);
        },
        child: Container(
          child: Text(
            'Cancel',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: mediumBoldWeight,
              color: black,
              fontSize: size_7,
            ),
          ),
        ),
      ),
    );
  }
}
