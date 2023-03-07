import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shipper_app/models/gpsDataModel.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



Future<List<GpsDataModel>> getTraccarSummaryByDeviceId({
  int? deviceId,
  String? from,
  String? to,
}) async {

  // String traccarUser = FlutterConfig.get("traccarUser");
  String traccarUser = dotenv.env['traccarUser'].toString();

  // String traccarPass = FlutterConfig.get("traccarPass");
  String traccarPass = dotenv.env['traccarPass'].toString();

  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$traccarUser:$traccarPass'));
  // String traccarApi = FlutterConfig.get("traccarApi");
  String traccarApi = dotenv.env['traccarApi'].toString();


  try {
    print(Uri.parse(
        "$traccarApi/reports/summary?deviceId=$deviceId&from=${from}Z&to=${to}Z"));
    http.Response response = await http.get(
        Uri.parse(
            "$traccarApi/reports/summary?deviceId=$deviceId&from=${from}Z&to=${to}Z"),
        headers: <String, String>{'authorization': basicAuth});
    print(response.statusCode);
    print(response.body);
    var jsonData = await jsonDecode(response.body);
    print(response.body);
    List<GpsDataModel> latLongList = [];
    if (response.statusCode == 200) {
      for (var json in jsonData) {
        GpsDataModel gpsDataModel = new GpsDataModel();
        // gpsDataModel.id = json["id"] != null ? json["id"] : 'NA';
        gpsDataModel.deviceId =
        json["deviceId"] != null ? json["deviceId"] : 0;
        gpsDataModel.speed =
        json["averageSpeed"] != null ? json["averageSpeed"] : 0;
        gpsDataModel.distance =
        json["distance"] != null ? json["distance"] : 0;

        gpsDataModel.startTime =
        json["startTime"] != null ? json["startTime"] : 'NA';
        gpsDataModel.endTime =
        json["endTime"] != null ? json["endTime"] : 'NA';

        // print("Device time : ${gpsDataModel.deviceTime}");

        latLongList.add(gpsDataModel);
      }
      print("TDSummary $latLongList");
      return latLongList;
    } else {
      return [];
    }
  } catch (e) {
    print(e);
    return [];
  }
}