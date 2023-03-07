import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../screens/isolatedTransporterGetData.dart';
import 'dart:math';

// final String idfyAccountId = FlutterConfig.get('idfyAccountId');
final String idfyAccountId = dotenv.env['idfyAccountId'].toString();

// final String idfyApiKey = FlutterConfig.get('idfyApiKey');
final String idfyApiKey = dotenv.env['idfyApiKey'].toString();

// final String idfyKeyId = FlutterConfig.get('idfyKey_id');
final String idfyKeyId = dotenv.env['idfyKey_id'].toString();

// final String idfyOuId = FlutterConfig.get('idfyOu_id');
final String idfyOuId = dotenv.env['idfyOu_id'].toString();

// final String idfySecretKey = FlutterConfig.get('idfySecret_Key');
final String idfySecretKey = dotenv.env['idfySecret_Key'].toString();

// final String webHookUrl = FlutterConfig.get('webHookUrl');
final String webHookUrl = dotenv.env['webHookUrl'].toString();

var headers = {
  'Content-Type': 'application/json',
  'account-id': idfyAccountId,
  'api-key': idfyApiKey
};

String randomGenerator() {
  Random random = new Random();
  return random.nextInt(10000).toString();
}

Future<String> postCallingIdfy() async {
  var body = json.encode({
    "task_id": "74f4c926-250c-43ca-9c53-453e87ceacd1",
    "group_id": "8e16424a-58fc-4ba4-ab20-5bc8e7c3c41e",
    "data": {
      "reference_id": "${transporterIdController.transporterId.value}",
      "key_id": idfyKeyId,
      "ou_id": idfyOuId,
      "secret": idfySecretKey,
      "callback_url": webHookUrl,
      "doc_type": "ADHAR",
      "file_format": "xml",
      "extra_fields": {}
    }
  });
  var response = await http.post(
      Uri.parse(
          'https://eve.idfy.com/v3/tasks/async/verify_with_source/ind_digilocker_fetch_documents'),
      body: body,
      headers: headers);

  print(
      "Status Code------------------------------------------>${response.statusCode}");
  print(
      "Status Body------------------------------------------>${response.body}");
  var decodedData = json.decode(response.body);
  print(decodedData['request_id']);
  return getCallingIdfy(decodedData['request_id']);
}

Future<String> getCallingIdfy(String requestID) async {
  var response = await http.get(
    Uri.parse("https://eve.idfy.com/v3/tasks?request_id=$requestID"),
    headers: headers,
  );
  print(
      "Status Code------------------------------------------>${response.statusCode}");
  print(
      "Status Body------------------------------------------>${response.body}");
  var decodedData = json.decode(response.body);
  print(decodedData[0]['result']["source_output"]["redirect_url"]);
  return decodedData[0]['result']["source_output"]["redirect_url"];
}
