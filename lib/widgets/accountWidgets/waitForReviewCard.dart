import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shipper_app/constants/elevation.dart';
import 'package:shipper_app/constants/radius.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';

class WaitForReviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation_1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius_2),
        child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.all(space_3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    height: space_5,
                    width: space_5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: darkBlueColor,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        color: white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: space_1),
                    height: space_10,
                    width: 1,
                    color: liveasyBlackColor,
                  ),
                  Container(
                    height: space_5,
                    width: space_5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: liveasyOrange,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.more_horiz,
                        color: white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: space_10,
                  ),
                  Container(
                    height: space_5,
                    width: space_5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: greyBorderColor,
                    ),
                    child: Center(
                      child: Container(
                        height: space_4,
                        width: space_4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: backgroundColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: space_2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "uploadDetails".tr,
                    style: TextStyle(
                        color: liveasyBlackColor,
                        fontSize: size_9,
                        fontWeight: mediumBoldWeight),
                  ),
                  Text(
                    "provideDetails".tr,
                    style: TextStyle(
                        color: liveasyBlackColor,
                        fontSize: size_6,
                        fontWeight: regularWeight),
                  ),
                  SizedBox(
                    height: space_8,
                  ),
                  Text(
                    "waitForReview".tr,
                    style: TextStyle(
                        color: liveasyBlackColor,
                        fontSize: size_9,
                        fontWeight: mediumBoldWeight),
                  ),
                  Text(
                    "takeTime".tr,
                    style: TextStyle(
                        color: liveasyBlackColor,
                        fontSize: size_6,
                        fontWeight: regularWeight),
                  ),
                  SizedBox(
                    height: space_8,
                  ),
                  Text(
                    "verified".tr,
                    style: TextStyle(
                        color: liveasyBlackColor,
                        fontSize: size_9,
                        fontWeight: mediumBoldWeight),
                  ),
                  Text(
                    "searchForLoads".tr,
                    style: TextStyle(
                        color: liveasyBlackColor,
                        fontSize: size_6,
                        fontWeight: regularWeight),
                  ),
                  SizedBox(
                    height: space_8,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
