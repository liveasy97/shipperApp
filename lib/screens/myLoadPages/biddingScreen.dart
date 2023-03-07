import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/functions/trasnporterApis/transporterApiCalls.dart';
import 'package:shipper_app/models/biddingModel.dart';
import 'package:shipper_app/providerClass/providerData.dart';
import 'package:shipper_app/widgets/Header.dart';
import 'package:shipper_app/widgets/biddingsCardShipperSide.dart';
import 'package:shipper_app/widgets/loadingWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:flutter_config/flutter_config.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class BiddingScreens extends StatefulWidget {
  final String? loadId;
  final String? loadingPointCity;
  final String? unloadingPointCity;

  BiddingScreens(
      {required this.loadId,
      required this.loadingPointCity,
      required this.unloadingPointCity});

  @override
  _BiddingScreensState createState() => _BiddingScreensState();
}

class _BiddingScreensState extends State<BiddingScreens> {
  // final String biddingApiUrl = FlutterConfig.get('biddingApiUrl');
  final String biddingApiUrl = dotenv.env['biddingApiUrl'].toString();

  int i = 0;

  late List jsonData;

  //Scroll Controller for Pagination
  ScrollController scrollController = ScrollController();

  TransporterApiCalls transporterApiCalls = TransporterApiCalls();

  List<BiddingModel> biddingModelList = [];

  getBidDataByLoadId(int i) async {
    http.Response response = await http
        .get(Uri.parse('$biddingApiUrl?loadId=${widget.loadId}&pageNo=$i'));
    jsonData = json.decode(response.body);

    for (var json in jsonData) {
      BiddingModel biddingModel = BiddingModel();
      biddingModel.bidId = json['bidId'] != null ? json['bidId'] : 'Na';
      biddingModel.transporterId =
          json['transporterId'] != null ? json['transporterId'] : 'Na';
      biddingModel.currentBid =
          json['currentBid'] == null ? 'NA' : json['currentBid'].toString();
      biddingModel.previousBid =
          json['previousBid'] == null ? 'NA' : json['previousBid'].toString();
      biddingModel.unitValue =
          json['unitValue'] != null ? json['unitValue'] : 'Na';
      biddingModel.loadId = json['loadId'] != null ? json['loadId'] : 'Na';
      biddingModel.biddingDate =
          json['biddingDate'] != null ? json['biddingDate'] : 'NA';
      biddingModel.truckIdList =
          json['truckId'] != null ? json['truckId'] : 'Na';
      biddingModel.transporterApproval = json['transporterApproval'];
      biddingModel.shipperApproval = json['shipperApproval'];
      setState(() {
        biddingModelList.add(biddingModel);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getBidDataByLoadId(i);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        i = i + 1;
        getBidDataByLoadId(i);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        providerData.updateBidEndpoints(
            widget.loadingPointCity, widget.unloadingPointCity));
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: space_4, horizontal: space_4),
        child: Column(
          children: [
            Header(
                reset: false,
                text: 'bids'.tr,
                // 'Biddings',
                backButton: true),
            Container(
              margin: EdgeInsets.only(top: space_1),
              height: MediaQuery.of(context).size.height * 0.83,
              child: biddingModelList.isEmpty
                  ? Text(
                      'noBid'.tr,
                      // 'No bids yet'
                    )
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: biddingModelList.length,
                      itemBuilder: (context, index) {
                        if (biddingModelList.length == 0) {
                          return LoadingWidget();
                        }
                        return FutureBuilder(
                          future: transporterApiCalls.getDataByTransporterId(
                              biddingModelList[index].transporterId),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return LoadingWidget();
                            }
                            return BiddingsCardShipperSide(
                              loadId: widget.loadId,
                              loadingPointCity: widget.loadingPointCity,
                              unloadingPointCity: widget.unloadingPointCity,
                              currentBid: biddingModelList[index].currentBid,
                              previousBid: biddingModelList[index].previousBid,
                              unitValue: biddingModelList[index].unitValue,
                              companyName: snapshot.data.companyName,
                              biddingDate: biddingModelList[index].biddingDate,
                              bidId: biddingModelList[index].bidId,
                              transporterPhoneNum:
                                  snapshot.data.transporterPhoneNum,
                              transporterLocation:
                                  snapshot.data.transporterLocation,
                              transporterName: snapshot.data.transporterName,
                              shipperApproved:
                                  biddingModelList[index].shipperApproval,
                              transporterApproved:
                                  biddingModelList[index].transporterApproval,
                              isLoadPosterVerified:
                                  snapshot.data.companyApproved,
                            );
                          },
                        );
                      }),
            ),
          ],
        ),
      ),
    ));
  }
} //class end
