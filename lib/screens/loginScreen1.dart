import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/widgets/welcomeToLiveasy.dart';
import '/widgets/buttons/signUpWithGoogleButton.dart';
import 'package:get/get.dart';
import '/screens/LoginScreen2.dart';
import '/constants/radius.dart';
import '/constants/fontSize.dart';
import '/constants/elevation.dart';
import '/constants/borderWidth.dart';
import '/providerClass/providerData.dart';
import '/screens/CompanyDetailsForm.dart';
import '/controller/transporterIdController.dart';
import '/functions/trasnporterApis/runTransporterApiPost.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen1 extends StatefulWidget {
  const LoginScreen1({Key? key}) : super(key: key);

  @override
  State<LoginScreen1> createState() => _LoginScreen1State();
}

class _LoginScreen1State extends State<LoginScreen1> {
  // TransporterIdController transporterIdController = Get.put(TransporterIdController(), permanent: true);
  // String? transporterId;

  @override
  void initState() {
    super.initState();
    // getData();
  }
  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: darkBlueColor,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                left: space_10,
                right: space_10,
                top: space_11,
                bottom: space_6,
              ),
              child: Image(
                image: AssetImage("assets/background/login_page_vector.png"),
              ),
            ),

            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius_3),
                    topRight: Radius.circular(radius_3),
                  ),
                  color: white
                ),
                child: Expanded(
                  child:Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: space_7,
                        ),
                        Center(
                          child: WelcomeToLiveasy(),
                        ),

                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left:space_9,
                                    right:space_9,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: space_5,
                                      ),

                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Email Address",
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.normal,
                                            fontSize: size_9,
                                            color: black,
                                          ),
                                        ),
                                      ),

                                      Container(
                                          margin: EdgeInsets.only(
                                              top: space_2
                                          ),
                                          padding: EdgeInsets.only(
                                            left: space_2,
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(width: borderWidth_20, color: backgroundGrey),
                                              borderRadius: BorderRadius.circular(radius_1)
                                          ),
                                          height: space_10,
                                          child: Scaffold(
                                              backgroundColor: Colors.transparent,
                                              body: SingleChildScrollView(
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    icon: Icon(Icons.email),
                                                    hintText: "Enter your email",
                                                    hintStyle: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: size_7,
                                                      // color: Colors.orange,
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
                                      ),

                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: space_8,
                                        margin: EdgeInsets.only(
                                          top: space_5,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(radius_5),
                                          color: darkBlueColor,
                                        ),
                                        child: ElevatedButton(
                                          child: Text(
                                            "Continue",
                                            style: TextStyle(
                                              fontSize: size_8,
                                            ),
                                          ),
                                          onPressed: (){
                                            Get.to(LoginScreen2());
                                          },
                                          style: ButtonStyle(
                                            elevation: MaterialStateProperty.resolveWith((states) => elevation_0),
                                            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black.withOpacity(0.01)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: space_8,
                                      ),

                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: space_4,
                                    right:  space_4,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                            // width: space_26,
                                            height: 1,
                                            color: greyBorderColor,
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
                                          color: black,
                                        ),
                                      ),

                                      SizedBox(
                                        width: space_3,
                                      ),
                                      Expanded(
                                          child: Container(
                                            // width: space_26,
                                            height: 1,
                                            color: greyBorderColor,
                                          )
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: space_8,
                                ),

                                Container(
                                  margin: EdgeInsets.only(
                                    left:space_9,
                                    right:space_9,
                                  ),

                                  child: SignUpWithGoogleButton(
                                      onPressed:() async {
                                        print("Button Pressed");
                                        await providerData.googleLogin();
                                        Get.to(CompanyDetailsForm());
                                      }
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ),
            )
          ],
        ),
      )
    );
  }
}
