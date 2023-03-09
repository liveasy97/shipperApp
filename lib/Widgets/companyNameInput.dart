import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/constants/fontSize.dart';
import '/constants/radius.dart';

class CompanyNameInputWidget extends StatefulWidget {
  const CompanyNameInputWidget({Key? key}) : super(key: key);

  @override
  State<CompanyNameInputWidget> createState() => _CompanyNameInputWidgetState();
}

class _CompanyNameInputWidgetState extends State<CompanyNameInputWidget> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: space_10,
      decoration: BoxDecoration(
        color: widgetBackGroundColor,
        borderRadius: BorderRadius.circular(radius_2),
      ),
      child: Container(
          margin: EdgeInsets.only(
            left: space_2,
            right: space_2,
          ),
          child: Expanded(
            child:TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter Company Name",
                hintStyle: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: size_7,
                  // color: darkCharcoal,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: size_7,
              ),
            ),
          )
      )
    );
  }
}
