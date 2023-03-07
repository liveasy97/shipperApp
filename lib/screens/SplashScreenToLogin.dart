import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:shipper_app/screens/loginScreen1.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/controller/transporterIdController.dart';
import 'package:shipper_app/functions/trasnporterApis/runTransporterApiPost.dart';


class SplashScreenToLoginScreen extends StatefulWidget {
  const SplashScreenToLoginScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreenToLoginScreen> createState() =>
      _SplashScreenToLoginScreenState();
}

class _SplashScreenToLoginScreenState
    extends State<SplashScreenToLoginScreen> {
  TransporterIdController transporterIdController = Get.put(TransporterIdController(), permanent: true);
  String? transporterId;


  @override
  void initState() {
    super.initState();
    getData();
    Timer(Duration(seconds: 3), () => Get.off(() => LoginScreen1()));
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
      print("transporterId is null");
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
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [shadowGrey, white]
            )
        ),
        padding: EdgeInsets.only(right: space_2, top: space_35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/images/liveasyTruck.png"),
            ),
            SizedBox(height: space_2),
            Container(
                child: Column(
                  children: [
                    Image(
                      image: const AssetImage("assets/images/logoSplashScreen.png"),
                      height: space_12,
                    ),
                    SizedBox(
                      height: space_3,
                    )
                  ],
                )
            )
          ],
        )
    ));
  }
}
