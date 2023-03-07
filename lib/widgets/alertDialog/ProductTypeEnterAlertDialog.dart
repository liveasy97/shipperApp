import 'package:flutter/material.dart';

import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';

import 'package:shipper_app/widgets/buttons/CancelButtonProductType.dart';
import 'package:shipper_app/widgets/buttons/OkButtonProductType.dart';

import '../ProductTypeTextField.dart';

class ProductTypeEnterAlertDialog extends StatefulWidget {
  String heading;
  String category;

  ProductTypeEnterAlertDialog({Key? key, required this.heading,required this.category})
      : super(key: key);

  @override
  _ProductTypeEnterAlertDialogState createState() =>
      _ProductTypeEnterAlertDialogState();
}

class _ProductTypeEnterAlertDialogState
    extends State<ProductTypeEnterAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.heading,
                      style: TextStyle(
                          fontWeight: normalWeight,
                          fontSize: size_9,
                          color: liveasyBlackColor),
                    ),
                    SizedBox(
                      height: space_3,
                    ),ProductTypeTextField(hint: "Enter Product "+widget.category, category: widget.category,)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OkButtonProductType(category: widget.category),
                  SizedBox(width: space_4),
                  CancelButtonProductType(),
                ],
              )
            ],
          )),
    );
  }
}
