import 'dart:io';

import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/providers/VendorDetailsProvider.dart';
import 'package:awomowa_vendor/screens/home_screen.dart';
import 'package:awomowa_vendor/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'edit_shop_info_screen.dart';

class ShopDetails extends StatefulWidget {
  static const routeName = 'shopDetails';

  final bool isFromSettings;

  const ShopDetails({this.isFromSettings = true});

  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  bool isDownloading = false;
  double _downloadProgress = 0.1;
  final Dio _dio = Dio();

  showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _download(String url) async {
    Map<Permission, PermissionStatus> status =
        await [Permission.storage].request();

    final dir = await _getDownloadDirectory();
    // final isPermissionStatusGranted = await _requestPermissions();

    if (status[Permission.storage].isGranted) {
      final savePath = path.join(dir.path, 'poster.pdf');
      await _startDownload(savePath, url);
    } else {
      if (await Permission.storage.isPermanentlyDenied) {
        openAppSettings();
      } else {
        showSnackBar('Please grant permission for downloading.');
      }
    }
  }

  Future<void> _startDownload(String savePath, String downloadUrl) async {
    setState(() {
      isDownloading = true;
    });

    try {
      final response = await _dio.download(
        downloadUrl,
        savePath,
        onReceiveProgress: _onReceiveProgress,
      );
      print(response.headers["content-length"]);
    } catch (e) {
      print(e);
      showSnackBar('Download Failed');
    }

    setState(() {
      isDownloading = false;
      _downloadProgress = 0.1;
    });
  }

  Future<void> _onReceiveProgress(int received, int total) async {
    print(received);
    print(
        'received: ${received.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}');
    if (total != -1) {
      setState(() {
        _downloadProgress = received / total * 100 * 0.01;
      });
      if (received / total * 100 == 100) {
        print('success');
        final dir = await _getDownloadDirectory();
        // final isPermissionStatusGranted = await _requestPermissions();
        final savePath = path.join(dir.path, 'poster.pdf');
        _downloadProgress = 0.0;
        OpenFile.open(savePath);
      }
    }
  }

  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await DownloadsPathProvider.downloadsDirectory;
    }

    return await getApplicationDocumentsDirectory();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<VendorDetailsProvider>(context, listen: false)
            .getVendorDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VendorDetailsProvider>(
      builder: (BuildContext context,
          VendorDetailsProvider vendorDetailsProvider, Widget child) {
        var shop =
            vendorDetailsProvider.vendorDetailsResponse.merchantInformations;
        return Scaffold(
            appBar: AppBar(
              backgroundColor: hexToColor(shop.appColorCode),
              title: Text(shop.shopName),
            ),
            body: vendorDetailsProvider.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 96.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Card(
                                    margin: EdgeInsets.zero,
                                    color: hexToColor(shop.appColorCode),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              top: -100,
                                              left: -250.0,
                                              child: SvgPicture.asset(
                                                'assets/outline_blob2.svg',
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                height: 300.0,
                                                width: 200.0,
                                              )),
                                          Positioned(
                                              bottom: -20,
                                              right: -50.0,
                                              child: RotatedBox(
                                                quarterTurns: 1,
                                                child: SvgPicture.asset(
                                                  'assets/blob_1.svg',
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  height: 150.0,
                                                  width: 150.0,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              )),
                                          Positioned(
                                              bottom: -80,
                                              right: 150.0,
                                              child: SvgPicture.asset(
                                                'assets/blob_1.svg',
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                height: 150.0,
                                                width: 150.0,
                                                fit: BoxFit.fitHeight,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: ListTile(
                                              title: Text(
                                                '${shop.shopName}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              subtitle: Text(
                                                shop.shopCategoryName,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              trailing: AspectRatio(
                                                aspectRatio: 1,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          75.0),
                                                  child: Container(
                                                    height: 150.0,
                                                    width: 150.0,
                                                    child: Image.network(
                                                      '${shop.shopLogo}',
                                                      fit: BoxFit.fill,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    50.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
                                  Card(
                                      child: InkWell(
                                    onTap: () {
                                      launch(vendorDetailsProvider
                                          .vendorDetailsResponse
                                          .merchantInformations
                                          .qrCodeUrl);
                                    },
                                    child: ListTile(
                                      trailing: isDownloading
                                          ? SizedBox(
                                              height: 24.0,
                                              width: 24.0,
                                              child: CircularProgressIndicator(
                                                value: _downloadProgress,
                                              ),
                                            )
                                          : Icon(
                                              Icons.download_rounded,
                                            ),
                                      title: Text('Shop Poster'),
                                      subtitle: Text(
                                          'Download personalised poster for your shop'),
                                    ),
                                  )),
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Shop Reference code',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12.0),
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${shop.referenceNumber}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16.0),
                                                  ),
                                                  SizedBox(
                                                    width: 8.0,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      await Clipboard.setData(
                                                          ClipboardData(
                                                              text: shop
                                                                  .referenceNumber));

                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  'Reference Code Copied !')));
                                                    },
                                                    child: Icon(
                                                      Icons.copy,
                                                      color: Colors.blue,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (ctx) => Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: Container(
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          child: Stack(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          16.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          color: Colors
                                                                              .grey
                                                                              .shade600),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Center(
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .white,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        32.0),
                                                                    child:
                                                                        QrImage(
                                                                      data:
                                                                          '${shop.referenceNumber}',
                                                                      version:
                                                                          QrVersions
                                                                              .auto,
                                                                      size: MediaQuery.of(context)
                                                                              .size
                                                                              .width -
                                                                          50,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ));
                                            },
                                            child: QrImage(
                                              data: '${shop.referenceNumber}',
                                              version: QrVersions.auto,
                                              size: 50.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'About Shop',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12.0),
                                            ),
                                            SizedBox(height: 4.0),
                                            Text(
                                              '${shop.description} ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Email',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12.0),
                                            ),
                                            SizedBox(height: 4.0),
                                            Text(
                                              '${shop.shopMailId} ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Phone',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12.0),
                                                ),
                                                SizedBox(height: 4.0),
                                                Text(
                                                  '${shop.shopContactNumber} ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.0),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Address',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12.0),
                                            ),
                                            SizedBox(height: 4.0),
                                            Text(
                                              '${shop.address1}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16.0),
                                            ),
                                            shop.address2 != ''
                                                ? Text(
                                                    '${shop.address1}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16.0),
                                                  )
                                                : SizedBox(),
                                            Text(
                                              '${shop.shopCity ?? ''} - ${shop.shopPincode}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  shop.shopTimings != null
                                      ? Card(
                                          child: Container(
                                            width: double.infinity,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Shop Timing',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12.0),
                                                  ),
                                                  SizedBox(height: 4.0),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          'Day',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          'Open',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          'Close',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          'Monday',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          shop.shopTimings.monday
                                                                      .openingTime !=
                                                                  'Choose'
                                                              ? shop
                                                                  .shopTimings
                                                                  .monday
                                                                  .openingTime
                                                              : 'Not Provided',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          shop.shopTimings.monday
                                                                      .closeingTime !=
                                                                  'Choose'
                                                              ? shop
                                                                  .shopTimings
                                                                  .monday
                                                                  .closeingTime
                                                              : 'Not Provided',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          'Tuesday',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          shop.shopTimings.tuesday
                                                                      .openingTime !=
                                                                  'Choose'
                                                              ? shop
                                                                  .shopTimings
                                                                  .tuesday
                                                                  .openingTime
                                                              : 'Not Provided',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          shop.shopTimings.tuesday
                                                                      .closeingTime !=
                                                                  'Choose'
                                                              ? shop
                                                                  .shopTimings
                                                                  .tuesday
                                                                  .closeingTime
                                                              : 'Not Provided',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          'Wednesday',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          shop
                                                                      .shopTimings
                                                                      .wednesday
                                                                      .openingTime !=
                                                                  'Choose'
                                                              ? shop
                                                                  .shopTimings
                                                                  .wednesday
                                                                  .openingTime
                                                              : 'Not Provided',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          shop
                                                                      .shopTimings
                                                                      .wednesday
                                                                      .closeingTime !=
                                                                  'Choose'
                                                              ? shop
                                                                  .shopTimings
                                                                  .wednesday
                                                                  .closeingTime
                                                              : 'Not Provided',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          'Thursday',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          shop
                                                                      .shopTimings
                                                                      .thursday
                                                                      .openingTime !=
                                                                  'Choose'
                                                              ? shop
                                                                  .shopTimings
                                                                  .thursday
                                                                  .openingTime
                                                              : 'Not Provided',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          shop
                                                                      .shopTimings
                                                                      .thursday
                                                                      .closeingTime !=
                                                                  'Choose'
                                                              ? shop
                                                                  .shopTimings
                                                                  .thursday
                                                                  .closeingTime
                                                              : 'Not Provided',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          'Friday',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          shop.shopTimings.friday
                                                                      .openingTime !=
                                                                  'Choose'
                                                              ? shop
                                                                  .shopTimings
                                                                  .friday
                                                                  .openingTime
                                                              : 'Not Provided',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          shop.shopTimings.friday
                                                                      .closeingTime !=
                                                                  'Choose'
                                                              ? shop
                                                                  .shopTimings
                                                                  .friday
                                                                  .closeingTime
                                                              : 'Not Provided',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          'Saturday',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          shop
                                                                      .shopTimings
                                                                      .saturday
                                                                      .openingTime !=
                                                                  'Choose'
                                                              ? shop
                                                                  .shopTimings
                                                                  .saturday
                                                                  .openingTime
                                                              : 'Not Provided',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          shop
                                                                      .shopTimings
                                                                      .saturday
                                                                      .closeingTime !=
                                                                  'Choose'
                                                              ? shop
                                                                  .shopTimings
                                                                  .saturday
                                                                  .closeingTime
                                                              : 'Not Provided',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          'Sunday',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          shop.shopTimings.sunday
                                                                      .openingTime !=
                                                                  'Choose'
                                                              ? shop
                                                                  .shopTimings
                                                                  .sunday
                                                                  .openingTime
                                                              : 'Not Provided',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          shop.shopTimings.sunday
                                                                      .closeingTime !=
                                                                  'Choose'
                                                              ? shop
                                                                  .shopTimings
                                                                  .sunday
                                                                  .closeingTime
                                                              : 'Not Provided',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Expanded(
                              //       flex: 7,
                              //       child: Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Text(
                              //             '${shop.shopName}',
                              //             style: TextStyle(
                              //                 fontWeight: FontWeight.w800,
                              //                 fontSize: 24.0),
                              //           ),
                              //           Text(
                              //             '${shop.shopCategoryName} - ${shop.shopSubCategoryName}',
                              //             style: TextStyle(
                              //                 fontWeight: FontWeight.w400,
                              //                 color: Colors.grey,
                              //                 fontSize: 14.0),
                              //           ),
                              //           SizedBox(
                              //             height: 24.0,
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //     Expanded(
                              //       flex: 3,
                              //       child: ClipOval(
                              //         child: AspectRatio(
                              //           aspectRatio: 1 / 1,
                              //           child: Container(
                              //             decoration: BoxDecoration(
                              //                 shape: BoxShape.circle,
                              //                 border: Border.all(
                              //                     width: 4, color: Colors.red)),
                              //             child: ClipOval(
                              //               child: Image.network(
                              //                 shop.shopLogo,
                              //                 fit: BoxFit.fill,
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 16.0,
                              // ),
                              // SizedBox(
                              //   height: 8.0,
                              // ),
                              // Center(
                              //   child: QrImage(
                              //     data: '${shop.referenceNumber}',
                              //     version: QrVersions.auto,
                              //     size: 200.0,
                              //   ),
                              // ),
                              // Center(
                              //   child: Text(
                              //     '${shop.referenceNumber}',
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.w400,
                              //         fontSize: 16.0),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 8.0,
                              // ),
                              // Text(
                              //   'Description',
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.w400,
                              //       color: Colors.black,
                              //       fontSize: 14.0),
                              // ),
                              // Text(
                              //   '${shop.description} ',
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.w400,
                              //       color: Colors.grey,
                              //       fontSize: 14.0),
                              // ),
                              // Divider(
                              //   color: Colors.red,
                              // ),
                              // Text(
                              //   'Address',
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.w400,
                              //       color: Colors.black,
                              //       fontSize: 14.0),
                              // ),
                              // Text(
                              //   '${shop.shopAddressLine1}',
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.w400,
                              //       color: Colors.grey,
                              //       fontSize: 14.0),
                              // ),
                              // Text(
                              //   '${shop.shopAddressLine2}',
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.w400,
                              //       color: Colors.grey,
                              //       fontSize: 14.0),
                              // ),
                              // Text(
                              //   '${shop.shopCity} - ${shop.shopPincode}',
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.w400,
                              //       color: Colors.grey,
                              //       fontSize: 14.0),
                              // ),
                              // Divider(
                              //   color: Colors.red,
                              // ),
                              // Row(
                              //   children: [
                              //     Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         Text(
                              //           'Email',
                              //           style: TextStyle(
                              //               color: Colors.grey,
                              //               fontWeight: FontWeight.w400,
                              //               fontSize: 12.0),
                              //         ),
                              //         Text(
                              //           '${shop.shopMailId}',
                              //           style: TextStyle(
                              //               color: Colors.grey,
                              //               fontWeight: FontWeight.w600),
                              //         ),
                              //       ],
                              //     ),
                              //     Spacer(),
                              //     Column(
                              //       crossAxisAlignment: CrossAxisAlignment.end,
                              //       children: [
                              //         Text(
                              //           'Phone',
                              //           style: TextStyle(
                              //               color: Colors.grey,
                              //               fontWeight: FontWeight.w400,
                              //               fontSize: 12.0),
                              //         ),
                              //         Text(
                              //           '${shop.shopContactNumber}',
                              //           style: TextStyle(
                              //               color: Colors.grey,
                              //               fontWeight: FontWeight.w600),
                              //         ),
                              //       ],
                              //     ),
                              //   ],
                              // ),
                              // Divider(
                              //   color: Colors.red,
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              widget.isFromSettings
                                  ? Expanded(
                                      child: SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: AppTheme.themeColor,
                                                  elevation: 0),
                                              onPressed: () {
                                                Share.share(vendorDetailsProvider
                                                    .vendorDetailsResponse
                                                    .merchantInformations
                                                    .referenceCodeShareContent);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(14.0),
                                                child: Text(
                                                  'Share',
                                                  style: TextStyle(
                                                      color: AppTheme.textBlack,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ))),
                                    )
                                  : SizedBox(),
                              SizedBox(
                                width: widget.isFromSettings ? 16.0 : 0,
                              ),
                              widget.isFromSettings
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, EditShopInfo.routeName);
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.green.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(16.0)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(14.0),
                                            child: Icon(Icons.edit),
                                          )),
                                    )
                                  : Expanded(
                                      child: SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: AppTheme.themeColor,
                                                  elevation: 0),
                                              onPressed: () {
                                                Navigator.popAndPushNamed(
                                                    context,
                                                    HomeScreen.routeName);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(14.0),
                                                child: Text(
                                                  'Proceed',
                                                  style: TextStyle(
                                                      color: AppTheme.textBlack,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ))),
                                    ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ));
      },
    );
  }
}
