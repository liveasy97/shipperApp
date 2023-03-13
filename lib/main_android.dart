import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shipper_app/Web/screens/home_web.dart';
import '/screens/SplashScreenToLogin.dart';
import '/screens/SplashScreenToHomePage.dart';
import '/screens/errorScreen.dart';
import '/screens/noInternetScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/language/localization_service.dart';
import '/providerClass/providerData.dart';
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'main.dart';

class Android extends StatefulWidget {
  const Android({super.key});

  @override
  _AndroidState createState() => _AndroidState();
}

class _AndroidState extends State<Android> {
  var _connectionStatus = "Unknown";
  late Connectivity connectivity;
  late StreamSubscription<ConnectivityResult> subscription;
  bool isDisconnected = false;
  var firebase = Firebase.initializeApp();

  GetStorage tidstorage = GetStorage('TransporterIDStorage');
  String? transporterId;

  @override
  initState() {
    super.initState();
    setState(() {});
    transporterId = tidstorage.read("transporterId");
    checkConnection();
    connectivityChecker();
  }

  void checkConnection() {
    configOneSignel();
    connectivity = Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          _connectionStatus = result.toString();
          print(_connectionStatus);
          if (result == ConnectivityResult.mobile ||
              result == ConnectivityResult.wifi) {
            if (isDisconnected) {
              isDisconnected = false;
              connectivityChecker();
              Get.back();
            }
          } else {
            if (!isDisconnected) {
              isDisconnected = true;
              Get.defaultDialog(
                  barrierDismissible: false,
                  content: NoInternetConnection.noInternetDialogue(),
                  onWillPop: () async => false,
                  title: "\nNo Internet",
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ));
            } else
              connectivityChecker();
          }
        });
  }

  Future<void> connectivityChecker() async {
    // print("Checking internet...");
    try {
      await InternetAddress.lookup('google.com');
    } on SocketException catch (_) {
      isDisconnected = true;
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.defaultDialog(
            barrierDismissible: false,
            content: NoInternetConnection.noInternetDialogue(),
            onWillPop: () async => false,
            title: "\nNo Internet",
            titleStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ));
      });
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void configOneSignel() {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    String oneSignalAppId = dotenv.get('oneSignalAppId').toString();
    OneSignal.shared.setAppId(oneSignalAppId);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return OverlaySupport(
        child: ChangeNotifierProvider<ProviderData>(
          create: (context) => ProviderData(),
          child: FutureBuilder(
              future: firebase,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done){

                  if(FirebaseAuth.instance.currentUser == null){
                    //User is Logged out or doesn't Exist

                    if (transporterId != null){
                      print("Current transporter is not null");
                      return GetMaterialApp(
                          debugShowCheckedModeBanner: false,
                          theme: ThemeData(fontFamily: "Montserrat"),
                          translations: LocalizationService(),
                          locale: LocalizationService().getCurrentLocale(),
                          fallbackLocale: Locale('en', 'US'),
                          home:  SplashScreenToHomePage()
                      );
                    } else {
                      print("Current transporter is null");
                      return GetMaterialApp(
                          debugShowCheckedModeBanner: false,
                          theme: ThemeData(fontFamily: "Montserrat"),
                          translations: LocalizationService(),
                          locale: LocalizationService().getCurrentLocale(),
                          fallbackLocale: Locale('en', 'US'),
                          home:  SplashScreenToLoginScreen()
                      );
                    }

                  } else{
                    if (transporterId != null){
                      print("Current transporter is not null");
                      return GetMaterialApp(
                          debugShowCheckedModeBanner: false,
                          theme: ThemeData(fontFamily: "Montserrat"),
                          translations: LocalizationService(),
                          locale: LocalizationService().getCurrentLocale(),
                          fallbackLocale: Locale('en', 'US'),
                          home:  SplashScreenToHomePage()
                      );
                    } else {

                      print("Current transporter is null");
                      return GetMaterialApp(
                          debugShowCheckedModeBanner: false,
                          theme: ThemeData(fontFamily: "Montserrat"),
                          translations: LocalizationService(),
                          locale: LocalizationService().getCurrentLocale(),
                          fallbackLocale: Locale('en', 'US'),
                          home:  SplashScreenToLoginScreen()
                      );
                    }
                  }
                } else {
                  return ErrorScreen();
                }
              }
          ),
        )
    );
  }
}
