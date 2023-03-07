import 'package:get/get.dart';
import 'package:shipper_app/controller/transporterIdController.dart';
import 'package:shipper_app/functions/driverApiCalls.dart';
import 'package:shipper_app/models/driverModel.dart';
import 'package:shipper_app/models/truckModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

getTruckDataWithPageNo(int i) async {
  //TransporterId controller
  TransporterIdController transporterIdController =
      Get.find<TransporterIdController>();

  // retrieving TRUCKAPIURL  from env file
  // final String truckApiUrl = FlutterConfig.get('truckApiUrl');
  final String truckApiUrl = dotenv.env['truckApiUrl'].toString();


  http.Response response = await http.get(Uri.parse(
      '$truckApiUrl?transporterId=${transporterIdController.transporterId.value}&pageNo=$i'));
  var jsonData = json.decode(response.body);
  var truckDataList = [];
  for (var json in jsonData) {
    TruckModel truckModel = TruckModel();
    truckModel.truckId = json["truckId"] != null ? json["truckId"] : 'NA';
    truckModel.transporterId =
        json["transporterId"] != null ? json["transporterId"] : 'NA';
    truckModel.truckNo = json["truckNo"] != null ? json["truckNo"] : 'NA';
    truckModel.truckApproved =
        json["truckApproved"] != null ? json["truckApproved"] : false;
    truckModel.imei = json["imei"] != null ? json["imei"] : 'NA';
    truckModel.passingWeightString =
        json["passingWeight"] != null ? json["passingWeight"].toString() : 'NA';
    truckModel.truckType = json["truckType"] != null ? json["truckType"] : 'NA';
    truckModel.deviceId =
        json["deviceId"] != null ? int.parse(json["deviceId"]) : 0;
    truckModel.tyres = json["tyres"] != null ? json["tyres"].toString() : 'NA';
    truckModel.driverId = json["driverId"] != null ? json["driverId"] : 'NA';
    truckModel.truckLengthString =
        json["truckLength"] != null ? json["truckLength"].toString() : 'NA';
    //driver data
    DriverModel driverModel =
        await getDriverByDriverId(driverId: truckModel.driverId);
    truckModel.driverName = driverModel.driverName;
    truckModel.driverNum = driverModel.phoneNum;
    truckDataList.add(truckModel);
  }
  return truckDataList;
}

getGPSTruckDataWithPageNo(int i) async {
  //TransporterId controller
  TransporterIdController transporterIdController =
      Get.find<TransporterIdController>();

  // retrieving TRUCKAPIURL  from env file
  // final String truckApiUrl = FlutterConfig.get('truckApiUrl');
  final String truckApiUrl = dotenv.env['truckApiUrl'].toString();

  http.Response response = await http.get(Uri.parse(
      '$truckApiUrl?transporterId=${transporterIdController.transporterId.value}&pageNo=$i'));
  var jsonData = json.decode(response.body);
  var truckDataList = [];
  for (var json in jsonData) {
    TruckModel truckModel = TruckModel();
    truckModel.truckId = json["truckId"] != null ? json["truckId"] : 'NA';
    truckModel.transporterId =
        json["transporterId"] != null ? json["transporterId"] : 'NA';
    truckModel.truckNo = json["truckNo"] != null ? json["truckNo"] : 'NA';
    truckModel.truckApproved =
        json["truckApproved"] != null ? json["truckApproved"] : false;
    truckModel.imei = json["imei"] != null ? json["imei"] : 'NA';
    truckModel.deviceId =
        json["deviceId"] != null ? int.parse(json["deviceId"]) : 0;
    truckModel.passingWeightString =
        json["passingWeight"] != null ? json["passingWeight"].toString() : 'NA';
    truckModel.truckType = json["truckType"] != null ? json["truckType"] : 'NA';
    truckModel.driverId = json["driverId"] != null ? json["driverId"] : 'NA';
    truckModel.tyres = json["tyres"] != null ? json["tyres"].toString() : 'NA';
    truckModel.truckLengthString =
        json["truckLength"] != null ? json["truckLength"].toString() : 'NA';
    truckDataList.add(truckModel);
  }
  return truckDataList;
}
