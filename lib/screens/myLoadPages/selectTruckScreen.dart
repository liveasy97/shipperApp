import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/radius.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/functions/mapUtils/getLoactionUsingImei.dart';
import 'package:shipper_app/models/biddingModel.dart';
import 'package:shipper_app/models/loadDetailsScreenModel.dart';
import 'package:shipper_app/screens/TruckScreens/AddNewTruck/truckNumberRegistration.dart';
import 'package:shipper_app/screens/myLoadPages/confirmBookingDetails.dart';
import 'package:shipper_app/widgets/buttons/addTruckButton.dart';
import 'package:shipper_app/widgets/buttons/backButtonWidget.dart';
import 'package:shipper_app/widgets/headingTextWidget.dart';

class SelectTruckScreen extends StatefulWidget {
  // List? truckModelList;
  // List? driverModelList;
  LoadDetailsScreenModel loadDetailsScreenModel;
  BiddingModel? biddingModel;
  bool? directBooking;
  String? postLoadId;
  String? driverName, driverPhoneNo;
  SelectTruckScreen(
      {this.postLoadId,
      required this.loadDetailsScreenModel,
      this.biddingModel,
      this.driverName,
      this.driverPhoneNo,
      required this.directBooking});

  @override
  State<SelectTruckScreen> createState() => _SelectTruckScreenState();
}

class _SelectTruckScreenState extends State<SelectTruckScreen> {
  bool isSelected = false;
  String searchedTruck = "";
  late String selectedTruck;
  late int selectedDeviceId;
  int selectedIndex = -1;
  List truckList = [];
  List searchedTruckList = [];
  List deviceIdList = [];
  List searchedDeviceIdList = [];
  MapUtil mapUtil = MapUtil();
  getTruckList() async {
    // FutureGroup futureGroup = FutureGroup();

    var a = mapUtil.getDevices(); ///////////////////////////
    // var b = mapUtil.getTraccarPositionforAll(); /////////////////////
    var devices = await a; /////////////////////
    // setState(() {
    //   truckList = devices;
    // });
    // truckList = devices;
    // var gpsDataAll = await b; ////////////////////
    truckList.clear();
    deviceIdList.clear();
    for (var device in devices) {
      setState(() {
        truckList.add(device.truckno);
        // truckList.add("123456");
        // truckList.add("1234567");
        // truckList.add("1234568");
        // truckList.add("123456*");
        print(truckList);
        deviceIdList.add(device.deviceId);
        print(deviceIdList);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTruckList();
  }

  void searchoperation(String searchText) {
// searchresult. clear() ;
    if (searchText != null) {
      searchedTruckList.clear();
      searchedDeviceIdList.clear();
      for (int i = 0; i < truckList.length; i++) {
        String data = truckList[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          setState(() {
            print(searchText);
            searchedTruckList.add(data);
            searchedDeviceIdList.add(deviceIdList[i]);
            print(searchedTruckList);
            print(searchedDeviceIdList);
          });
        }
        // else {
        //   searchedTruckList.add("");
        // }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: statusBarColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        width: 130,
        height: space_9 + 1,
        child: FloatingActionButton(
          child: Text(
            "Confirm",
            style: TextStyle(
                color: white,
                fontWeight: mediumBoldWeight,
                fontSize: size_8 + 2),
          ),
          onPressed: isSelected
              ? () => {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: ((context) {
                      return ConfirmBookingDetails(
                        selectedTruck: selectedTruck,
                        selectedDeviceId: selectedDeviceId,
                        driverName: widget.driverName,
                        mobileNo: widget.driverPhoneNo,
                        loadDetailsScreenModel: widget.loadDetailsScreenModel,
                        directBooking: true,
                      );
                    }))),
                  }
              : () => {},
          backgroundColor: darkBlueColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius_4)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: space_2),
            child: Stack(
              children: [
                Column(children: [
                  SizedBox(
                    height: space_4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BackButtonWidget(),
                      SizedBox(
                        width: space_3,
                      ),
                      HeadingTextWidget('selectTruck'.tr),
                      SizedBox(
                        width: space_6,
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddNewTruck("selectTruck"),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.add,
                          color: const Color(0xFF152968),
                        ),
                        label: Text(
                          "Add Truck",
                          style: TextStyle(
                              color: const Color(0xFF152968),
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: space_3,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: space_3, horizontal: space_3),
                    child: Container(
                      height: space_11,
                      decoration: BoxDecoration(
                        color: widgetBackGroundColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            width: 0.8, color: widgetBackGroundColor),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchedTruck = value;
                          });
                          print(value);
                          searchoperation(searchedTruck);
                          selectedTruck = "";
                          selectedDeviceId = -1;
                          selectedIndex = -1;
                        },
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'searchByNumber'.tr,
                          icon: Padding(
                            padding: EdgeInsets.only(left: space_2),
                            child: Icon(
                              Icons.search,
                              color: grey,
                            ),
                          ),
                          hintStyle: TextStyle(
                            fontSize: size_8,
                            color: grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  searchedTruck.length != 0
                      ? SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: ListView.builder(
                              itemCount: searchedTruckList.length,
                              itemBuilder: ((context, index) {
                                return InkWell(
                                  splashColor: Colors.white,
                                  onTap: () {
                                    setState(() {
                                      isSelected = true;
                                      selectedIndex = index;
                                      selectedTruck = searchedTruckList[index];
                                      selectedDeviceId =
                                          searchedDeviceIdList[index];
                                      print(selectedDeviceId);
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: space_8,
                                                right: space_5,
                                                bottom: space_4,
                                                top: space_3),
                                            child: !(index == selectedIndex)
                                                ? Container(
                                                    // color: grey,
                                                    height: 15,
                                                    width: 15,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            space_2,
                                                            space_2,
                                                            0,
                                                            0),
                                                    decoration: BoxDecoration(
                                                      // color: grey,
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/icons/deepbluecircle_ic.png"),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    // color: grey,
                                                    height: 25,
                                                    width: 25,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            space_2,
                                                            space_2,
                                                            0,
                                                            0),
                                                    decoration: BoxDecoration(
                                                      // color: grey,
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/icons/greencheckcircle_ic.png"),
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                          // setState
                                          // changes(),
                                          Text(
                                            searchedTruckList[index],
                                            style: TextStyle(
                                              fontSize: size_10,
                                              fontWeight: mediumBoldWeight,
                                              color: black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: space_5, right: space_5),
                                        child: Divider(
                                          height: size_10,
                                          color: grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: ListView.builder(
                              itemCount: truckList.length,
                              itemBuilder: ((context, index) {
                                return InkWell(
                                  splashColor: Colors.white,
                                  onTap: () {
                                    setState(() {
                                      isSelected = true;
                                      selectedIndex = index;
                                      selectedTruck = truckList[index];
                                      selectedDeviceId = deviceIdList[index];
                                      print(selectedDeviceId);
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: space_8,
                                                right: space_5,
                                                bottom: space_4,
                                                top: space_3),
                                            child: (index != selectedIndex)
                                                ? Container(
                                                    // color: grey,
                                                    height: 15,
                                                    width: 15,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            space_2,
                                                            space_2,
                                                            0,
                                                            0),
                                                    decoration: BoxDecoration(
                                                      // color: grey,
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/icons/deepbluecircle_ic.png"),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    // color: grey,
                                                    height: 25,
                                                    width: 25,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            space_2,
                                                            space_2,
                                                            0,
                                                            0),
                                                    decoration: BoxDecoration(
                                                      // color: grey,
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/icons/greencheckcircle_ic.png"),
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                          // setState
                                          // changes(),
                                          Text(
                                            truckList[index],
                                            style: TextStyle(
                                              fontSize: size_10,
                                              fontWeight: mediumBoldWeight,
                                              color: black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: space_5, right: space_5),
                                        child: Divider(
                                          height: size_10,
                                          color: grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // changes() {
  //   setState(() {
  //     selectedIndex = false;
  //   });
  // }
}
