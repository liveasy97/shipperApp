import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/controller/transporterIdController.dart';
import 'package:shipper_app/functions/driverApiCalls.dart';
import 'package:shipper_app/screens/home.dart';
import 'package:shipper_app/screens/navigationScreen.dart';
import 'package:shipper_app/widgets/Header.dart';
import 'package:shipper_app/widgets/MyDriversCard.dart';
import 'package:shipper_app/widgets/alertDialog/nextUpdateAlertDialog.dart';
import 'package:shipper_app/widgets/buttons/addDriverButton.dart';
import 'package:shipper_app/widgets/headingTextWidget.dart';
import 'package:shipper_app/widgets/buttons/helpButton.dart';
import 'package:shipper_app/widgets/loadingWidgets/driverLoadingWidgets.dart';
import 'package:shipper_app/widgets/loadingWidgets/truckLoadingLongWidgets.dart';
import 'package:shipper_app/widgets/searchLoadWidget.dart';

class MyDrivers extends StatefulWidget {
  @override
  _MyDriversState createState() => _MyDriversState();
}

class _MyDriversState extends State<MyDrivers> {
  DriverApiCalls driverApiCalls = DriverApiCalls();
  TransporterIdController transporterIdController =
      Get.find<TransporterIdController>();

  ScrollController scrollController = ScrollController();

  var driverList = [];

  List<DropdownMenuItem<String>> dropDownList = [];

  int i = 0;

  bool? loading = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      loading = true;
    });

    getDriverData();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        i = i + 1;
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<bool> _willPopCallback() async {
    Get.offAll(NavigationScreen());
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.fromLTRB(space_4, space_5, space_4, space_2),
          height: MediaQuery.of(context).size.height - space_4,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: _willPopCallback,
                        child: Icon(Icons.arrow_back_ios_rounded),
                      ),
                      SizedBox(
                        width: space_3,
                      ),
                      HeadingTextWidget('mydriver'.tr
                          // 'My Drivers'
                          ),
                      // HelpButtonWidget(),
                    ],
                  ),
                  HelpButtonWidget(),
                ],
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: space_3),
                  child: SearchLoadWidget(
                    hintText: 'search'.tr,
                    // 'Search',
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => NextUpdateAlertDialog());
                    },
                  )),
              //LIST OF DRIVER CARDS---------------------------------------------
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    loading!
                        ? DriverLoadingWidgets()
                        : driverList.isEmpty
                            ? Container(
                                alignment: Alignment.center,
                                // margin: EdgeInsets.only(top: 153),
                                child: Text(
                                  'noDriver'.tr,
                                  // 'Looks like you have not added any Drivers!',
                                  style:
                                      TextStyle(fontSize: size_8, color: grey),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.only(bottom: space_15),
                                controller: scrollController,
                                itemCount: driverList.length,
                                itemBuilder: (context, index) {
                                  return MyDriverCard(
                                    driverData: driverList[index],
                                  );
                                }),
                    Padding(
                      padding: EdgeInsets.only(bottom: space_2),
                      child: Container(
                          padding: EdgeInsets.only(bottom: space_2),
                          margin: EdgeInsets.only(bottom: space_2),
                          child: AddDriverButton()),
                    ),
                  ],
                ),
              ),

              //--------------------------------------------------------------
            ],
          ),
        )),
      ),
    );
  } //build

  getDriverData() async {
    // driverList = await driverApiCalls.getDriversByTransporterId();
    // setState(() {
    //   loading = false;
    // });
    driverList = await driverApiCalls.getDriverData();
    setState(() {
      loading = false;
      print(driverList);
    });
  } //getDriverData

} //class
