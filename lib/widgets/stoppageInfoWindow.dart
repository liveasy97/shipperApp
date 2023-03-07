import 'package:flutter/material.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';

Widget getInfoWindow(var duration, var stoppageTime, var stopAddress){
  return  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: Opacity(
            opacity: 0.5 ,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (duration!="Ongoing")?
                    Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "${duration}",
                        style: TextStyle(
                            color: white,
                            fontSize: size_6,
                            fontStyle: FontStyle.normal,
                            fontWeight: regularWeight
                        ),
                      ),
                    ) :
                    SizedBox(
                      height: 8.0,
                    ),

                    Text(
                      "${stoppageTime}",
                      style: TextStyle(
                          color: white,
                          fontSize: size_6,
                          fontStyle: FontStyle.normal,
                          fontWeight: regularWeight
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "  ${stopAddress}",
                      style: TextStyle(
                          color: white,
                          fontSize: size_6,
                          fontStyle: FontStyle.normal,
                          fontWeight: regularWeight
                      ),
                    ),
                  ],
                ),
              ),
              width: double.infinity,
              height: double.infinity,
            )),
      ),
    ],
  );
}