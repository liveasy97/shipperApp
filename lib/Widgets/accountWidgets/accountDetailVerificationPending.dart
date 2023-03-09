import 'package:flutter/material.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import 'package:flutter/cupertino.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';

class AccountDetailVerificationPending extends StatelessWidget {
  final String mobileNum;

  AccountDetailVerificationPending({required this.mobileNum});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              height: space_3,
              width: space_2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/icons/callIcon.png",
                  ),
                ),
              ),
            ),
            SizedBox(
              width: space_1 - 2,
            ),
            Text(
              mobileNum,
              style: TextStyle(
                  fontWeight: normalWeight,
                  color: lightGrayishBlue,
                  fontSize: size_6),
            ),
          ],
        ),
        SizedBox(
          height: space_2,
        ),
        Container(
          height: space_3,
          width: space_10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_1),
            color: liveasyOrange,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                height: space_1 + 3,
                width: space_1 + 3,
                image: AssetImage("assets/icons/pendingIcon.png"),
              ),
              Text(
                "Pending",
                style: TextStyle(
                    color: greyishWhiteColor,
                    fontWeight: normalWeight,
                    fontSize: size_3 + 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
