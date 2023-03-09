import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '/functions/alert_dialog.dart';

class AddUserFunctions{
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  getUser(String phoneNumber) async{
    final String uidApi = dotenv.get("uidByPhoneNumber");
    http.Response response = await http.get(Uri.parse("$uidApi/+91$phoneNumber"));
    if(response.body.contains("{")){
      var jsonData = json.decode(response.body);
      if(jsonData["transportererrorresponse"]["debugMessage"].toString().contains("No user record found")){
        return "No user Found";
      }
    }else {
      return response.body;
    }
  }

  addUser(String phoneNumber,String companyName,BuildContext context) async{
    String uid = await getUser(phoneNumber);
    if(uid == "No user Found"){
      alertDialog('Add Employee', 'Employee Not Found', context);
    }else{
      final newEmployeeRef = ref.child("companies/${companyName.capitalizeFirst}/members");
      newEmployeeRef.update({
        uid:"employee",
      }).then((value) => {
        alertDialog("Added Employee","Employee Added Succesfully",context)
      }).catchError((error){
        return alertDialog("Error", "Try After Some Time", context);
      });
    }
  }
}