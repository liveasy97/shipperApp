import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';

class LoadEndPointTemplate extends StatelessWidget {

  final String? endPointType;
   String? text;

  LoadEndPointTemplate({required this.text, required this.endPointType});

  @override
  Widget build(BuildContext context) {
    if(text!.length > 20){
      text = text!.substring(0 , 19) + '..';
    }
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: space_1),
          child: Image(
              height: 10,
              width: 10,
              image: endPointType == 'loading'
                  ? AssetImage('assets/icons/greenFilledCircleIcon.png')
                  : AssetImage('assets/icons/redSemiFilledCircleIcon.png')),
        ),
        Text(
          '$text'.tr,
          style: TextStyle(
            color: liveasyBlackColor,
            fontWeight: mediumBoldWeight,
            fontSize: size_9,
          ),
        ),
      ],
    );
  }
}
