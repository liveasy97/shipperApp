import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/constants/radius.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/borderWidth.dart';
import 'package:shipper_app/constants/elevation.dart';

class SignUpWithGoogleButton extends StatelessWidget {
  var onPressed;


  SignUpWithGoogleButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: space_8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius_3),
          border: Border.all(
            color: black,
            width: borderWidth_10,
          ),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith((states) => elevation_0),
            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black.withOpacity(0.01)),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: space_4,
                  width: space_4,
                  child: Image(
                    image: AssetImage("assets/icons/google_icon.png"),
                  )
              ),
              SizedBox(
                width: space_3,
              ),
              Text(
                "Sign up with Google",
                style: TextStyle(
                    fontSize: size_9,
                    fontFamily: "Monsterrat",
                    fontWeight: FontWeight.bold,
                    color: black
                ),
              ),
            ],
          ),
        )
    );
  }
}

