import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';

// ignore: must_be_immutable
class docUploadbtn2 extends StatelessWidget {
  String assetImage;
  var onPressed;
  var imageFile;

  docUploadbtn2({
    required this.onPressed,
    required this.imageFile,
    required this.assetImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 130,
      alignment: Alignment.center,

      child: GestureDetector(
        child: imageFile == null
            ? Center(
                child: Image(image: AssetImage(assetImage)),
              )
            : Stack(
                children: [
                  Center(
                      child: imageFile != null
                          ? Image(image: Image.file(imageFile).image)
                          : Container()),
                  Center(
                    child: imageFile == null
                        ? Center(
                            child: Container(),
                          )
                        : Center(
                            child: Text(
                              "Tap to Open",
                              style: TextStyle(
                                  fontSize: size_6, color: liveasyGreen),
                            ),
                          ),
                  ),
                ],
              ),
        // )
        //         ),
        onTap: onPressed,
      ),
      // ],
    );
  }
}
