import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/elevation.dart';
import 'package:shipper_app/constants/radius.dart';
import 'package:shipper_app/widgets/companyNameInput.dart';
import 'package:shipper_app/widgets/PhoneNumberTextField.dart';
import 'package:shipper_app/widgets/GstNumberTextField.dart';
import 'package:shipper_app/widgets/AddressTextField.dart';
import 'package:shipper_app/screens/navigationScreen.dart';
import 'package:get/get.dart';
import 'package:shipper_app/controller/hudController.dart';
import 'package:shipper_app/controller/timerController.dart';
import 'package:shipper_app/controller/isOtpInvalidController.dart';
import 'package:shipper_app/functions/trasnporterApis/runTransporterApiPost.dart';
import 'package:shipper_app/constants/borderWidth.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/widgets/linePainter.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shipper_app/controller/transporterIdController.dart';


class CompanyDetailsForm extends StatefulWidget {
  const CompanyDetailsForm({Key? key}) : super(key: key);

  @override
  State<CompanyDetailsForm> createState() => _CompanyDetailsFormState();
}

class _CompanyDetailsFormState extends State<CompanyDetailsForm> {
  // TextStyle textStyleForHeader =

  TimerController timerController = Get.put(TimerController());
  HudController hudController = Get.put(HudController());
  IsOtpInvalidController isOtpInvalidController =
  Get.put(IsOtpInvalidController());

  TransporterIdController transporterIdController = Get.put(TransporterIdController());
  String? transporterId;


  // String _verificationCode = '';

  TextEditingController controller = TextEditingController();


  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

            Expanded(
              child: SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.only(
                        top: space_2,
                        left: space_6,
                        right: space_6,
                        bottom: space_6
                    ),
                    child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "Company Details",
                                style:TextStyle(
                                  color: white,
                                  fontSize: size_10,
                                  fontFamily: "Poppins",
                                )
                            ),
                          ),

                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                              top: space_5,
                            ),
                            child: Text(
                              "Company Name",
                              style: TextStyle(
                                color: white,
                                fontSize: size_8,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: space_2,
                            ),
                            child: CompanyNameInputWidget(),
                          ),

                          // Container(
                          //   alignment: Alignment.centerLeft,
                          //   margin: EdgeInsets.only(
                          //     top: space_4,
                          //   ),
                          //   child: Text(
                          //     "Phone Number",
                          //     style: TextStyle(
                          //       color: white,
                          //       fontSize: size_8,
                          //       fontFamily: "Poppins",
                          //     ),
                          //   ),
                          // ),

                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                              top: space_5,
                            ),
                            child: Text(
                              "Phone Number",
                              style: TextStyle(
                                color: white,
                                fontSize: size_8,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: space_2,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: widgetBackGroundColor,
                                  borderRadius: BorderRadius.circular(radius_2),
                                  border: Border.all(width: borderWidth_20, color: backgroundGrey)),
                              child: Row(children: [
                                Padding(
                                  padding: EdgeInsets.only(left: space_1),
                                  child: Container(
                                    width: space_3,
                                    height: space_3,
                                    child: Image(
                                      image: AssetImage("assets/images/indianFlag.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: space_1, top: space_2),
                                  child: Container(
                                    width: space_5,
                                    height: space_5,
                                    child: Text(
                                      "+91",
                                      style: TextStyle(
                                          fontWeight: regularWeight,
                                          fontSize: size_6,
                                          fontFamily: "Roboto"),
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 2),
                                    height: space_6,
                                    width: space_1,
                                    child: CustomPaint(
                                      foregroundPainter: LinePainter(),
                                    )),
                                SizedBox(
                                  width: 200,
                                  child: TextFormField(
                                    onChanged: (controller) {

                                    },
                                    controller: controller,
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(10),
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    ],
                                    maxLength: 10,
                                    validator: (value) =>
                                    value!.length == 10 ? null : 'EnterPhoneNumber'.tr,
                                    // 'Enter a valid Phone Number',
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      filled: true,
                                      fillColor: widgetBackGroundColor,
                                      hintText: 'EnterPhoneNumber'.tr,
                                      // 'Enter Phone Number',
                                      hintStyle: TextStyle(color: darkCharcoal, fontSize: size_7),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),

                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                              top: space_5,
                            ),
                            child: Text(
                              "GST Number",
                              style: TextStyle(
                                color: white,
                                fontSize: size_8,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: space_2,
                            ),
                            child: GstNumberTextField(),
                          ),

                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                              top: space_5,
                            ),
                            child: Text(
                              "Address",
                              style: TextStyle(
                                color: white,
                                fontSize: size_8,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: space_2,
                            ),
                            child: AddressTextField(),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                              top: space_7,
                            ),
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
                              onPressed: onPressed,
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
                          )
                        ]
                    )
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  void _verifyPhoneNumber() async {

    String phoneNumber = controller.text;

    print("length: *****************************************${phoneNumber.length}");
    await runTransporterApiPost(mobileNum: phoneNumber);

    getData();
    Get.offAll(() => NavigationScreen());
  }



  getData() async   {
    // print();
    // Fluttertoast.showToast(
    //   msg: "transporterIdController ${transporterIdController}",
    //   // toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: Colors.black,
    //   textColor: Colors.white,
    // );

    bool? transporterApproved;
    bool? companyApproved;
    String? mobileNum;
    bool? accountVerificationInProgress;
    String? transporterLocation;
    String? name;
    String? companyName;

    if (transporterId != null){
      // setState(() {
      //   _nextScreen=true;
      // });
    }
    else {
      setState(() {
        transporterId = tidstorage.read("transporterId");
        transporterApproved = tidstorage.read("transporterApproved");
        companyApproved = tidstorage.read("companyApproved");
        mobileNum = tidstorage.read("mobileNum");
        accountVerificationInProgress = tidstorage.read("accountVerificationInProgress");
        transporterLocation = tidstorage.read("transporterLocation");
        name = tidstorage.read("name");
        companyName = tidstorage.read("companyName");
      });

      if (transporterId == null) {
        print("Transporter ID is null");
      } else {
        print("It is in else");
        transporterIdController.updateTransporterId(transporterId!);
        transporterIdController.updateTransporterApproved(transporterApproved!);
        transporterIdController.updateCompanyApproved(companyApproved!);
        transporterIdController.updateMobileNum(mobileNum!);
        transporterIdController
            .updateAccountVerificationInProgress(accountVerificationInProgress!);
        transporterIdController.updateTransporterLocation(transporterLocation!);
        transporterIdController.updateName(name!);
        transporterIdController.updateCompanyName(companyName!);
        print("transporterID is $transporterId");
        // setState(() {
        //   _nextScreen=true;
        // });
      }
      //setState(() {
      //_nextScreen=true;
      //});
    }
  }



  void onPressed() {
    // print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@controller.text.length = ${controller.text.length}");
    //
    // print("'${controller.text}'");

    if(controller.text.length == 10){
      _verifyPhoneNumber();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter valid phone number"),
      ));
    }
  }
}
