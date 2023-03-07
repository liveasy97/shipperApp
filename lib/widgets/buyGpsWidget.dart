import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/screens/buyGpsScreen.dart';

class BuyGpsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => BuyGpsScreen()),
      child: Container(
        height: space_20,
        width: space_36,
        padding: EdgeInsets.fromLTRB(space_2, space_2, 0, 0),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/buyGpsBackgroundImage.png"),
              fit: BoxFit.fill),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  'buy_gps'.tr,
                  // "Buy GPS",
                  style: TextStyle(
                      fontSize: size_10,
                      fontWeight: mediumBoldWeight,
                      color: white),
                ),
                Text(
                  'gpsTitle'.tr,
                  // "Liveasy GPS system\nallows you to track\nyour vehicles from\nthe app",
                  style: TextStyle(fontSize: size_5, color: white),
                ),
              ],
            ),
            Container(
              height: space_11,
              width: space_9,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/buyGpsIcon.png"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
