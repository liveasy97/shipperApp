import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(black),
      )),
    );
  }
}
