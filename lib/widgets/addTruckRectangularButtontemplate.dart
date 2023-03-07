import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:provider/provider.dart';
import 'package:shipper_app/providerClass/providerData.dart';

// ignore: must_be_immutable
class AddTruckRectangularButtonTemplate extends StatelessWidget {
  final String text;
  final String value;
  bool selected = false;

  AddTruckRectangularButtonTemplate({required this.value, required this.text});

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Container(
      child: OutlinedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(2),
            backgroundColor: providerData.truckTypeValue == value
                ? MaterialStateProperty.all(darkBlueColor)
                : MaterialStateProperty.all(whiteBackgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ))),
        child: Text(
          '$text',
          style: TextStyle(
              fontWeight: normalWeight,
              fontSize:
                  text == 'High-Cube Container' || text == 'Standard Container'
                      ? size_6
                      : size_7,
              color: providerData.truckTypeValue == value ? white : black),
        ),
        onPressed: () {
          providerData.updateTruckTypeValue(value);
          providerData.resetOnNewType();
          providerData.updateResetActive(true);
        },
      ),
    );
  }
}
