import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shipper_app/constants/color.dart';
import 'package:shipper_app/constants/fontSize.dart';
import 'package:shipper_app/constants/fontWeights.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/widgets/buttons/backButtonWidget.dart';
import 'package:provider/provider.dart';
import 'package:shipper_app/providerClass/providerData.dart';
import 'package:get/get.dart';

class AddPostLoadHeader extends StatefulWidget {
  dynamic resetFunction;
  bool reset = true;

  AddPostLoadHeader({this.resetFunction, required this.reset});

  @override
  _AddPostLoadHeaderState createState() => _AddPostLoadHeaderState();
}

class _AddPostLoadHeaderState extends State<AddPostLoadHeader> {
  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
                margin: EdgeInsets.only(right: space_2),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                    providerData.updateUpperNavigatorIndex2(0);
                  },
                  child: Icon(Icons.arrow_back_ios_rounded),
                )),
            Text('postLoad'.tr,
                // AppLocalizations.of(context)!.postLoad,
                style: TextStyle(
                  fontSize: size_10,
                  fontWeight: mediumBoldWeight,
                )),
          ],
        ),
        widget.reset
            ? TextButton(
                onPressed:
                    providerData.resetActive ? widget.resetFunction : null,
                child: Text('reset'.tr,
                    // AppLocalizations.of(context)!.reset,
                    style: TextStyle(
                      color:
                          providerData.resetActive ? truckGreen : unactiveReset,
                      fontSize: size_10,
                      fontWeight: regularWeight,
                    )))
            : SizedBox()
      ],
    );
  }
}
