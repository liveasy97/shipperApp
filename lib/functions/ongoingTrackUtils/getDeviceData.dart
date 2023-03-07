import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shipper_app/controller/transporterIdController.dart';
import 'package:shipper_app/functions/BackgroundAndLocation.dart';
import 'package:shipper_app/language/localization_service.dart';
import 'package:shipper_app/models/deviceModel.dart';
import 'package:shipper_app/models/gpsDataModel.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:shipper_app/models/gpsDataModelForHistory.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<List<DeviceModel>> getDeviceByDeviceId(String deviceId) async {
  // String traccarUser = FlutterConfig.get("traccarUser");
  String traccarUser = dotenv.env['traccarUser'].toString();

  // String traccarPass = FlutterConfig.get("traccarPass");
  String traccarPass = dotenv.env['traccarPass'].toString();

  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$traccarUser:$traccarPass'));
  // String traccarApi = FlutterConfig.get("traccarApi");
  String traccarApi = dotenv.env['traccarApi'].toString();

  try {
    http.Response response = await http.get(
        Uri.parse("$traccarApi/devices/$deviceId"),
        headers: <String, String>{
          'Authorization': basicAuth,
          'Accept': 'application/json'
        });
    print(response.statusCode);
    print("traccar device api response: " + response.body);
    var json = await jsonDecode(response.body);
    List<DeviceModel> devicesList = [];
    if (response.statusCode == 200) {
      DeviceModel deviceModel = new DeviceModel();
      deviceModel.deviceId = json["id"] != null ? json["id"] : 0;
      deviceModel.truckno = json["name"] != null ? json["name"] : 'NA';
      deviceModel.imei = json["uniqueId"] != null ? json["uniqueId"] : 'NA';
      deviceModel.status = json["status"] != null ? json["status"] : 'NA';
      deviceModel.lastUpdate =
          json["lastUpdate"] != null ? json["lastUpdate"] : 'NA';

      devicesList.add(deviceModel);
    }
    return devicesList;
    // } else {
    //   return null;
    // }
  } catch (e) {
    print(e);
    return [];
  }
}
