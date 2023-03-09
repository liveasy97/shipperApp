import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/constants/fontSize.dart';
import '/constants/radius.dart';


class AddressTextField extends StatefulWidget {
  const AddressTextField({Key? key}) : super(key: key);

  @override
  State<AddressTextField> createState() => _AddressTextFieldState();
}

class _AddressTextFieldState extends State<AddressTextField> {
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
                  hintText: "Address",
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
