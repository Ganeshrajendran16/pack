import 'dart:io';
import 'dart:ui';

import 'package:awomowa/app/theme.dart';
import 'package:awomowa/model/AddShopProvider.dart';
import 'package:awomowa/screens/shop_details_screen.dart';
import 'package:awomowa/widgets/loader_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vibration/vibration.dart';

class AddShopScreen extends StatefulWidget {
  static const routeName = 'addshop';
  @override
  _AddShopScreenState createState() => _AddShopScreenState();
}

class _AddShopScreenState extends State<AddShopScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  TextEditingController refNoController = TextEditingController();
  final _switchController = AdvancedSegmentController('Scan Code');
  bool isQRCode = true;
  var qrText = '';
  final _refIdFocusNode = FocusNode();
  // Barcode result;
  QRViewController controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    _switchController.addListener(() {
      print(_switchController.value);

      if (_switchController.value == 'Scan Code') {
        _refIdFocusNode.unfocus();
        controller.flipCamera();
        controller.flipCamera();
        controller.resumeCamera();
        isQRCode = true;
      } else {
        isQRCode = false;
        controller.pauseCamera();
        _refIdFocusNode.requestFocus();
      }

      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddShopProvider>(
      builder: (BuildContext context, AddShopProvider addShopProvider,
          Widget child) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Positioned.fill(
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: (QRViewController controller) {
                    this.controller = controller;
                    controller.scannedDataStream.listen((scanData) async {
                      if (await Vibration.hasVibrator()) {
                        Vibration.vibrate(duration: 250);
                      }
                      controller.pauseCamera();

                      checkQRCode(scanData, addShopProvider);
                    });
                  },
                ),
              ),
              isQRCode
                  ? ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3),
                        BlendMode.srcOut,
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                backgroundBlendMode: BlendMode
                                    .dstOut), // This one will handle background + difference out
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: const EdgeInsets.only(top: 80),
                              height: 250,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Positioned.fill(
                      child: Container(
                      color: Colors.black.withOpacity(0.3),
                    )),
              Align(
                alignment: Alignment(0.0, -0.5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          isQRCode ? 'Scan QR Code' : "Enter Reference ID",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Center(
                        child: Text(
                          isQRCode
                              ? 'Scan the QR code of the shop you are willing to add. you can get the qr code from the shop'
                              : 'Enter the Reference ID of the shop you are willing to add. you can get it from the shop.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.0, 0.6),
                child: AdvancedSegment(
                  controller: _switchController, // AdvancedSegmentController
                  segments: {
                    // Map<String, String>

                    'Scan Code': 'Scan Code',
                    'Enter Code': 'Enter Code',
                  },

                  activeStyle: TextStyle(
                      // TextStyle
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0),
                  inactiveStyle: TextStyle(
                    // TextStyle
                    color: Colors.white54,
                  ),
                  backgroundColor: Colors.grey, // Color
                  sliderColor: Colors.white, // Color
                  sliderOffset: 2.0, // Double
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8.0)), // BorderRadius
                  itemPadding: const EdgeInsets.symmetric(
                    // EdgeInsets
                    horizontal: 15,
                    vertical: 10,
                  ),
                  animationDuration: Duration(milliseconds: 250), // Duration
                ),
              ),
              isQRCode
                  ? SizedBox()
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8.0),
                                child: Text(
                                  'REFERENCE ID',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              TextFormField(
                                focusNode: _refIdFocusNode,
                                controller: refNoController,
                                textCapitalization:
                                    TextCapitalization.characters,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 1.0, horizontal: 8.0),
                                    hintText: 'Eg. AB123',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          if (refNoController.text.isNotEmpty) {
                                            checkQRCode(refNoController.text,
                                                addShopProvider);
                                          } else {
                                            showSnackBar(
                                                'Please Enter valid Reference Number');
                                          }
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: AppTheme.themeColor,
                                          child: Icon(Icons
                                              .keyboard_arrow_right_outlined),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              addShopProvider.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  checkQRCode(
    String qrText,
    AddShopProvider addShopProvider,
  ) async {
    await addShopProvider.searchShop(qrText);

    if (addShopProvider.isFound) {
      Navigator.popAndPushNamed(context, ShopDetails.routeName);
    } else {
      showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Wrap(
              children: [
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 36.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            isQRCode
                                ? 'Looks like you have scanned wrong QR Code. please scan a valid code and try again'
                                : 'you have entered wrong reference number of the shop, please verify your reference number before confirming.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        SizedBox(
                          height: 36.0,
                        ),
                        InkWell(
                          onTap: () {
                            controller?.resumeCamera();
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: LoaderButton(
                              btnTxt: isQRCode ? 'SCAN AGAIN' : 'TRY AGAIN',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).whenComplete(() {
        if (isQRCode) {
          controller?.resumeCamera();
        }
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
