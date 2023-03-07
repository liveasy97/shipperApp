import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/functions/ongoingTrackUtils/getDeviceData.dart';
import 'package:shipper_app/functions/ongoingTrackUtils/getPositionByDeviceId.dart';
import 'package:shipper_app/functions/ongoingTrackUtils/getTraccarSummaryByDeviceId.dart';
import 'package:shipper_app/models/gpsDataModel.dart';
import 'package:shipper_app/models/onGoingCardModel.dart';
import 'package:shipper_app/screens/TransporterOrders/documentUploadScreen.dart';
import 'package:shipper_app/widgets/buttons/trackButton.dart';
import 'package:shipper_app/screens/myLoadPages/onGoingLoadDetails.dart';
import 'package:shipper_app/widgets/LoadEndPointTemplate.dart';
import 'package:shipper_app/widgets/buttons/callButton.dart';
import 'package:shipper_app/widgets/newRowTemplate.dart';
import 'linePainter.dart';

class OngoingCard extends StatefulWidget {
  final OngoingCardModel loadAllDataModel;

  // final GpsDataModel gpsData;

  OngoingCard({
    required this.loadAllDataModel,
  });

  @override
  State<OngoingCard> createState() => _OngoingCardState();
}

class _OngoingCardState extends State<OngoingCard> {
  GpsDataModel? gpsData;
  var devicelist = [];
  var gpsDataList = [];
  var gpsList = [];

  DateTime yesterday =
      DateTime.now().subtract(Duration(days: 1, hours: 5, minutes: 30));
  String? from;
  String? to;
  DateTime now = DateTime.now().subtract(Duration(hours: 5, minutes: 30));
  String? totalDistance;

  @override
  void initState() {
    super.initState();
    getMyTruckPosition();
    initFunction();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loadAllDataModel.driverName == null) {
      widget.loadAllDataModel.driverName = "NA";
    }
    widget.loadAllDataModel.driverName =
        widget.loadAllDataModel.driverName!.length >= 20
            ? widget.loadAllDataModel.driverName!.substring(0, 18) + '..'
            : widget.loadAllDataModel.driverName;
    if (widget.loadAllDataModel.companyName == null) {}
    widget.loadAllDataModel.companyName =
        widget.loadAllDataModel.companyName!.length >= 35
            ? widget.loadAllDataModel.companyName!.substring(0, 33) + '..'
            : widget.loadAllDataModel.companyName;

    widget.loadAllDataModel.unitValue =
        widget.loadAllDataModel.unitValue == "PER_TON"
            ? "tonne".tr
            : "truck".tr;

    return GestureDetector(
      onTap: () {
        // Get.to(() =>
        // OnGoingLoadDetails(
        //       loadALlDataModel: widget.loadAllDataModel,
        //       trackIndicator: false,
        //     ));
        Get.to(documentUploadScreen(
          bookingId: widget.loadAllDataModel.bookingId.toString(),
          truckNo: widget.loadAllDataModel.truckNo,
          loadingPoint: widget.loadAllDataModel.loadingPointCity,
          unloadingPoint: widget.loadAllDataModel.unloadingPointCity,
          transporterName: widget.loadAllDataModel.transporterName,
          transporterPhoneNum: widget.loadAllDataModel.transporterPhoneNum,
          driverPhoneNum: widget.loadAllDataModel.driverPhoneNum,
          driverName: widget.loadAllDataModel.driverName,
          bookingDate: widget.loadAllDataModel.bookingDate,
          // trackApproved: true,
          gpsDataList: gpsDataList,
          // widget.gpsDataList,
          totalDistance: totalDistance,
          //  widget.totalDistance,
          // device: gpsData.deviceId,
          // gpsData!.deviceId
          // widget.device,
        ));
      },
      child: gpsDataList.isNotEmpty
          ? Container(
              margin: EdgeInsets.only(bottom: space_3),
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(space_4),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${"bookingDate".tr} : ${widget.loadAllDataModel.bookingDate}',
                                style: TextStyle(
                                  fontSize: size_6,
                                  color: veryDarkGrey,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios_sharp),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LoadEndPointTemplate(
                                  text:
                                      widget.loadAllDataModel.loadingPointCity,
                                  endPointType: 'loading'),
                              Container(
                                  padding: EdgeInsets.only(left: 2),
                                  height: space_3,
                                  width: space_12,
                                  child: CustomPaint(
                                    foregroundPainter:
                                        LinePainter(height: space_3),
                                  )),
                              LoadEndPointTemplate(
                                  text: widget
                                      .loadAllDataModel.unloadingPointCity,
                                  endPointType: 'unloading'),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: space_4),
                            child: Column(
                              children: [
                                NewRowTemplate(
                                  label: "truckNumber".tr,
                                  value: widget.loadAllDataModel.truckNo,
                                  width: 78,
                                ),
                                NewRowTemplate(
                                    label: "driverName".tr,
                                    value: widget.loadAllDataModel.driverName),
                                NewRowTemplate(
                                  label: "price".tr,
                                  value:
                                      '${widget.loadAllDataModel.rate}/${widget.loadAllDataModel.unitValue}',
                                  width: 78,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: space_4),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: space_1),
                                  child: Image(
                                      height: 16,
                                      width: 23,
                                      color: black,
                                      image: AssetImage(
                                          'assets/icons/TruckIcon.png')),
                                ),
                                Text(
                                  widget.loadAllDataModel.companyName!,
                                  style: TextStyle(
                                    color: liveasyBlackColor,
                                    fontWeight: mediumBoldWeight,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: contactPlaneBackground,
                      padding: EdgeInsets.symmetric(
                        vertical: space_2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TrackButton(
                            gpsData: gpsDataList[0],
                            truckApproved: true,
                            TruckNo: widget.loadAllDataModel.truckNo,
                            totalDistance: totalDistance,
                          ),
                          CallButton(
                            directCall: false,
                            transporterPhoneNum:
                                widget.loadAllDataModel.transporterPhoneNum,
                            driverPhoneNum:
                                widget.loadAllDataModel.driverPhoneNum,
                            driverName: widget.loadAllDataModel.driverName,
                            transporterName:
                                widget.loadAllDataModel.companyName,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }

  void getMyTruckPosition() async {
    var devices =
        await getDeviceByDeviceId(widget.loadAllDataModel.deviceId.toString());
    var gpsDataAll = await getPositionByDeviceId(
        widget.loadAllDataModel.deviceId.toString());

    devicelist.clear();

    if (devices != null) {
      for (var device in devices) {
        setState(() {
          devicelist.add(device);
        });
      }
    }

    gpsList = List.filled(devices.length, null, growable: true);

    for (int i = 0; i < gpsDataAll.length; i++) {
      getGPSData(gpsDataAll[i], i);
    }

    setState(() {
      gpsDataList = gpsList;
    });
  }

  void getGPSData(var gpsData, int i) async {
    gpsList.removeAt(i);

    gpsList.insert(i, gpsData);
  }

  void initFunction() async {
    var gpsRoute1 = await getTraccarSummaryByDeviceId(
        deviceId: widget.loadAllDataModel.deviceId, from: from, to: to);
    setState(() {
      totalDistance = (gpsRoute1[0].distance! / 1000).toStringAsFixed(2);
    });
    print('in init');
  }
}
