import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shipper_app/screens/SplashScreenToLogin.dart';
import 'package:shipper_app/screens/SplashScreenToHomePage.dart';
import 'package:shipper_app/screens/errorScreen.dart';
import 'package:shipper_app/screens/noInternetScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shipper_app/language/localization_service.dart';
import 'package:shipper_app/providerClass/providerData.dart';
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

var firebase;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  firebase = Firebase.initializeApp();
  await GetStorage.init();
  await GetStorage.init('TransporterIDStorage');
  // await FlutterConfig.loadEnvVariables();
  await dotenv.load(fileName: ".env");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _connectionStatus = "Unknown";
  late Connectivity connectivity;
  late StreamSubscription<ConnectivityResult> subscription;
  bool isDisconnected = false;

  GetStorage tidstorage = GetStorage('TransporterIDStorage');
  String? transporterId;

  initState() {
    super.initState();
    setState(() {});
    transporterId = tidstorage.read("transporterId");
    checkConnection();
    connectivityChecker();
  }

  void checkConnection() {
    configOneSignel();
    connectivity = new Connectivity();
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
              titleStyle: TextStyle(
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
            titleStyle: TextStyle(
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
    // String oneSignalAppId = FlutterConfig.get('oneSignalAppId').toString();
    String oneSignalAppId = dotenv.env['oneSignalAppId'].toString();
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
