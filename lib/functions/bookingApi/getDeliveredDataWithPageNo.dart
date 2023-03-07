import 'dart:convert';
import 'package:get/get.dart';
import 'package:shipper_app/controller/transporterIdController.dart';
import 'package:shipper_app/functions/loadDeliveredData.dart';
import 'package:shipper_app/models/BookingModel.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:shipper_app/models/deliveredCardModel.dart';

getDeliveredDataWithPageNo(int i) async {
  // final String bookingApiUrl = FlutterConfig.get('bookingApiUrl');
  final String bookingApiUrl = dotenv.env['bookingApiUrl'].toString();

  TransporterIdController transporterIdController =
      Get.find<TransporterIdController>();
  List<DeliveredCardModel> modelList = [];
  http.Response response = await http.get(Uri.parse(
      '$bookingApiUrl?postLoadId=${transporterIdController.transporterId.value}&completed=true&cancel=false&pageNo=$i'));

  var jsonData = json.decode(response.body);

  for (var json in jsonData) {
    BookingModel bookingModel = BookingModel(truckId: []);
    bookingModel.bookingDate =
        json['bookingDate'] != null ? json['bookingDate'] : "NA";
    bookingModel.bookingId = json['bookingId'];
    bookingModel.postLoadId = json['postLoadId'];
    bookingModel.loadId = json['loadId'];
    bookingModel.transporterId = json['transporterId'];
    bookingModel.truckId = json['truckId'];
    bookingModel.cancel = json['cancel'];
    bookingModel.completed = json['completed'];
    bookingModel.completedDate =
        json['completedDate'] != null ? json['completedDate'] : "NA";
    bookingModel.rate = json['rate'] != null ? json['rate'].toString() : 'NA';
    bookingModel.unitValue = json['unitValue'];
    var loadAllDataModel = await loadAllDeliveredData(bookingModel);
    modelList.add(loadAllDataModel);
  }
  return modelList;
}
