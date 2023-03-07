import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/widgets/buttons/backButtonWidget.dart';
import 'package:provider/provider.dart';
import 'package:shipper_app/providerClass/providerData.dart';

// ignore: must_be_immutable
class Header extends StatefulWidget {
  final dynamic resetFunction;

  bool reset = true;
  bool backButton = true;
  final text;

  Header({this.resetFunction, required this.reset, required this.text , required this.backButton});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
                margin: EdgeInsets.only(right: space_2),
                child: widget.backButton ? BackButtonWidget() : SizedBox()),
            Text('${widget.text}',
                style: TextStyle(
                  fontSize: size_10,
                  fontWeight: mediumBoldWeight,
                )),
          ],
        ),
        widget.reset
            ? TextButton(
                onPressed:
                    providerData.resetActive ? widget.resetFunction : null,
                child: Text('reset'.tr,
                    style: TextStyle(
                      color: providerData.resetActive
                          ? liveasyGreen
                          : lightGrayishBlue,
                      fontSize: size_10,
                      fontWeight: regularWeight,
                    )))
            : SizedBox()
      ],
    );
  }
}
