import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/radius.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/controller/transporterIdController.dart';
import 'package:shipper_app/functions/mapUtils/getLoactionUsingImei.dart';
import 'package:shipper_app/models/biddingModel.dart';
import 'package:shipper_app/models/loadDetailsScreenModel.dart';
import 'package:shipper_app/screens/myLoadPages/addNewDriver.dart';
import 'package:shipper_app/screens/myLoadPages/selectDriverScreen.dart';
import 'package:shipper_app/screens/myLoadPages/selectTruckScreen.dart';
import 'package:shipper_app/widgets/HeadingTextWidgetBlue.dart';
import 'package:shipper_app/widgets/buttons/backButtonWidget.dart';
import '../HelpScreen.dart';
// import 'addDriverAlertDialog.dart';

// ignore: must_be_immutable
class BookLoadScreen extends StatefulWidget {
  List? truckModelList;
  List? driverModelList;
  LoadDetailsScreenModel loadDetailsScreenModel;
  BiddingModel? biddingModel;
  bool? directBooking;
  String? postLoadId;

  BookLoadScreen(
      {this.truckModelList,
      this.postLoadId,
      this.driverModelList,
      required this.loadDetailsScreenModel,
      this.biddingModel,
      required this.directBooking});

  @override
  _BookLoadScreenState createState() => _BookLoadScreenState();
}

class _BookLoadScreenState extends State<BookLoadScreen> {
  String? selectedTruck;
  String? selectedDriver;
  String? selectedDriverName;

  TransporterIdController transporterIdController = Get.find();

  late List? driverList = [];
  late List? truckList = [];

  MapUtil mapUtil = MapUtil();

  // getTruckList() async {
  //   // FutureGroup futureGroup = FutureGroup();
  //
  //   var a = mapUtil.getDevices(); ///////////////////////////
  //   // var b = mapUtil.getTraccarPositionforAll(); /////////////////////
  //   var devices = await a; /////////////////////
  //   // setState(() {
  //   //   truckList = devices;
  //   // });
  //   // truckList = devices;
  //   // var gpsDataAll = await b; ////////////////////
  //   truckList!.clear();
  //   // // devicelist.clear();
  //   for (var device in devices) {
  //     setState(() {
  //       truckList!.add(device.truckno);
  //       print(truckList);
  //       // devicelist.add(device);
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  refresh() {
    setState(() {
      var page = ModalRoute.of(context)!.settings.name;
      Get.to(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: statusBarColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: space_2),
          child: Column(
            children: [
              SizedBox(
                height: space_4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BackButtonWidget(),
                  SizedBox(
                    width: space_2,
                  ),
                  HeadingTextWidgetBlue('enterBookingDetails'.tr),
                  SizedBox(
                    width: space_4,
                  ),
                  TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HelpScreen()),
                        );
                      },
                      icon: Icon(
                        Icons.headset_mic_outlined,
                        color: const Color(0xFF152968),
                      ),
                      label: Text(
                        "Help".tr,
                        style: TextStyle(
                            color: const Color(0xFF152968),
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ))
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: space_5, top: space_15),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: space_2),
                child: Text(
                  "Select Truck",
                  style: TextStyle(
                      fontSize: size_9,
                      fontWeight: mediumBoldWeight,
                      color: const Color(0xFF152968)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: ((context) {
                    return SelectTruckScreen(
                      loadDetailsScreenModel: widget.loadDetailsScreenModel,
                      directBooking: true,
                    );
                  })));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: space_5, right: space_5, bottom: space_2),
                  height: 50,
                  width: 356,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius_1 + 2),
                      border: Border.all(color: const Color(0xFF152968))),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: space_2 - 2,
                        right: space_2 - 2,
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: white,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: const Color(0xFF152968),
                          )),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: space_5, top: space_14),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: space_2),
                child: Text(
                  "Select Driver",
                  style: TextStyle(
                      fontSize: size_9,
                      fontWeight: mediumBoldWeight,
                      color: const Color(0xFF152968)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: ((context) {
                    // return AddNewDriver(
                    //   loadDetailsScreenModel: widget.loadDetailsScreenModel,
                    // );
                    return SelectDriverScreen(
                      loadDetailsScreenModel: widget.loadDetailsScreenModel,
                      directBooking: true,
                    );
                  })));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: space_5, right: space_5, bottom: space_2),
                  height: 50,
                  width: 356,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius_1 + 2),
                      border: Border.all(color: const Color(0xFF152968))),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: space_2 - 2,
                        right: space_2 - 2,
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: white,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: const Color(0xFF152968),
                          )),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: space_6 + 0.5),
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(radius_2)),
                      color: const Color(0xFF152968),
                      child: Container(
                        color: const Color(0xFF152968),
                        height: 54,
                        width: 242,
                        child: Center(
                          child: Text(
                            "Proceed",
                            style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: size_12,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
