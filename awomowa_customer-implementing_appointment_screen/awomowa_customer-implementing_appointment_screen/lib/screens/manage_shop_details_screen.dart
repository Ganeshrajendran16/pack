import 'package:awomowa/model/ManageStoresProvider.dart';
import 'package:awomowa/model/OfferListProvider.dart';
import 'package:awomowa/responsemodels/manage_stores_response.dart';
import 'package:awomowa/utils/app_constants.dart';
import 'package:awomowa/widgets/loader_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'nick_name_dialog.dart';

class ManageShopDetailsScreen extends StatefulWidget {
  final StoreList shop;
  final bool isFromOffers;

  const ManageShopDetailsScreen({this.shop, this.isFromOffers = false});

  @override
  _ManageShopDetailsScreenState createState() =>
      _ManageShopDetailsScreenState();
}

class _ManageShopDetailsScreenState extends State<ManageShopDetailsScreen> {
  showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void getOffers() {
    Provider.of<OfferListProvider>(context, listen: false).getOfferList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ManageShopsProvider>(
      builder: (BuildContext context, ManageShopsProvider manageShopsProvider,
          Widget child) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: hexToColor(widget.shop.appColorCode),
              title: Text(widget.shop.shopName),
            ),
            body: manageShopsProvider.isLoading
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
                                    color: hexToColor(widget.shop.appColorCode),
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
                                                '${widget.shop.shopActualName}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              subtitle: Text(
                                                widget.shop.shopCategoryName,
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
                                                      '${widget.shop.shopLogo}',
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
                                                  'Nick Name',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12.0),
                                                ),
                                                SizedBox(height: 4.0),
                                                Text(
                                                  '${widget.shop.shopName} ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.0),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return NickNameDialog(
                                                      onPressed: (String
                                                          nickName) async {
                                                        Navigator.pop(context);
                                                        // addShop(addShopProvider, nickName);
                                                        await manageShopsProvider
                                                            .changeNickName(
                                                                nickName,
                                                                widget.shop
                                                                    .storeId);

                                                        if (manageShopsProvider
                                                                    .changeNickNameResponse[
                                                                'status'] ==
                                                            'success') {
                                                          widget.shop.shopName =
                                                              nickName;

                                                          setState(() {});
                                                          getOffers();
                                                        } else {
                                                          showSnackBar(
                                                              manageShopsProvider
                                                                      .changeNickNameResponse[
                                                                  'message'],
                                                              context);
                                                        }
                                                      },
                                                      shopName:
                                                          widget.shop.shopName,
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.blue.shade400,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
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
                                                    '${widget.shop.referenceNumber}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16.0),
                                                  ),
                                                  SizedBox(
                                                    width: 8.0,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Clipboard.setData(
                                                          ClipboardData(
                                                              text: widget.shop
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
                                                                          '${widget.shop.referenceNumber}',
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
                                              data:
                                                  '${widget.shop.referenceNumber}',
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
                                              '${widget.shop.description} ',
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
                                              '${widget.shop.shopMailId} ',
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
                                                  '${widget.shop.shopContactNumber} ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.0),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            InkWell(
                                              onTap: () {
                                                launch(
                                                    "tel://${widget.shop.shopContactNumber}");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.green.shade400,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Icon(
                                                    Icons.call,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
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
                                              'Address',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12.0),
                                            ),
                                            SizedBox(height: 4.0),
                                            Text(
                                              '${widget.shop.shopAddressLine1}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16.0),
                                            ),
                                            widget.shop.shopAddressLine2 != ''
                                                ? Text(
                                                    '${widget.shop.shopAddressLine2}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16.0),
                                                  )
                                                : SizedBox(),
                                            Text(
                                              '${widget.shop.shopCity ?? ''} - ${widget.shop.shopPincode}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  widget.shop.shopTimings != null
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
                                                          widget
                                                                      .shop
                                                                      .shopTimings
                                                                      .monday
                                                                      .openingTime !=
                                                                  'Choose'
                                                              ? widget
                                                                  .shop
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
                                                          widget
                                                                      .shop
                                                                      .shopTimings
                                                                      .monday
                                                                      .closeingTime !=
                                                                  'Choose'
                                                              ? widget
                                                                  .shop
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
                                                          widget
                                                                      .shop
                                                                      .shopTimings
                                                                      .tuesday
                                                                      .openingTime !=
                                                                  'Choose'
                                                              ? widget
                                                                  .shop
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
                                                          widget
                                                                      .shop
                                                                      .shopTimings
                                                                      .tuesday
                                                                      .closeingTime !=
                                                                  'Choose'
                                                              ? widget
                                                                  .shop
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
                                                          widget
                                                                      .shop
                                                                      .shopTimings
                                                                      .wednesday
                                                                      .openingTime !=
                                                                  'Choose'
                                                              ? widget
                                                                  .shop
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
                                                          widget
                                                                      .shop
                                                                      .shopTimings
                                                                      .wednesday
                                                                      .closeingTime !=
                                                                  'Choose'
                                                              ? widget
                                                                  .shop
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
                                                          widget
                                                                      .shop
                                                                      .shopTimings
                                                                      .thursday
                                                                      .openingTime !=
                                                                  'Choose'
                                                              ? widget
                                                                  .shop
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
                                                          widget
                                                                      .shop
                                                                      .shopTimings
                                                                      .thursday
                                                                      .closeingTime !=
                                                                  'Choose'
                                                              ? widget
                                                                  .shop
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
                                                          widget
                                                                      .shop
                                                                      .shopTimings
                                                                      .friday
                                                                      .openingTime !=
                                                                  'Choose'
                                                              ? widget
                                                                  .shop
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
                                                          widget
                                                                      .shop
                                                                      .shopTimings
                                                                      .friday
                                                                      .closeingTime !=
                                                                  'Choose'
                                                              ? widget
                                                                  .shop
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
                                                          widget
                                                                      .shop
                                                                      .shopTimings
                                                                      .saturday
                                                                      .openingTime !=
                                                                  'Choose'
                                                              ? widget
                                                                  .shop
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
                                                          widget
                                                                      .shop
                                                                      .shopTimings
                                                                      .saturday
                                                                      .closeingTime !=
                                                                  'Choose'
                                                              ? widget
                                                                  .shop
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
                                                          widget
                                                                      .shop
                                                                      .shopTimings
                                                                      .sunday
                                                                      .openingTime !=
                                                                  'Choose'
                                                              ? widget
                                                                  .shop
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
                                                          widget
                                                                      .shop
                                                                      .shopTimings
                                                                      .sunday
                                                                      .closeingTime !=
                                                                  'Choose'
                                                              ? widget
                                                                  .shop
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
                              Expanded(
                                child: LoaderButton(
                                  isLoading: false,
                                  btnTxt: 'Share',
                                  btnColor:
                                      hexToColor(widget.shop.appColorCode),
                                  onPressed: () {
                                    Share.share(widget.shop.shopShareContent);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Expanded(
                                child: LoaderButton(
                                  isLoading: manageShopsProvider.isLoading,
                                  btnTxt: 'Remove Shop',
                                  btnColor:
                                      hexToColor(widget.shop.appColorCode),
                                  onPressed: () {
                                    _showRemoveAlertDialog(
                                        context, manageShopsProvider);
                                  },
                                ),
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

  _showRemoveAlertDialog(
      BuildContext context, ManageShopsProvider manageShopsProvider) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Remove"),
      onPressed: () async {
        Navigator.pop(context);
        await manageShopsProvider.removeShop(widget.shop.storeId);

        if (manageShopsProvider.removeShopResponse['status'] == 'success') {
          Provider.of<OfferListProvider>(context, listen: false).getOfferList();
          if (widget.isFromOffers) {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
          } else {
            Navigator.pop(context);
          }
        } else {
          showSnackBar(
              manageShopsProvider.removeShopResponse['message'], context);
        }
      },
    );
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      title: Text("Alert !"),
      content: Text("Are You sure you want to remove this shop?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
