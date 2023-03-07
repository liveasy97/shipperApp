import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/controller/hudController.dart';
import 'package:shipper_app/controller/isOtpInvalidController.dart';
import 'package:shipper_app/controller/timerController.dart';
import 'package:shipper_app/functions/trasnporterApis/runTransporterApiPost.dart';
import 'package:shipper_app/screens/languageSelectionScreen.dart';
import 'package:shipper_app/screens/LoginScreens/loginScreen.dart';
import 'package:shipper_app/screens/navigationScreen.dart';
import 'package:shipper_app/widgets/loadingWidgets/bottomProgressBarIndicatorWidget.dart';

class AuthService {
  HudController hudController = Get.put(HudController());
  TimerController timerController = Get.put(TimerController());
  IsOtpInvalidController isOtpInvalidController =
      Get.put(IsOtpInvalidController());

  Future signOut() async {
    try {
      Get.to(() => LoginScreen());
      return FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void manualVerification({String? verificationId, String? smsCode}) async {
    print('verificationId in manual func: $smsCode');
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationId!, smsCode: smsCode!))
          .then((value) async {
        var value1 = value;
        if (value.user != null) {
          print('hud True due to try in manual verification');
          hudController.updateHud(true);
          timerController.cancelTimer();

          await runTransporterApiPost(
              mobileNum: value.user!.phoneNumber!.toString().substring(3, 13));

          Get.offAll(() => NavigationScreen());
        }
      });
    } on FirebaseAuthException catch (e) {
      // FocusScope.of(context).unfocus();
      print("---------------------->${e.code}");
      if (e.code == "session-expired") {
        hudController.updateHud(true);
        isOtpInvalidController.updateIsOtpInvalid(false);
        //await FirebaseAuth.instance.signInWithCredential(credential);

        timerController.cancelTimer();
        // await runTransporterApiPost(
        //     mobileNum: value1.user!.phoneNumber!.toString().substring(3, 13));
        // Get.offAll(() => NavigationScreen());
        print("---------------------------------->hi");
      } else {
        print('hud false due to catch in manual verification');

        hudController.updateHud(false);
        // Get.to(() => NewLoginScreen());
        isOtpInvalidController.updateIsOtpInvalid(true);
      }
      // Get.snackbar('Invalid Otp', 'Please Enter the correct OTP',
      //     colorText: white, backgroundColor: black_87);
    }
  }
}
