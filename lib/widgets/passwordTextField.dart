import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shipper_app/providerClass/providerData.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/constants/radius.dart';
import 'package:shipper_app/constants/fontSize.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  const PasswordTextFieldWidget({Key? key}) : super(key: key);

  @override
  State<PasswordTextFieldWidget> createState() => _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProviderData provider = Provider.of<ProviderData>(context);

    return Container(
      height: space_8,
      decoration: BoxDecoration(
        color: widgetBackGroundColor,
        borderRadius: BorderRadius.circular(radius_2),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(
                left: space_2,
                right: space_2,
              ),
              child: Expanded(
                child:TextFormField(
                  obscureText: true,
                  controller: controller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Password",
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
          ),
        ),
      ),
    );
  }
}
