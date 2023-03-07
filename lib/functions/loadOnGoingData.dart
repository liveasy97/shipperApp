import 'package:flutter/material.dart';
import 'package:shipper_app/functions/trasnporterApis/transporterApiCalls.dart';
import 'package:shipper_app/functions/truckApis/truckApiCalls.dart';
import 'package:shipper_app/models/BookingModel.dart';
import 'package:shipper_app/models/driverModel.dart';
import 'package:shipper_app/models/onGoingCardModel.dart';
import 'package:shipper_app/models/transporterModel.dart';
import 'driverApiCalls.dart';
import 'loadApiCalls.dart';

//TODO:later on ,put these variables inside the function
LoadApiCalls loadApiCalls = LoadApiCalls();

TransporterApiCalls transporterApiCalls = TransporterApiCalls();

TruckApiCalls truckApiCalls = TruckApiCalls();

DriverApiCalls driverApiCalls = DriverApiCalls();

Future<OngoingCardModel?> loadAllOngoingData(BookingModel bookingModel) async {
  // Map loadData = await loadApiCalls.getDataByLoadId(bookingModel.loadId!);
  TransporterModel transporterModel = await transporterApiCalls
      .getDataByTransporterId(bookingModel.transporterId);

  OngoingCardModel loadALLDataModel = OngoingCardModel();
  loadALLDataModel.bookingDate = bookingModel.bookingDate;
  loadALLDataModel.bookingId = bookingModel.bookingId;
  loadALLDataModel.completedDate = bookingModel.completedDate;
  loadALLDataModel.deviceId = bookingModel.deviceId;
  loadALLDataModel.loadingPointCity = bookingModel.loadingPointCity;
  loadALLDataModel.unloadingPointCity = bookingModel.unloadingPointCity;
  loadALLDataModel.companyName = transporterModel.companyName;
  loadALLDataModel.transporterPhoneNum = transporterModel.transporterPhoneNum;
  loadALLDataModel.transporterLocation = transporterModel.transporterLocation;
  loadALLDataModel.transporterName = transporterModel.transporterName;
  loadALLDataModel.transporterApproved = transporterModel.transporterApproved;
  loadALLDataModel.companyApproved = transporterModel.companyApproved;
  loadALLDataModel.truckNo = bookingModel.truckNo;
  loadALLDataModel.truckType = 'NA';
  loadALLDataModel.imei = 'NA';
  loadALLDataModel.driverName = bookingModel.driverName;
  loadALLDataModel.driverPhoneNum = bookingModel.driverPhoneNum;
  loadALLDataModel.rate = bookingModel.rate.toString();
  loadALLDataModel.unitValue = bookingModel.unitValue;
  loadALLDataModel.noOfTrucks = 'NA';
  loadALLDataModel.productType = 'NA';

  return loadALLDataModel;
}
