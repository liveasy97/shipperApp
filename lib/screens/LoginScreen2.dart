import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/constants/spaces.dart';
import '/constants/colors.dart';
import '/widgets/buttons/signUpWithGoogleButton.dart';
import '/widgets/emailAddressTextField.dart';
import '/widgets/passwordTextField.dart';
import 'package:get/get.dart';
import '/screens/CompanyDetailsForm.dart';
import '/constants/fontSize.dart';
import '/constants/radius.dart';

import '/constants/elevation.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({Key? key}) : super(key: key);

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   systemOverlayStyle: SystemUiOverlayStyle(
      //     // Status bar color
      //     statusBarColor: Color(0xFF3B4C81),
      //     // Status bar brightness (optional)
      //     statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      //     statusBarBrightness: Brightness.light, // For iOS (dark icons)
      //   ),
      //   toolbarHeight: 0,
      // ),
      backgroundColor: darkBlueColor,
      body: SafeArea(
          child:Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image(
                      image: AssetImage("assets/background/login_page_wave.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: space_12, right: space_12, top: space_15),
                      child: Image(
                          image: AssetImage("assets/icons/liveasy.png")))
                ],
              ),
              Container(
                // height: MediaQuery.of(context).size,
                  margin: EdgeInsets.only(
                      left: space_6, right: space_6, bottom: space_2, top: space_8),
                  alignment: Alignment.topLeft,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Email : ",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Poppins",
                              fontSize: size_9,
                              color: white),
                        ),
                      ),

                      SizedBox(
                        height: space_1,
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        height: space_9,
                        // decoration:
                        child: EmailAddressTextField(),
                      ),

                      SizedBox(
                        height: space_2,
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password : ",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Poppins",
                              fontSize: size_9,
                              color: white),
                        ),
                      ),

                      Container(
                        height: space_9,
                        child: PasswordTextFieldWidget(),
                      ),

                      SizedBox(
                        height: space_10,
                      ),

                      Container(
                        height: space_8,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: widgetBackGroundColor,
                          borderRadius: BorderRadius.circular(radius_6),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.resolveWith((states) => elevation_0),
                            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black.withOpacity(0.01)),
                          ),
                          onPressed: (){
                            Get.to(CompanyDetailsForm());
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: size_9,
                                color: Color(0xFF002087),
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: space_8,
                      ),
                    ],
                  )
              ),

              Container(
                margin: EdgeInsets.only(
                  left: space_4,
                  right: space_4,
                ),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          // width: space_26,
                          height: 1,
                          color: widgetBackGroundColor,
                        )
                    ),
                    SizedBox(
                      width: space_3,
                    ),
                    Text(
                      "or",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: size_10,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.normal,
                        color: white,
                      ),
                    ),

                    SizedBox(
                      width: space_3,
                    ),
                    Expanded(
                        child: Container(
                          // width: space_26,
                          height: 1,
                          color: widgetBackGroundColor,
                        )
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(
                    left: space_6, right: space_6, bottom: space_2, top: space_8),
                decoration: BoxDecoration(
                  color: widgetBackGroundColor,
                  borderRadius: BorderRadius.circular(radius_3),
                ),
                child: SignUpWithGoogleButton(onPressed: (){
                  Get.to(CompanyDetailsForm());
                },),
              )
            ],
          ),
      ),
    );
  }
}
