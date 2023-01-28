import 'package:awomowa/app/theme.dart';
import 'package:awomowa/model/AddShopProvider.dart';
import 'package:awomowa/model/ManageStoresProvider.dart';
import 'package:awomowa/model/OfferListProvider.dart';
import 'package:awomowa/screens/nick_name_dialog.dart';
import 'package:awomowa/utils/app_constants.dart';
import 'package:awomowa/widgets/loader_button.dart';
import 'package:awomowa/widgets/splash_screen_bg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShopDetails extends StatefulWidget {
  static const routeName = 'shopDetails';
  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddShopProvider>(
      builder: (BuildContext context, AddShopProvider addShopProvider,
          Widget child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 0.0,
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.arrow_back_outlined),
                ),
              ),
            ),
          ),
          extendBodyBehindAppBar: true,
          backgroundColor: AppTheme.themeColor,
          body: Stack(
            children: [
              SplashScreenBg(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 58.0),
                child: Container(
                  child: Stack(
                    children: [
                      SizedBox.expand(),
                      Positioned.fill(
                        child: Card(),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 60.0, left: 16.0, right: 16.0, top: 16.0),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${addShopProvider.verifyShopResponse.vendorDetails.shopName}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 24.0),
                                                ),
                                                Text(
                                                  '${addShopProvider.verifyShopResponse.vendorDetails.shopCategoryName} - ${addShopProvider.verifyShopResponse.vendorDetails.shopSubCategoryName}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey,
                                                      fontSize: 14.0),
                                                ),
                                                SizedBox(
                                                  height: 24.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                          //Spacer(),
                                          Container(
                                            child: CircleAvatar(
                                              backgroundColor: Colors.yellow,
                                              backgroundImage: NetworkImage(
                                                  '${addShopProvider.verifyShopResponse.vendorDetails.shopLogo}'),
                                              radius: 50.0,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16.0,
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Center(
                                        child: QrImage(
                                          data:
                                              '${addShopProvider.verifyShopResponse.vendorDetails.referenceNumber}',
                                          version: QrVersions.auto,
                                          size: 200.0,
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          '${addShopProvider.verifyShopResponse.vendorDetails.referenceNumber}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'Description',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontSize: 14.0),
                                      ),
                                      Text(
                                        '${addShopProvider.verifyShopResponse.vendorDetails.description}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                            fontSize: 14.0),
                                      ),
                                      Divider(),
                                      Text(
                                        'Address',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontSize: 14.0),
                                      ),
                                      Text(
                                        '${addShopProvider.verifyShopResponse.vendorDetails.shopAddressLine1}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                            fontSize: 14.0),
                                      ),
                                      addShopProvider
                                                  .verifyShopResponse
                                                  .vendorDetails
                                                  .shopAddressLine2 !=
                                              ''
                                          ? Text(
                                              '${addShopProvider.verifyShopResponse.vendorDetails.shopAddressLine2}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey,
                                                  fontSize: 14.0),
                                            )
                                          : SizedBox(),
                                      Text(
                                        '${addShopProvider.verifyShopResponse.vendorDetails.shopCity} - ${addShopProvider.verifyShopResponse.vendorDetails.shopPincode}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                            fontSize: 14.0),
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Email',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.0),
                                              ),
                                              Text(
                                                '${addShopProvider.verifyShopResponse.vendorDetails.shopMailId}',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Phone',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.0),
                                              ),
                                              Text(
                                                '${addShopProvider.verifyShopResponse.vendorDetails.shopContactNumber}',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: double.infinity,
                              child: LoaderButton(
                                isLoading: addShopProvider.isLoading,
                                btnTxt: 'Add Favs',
                                btnColor: hexToColor(addShopProvider
                                    .verifyShopResponse
                                    .vendorDetails
                                    .appColorCode),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return NickNameDialog(
                                        onPressed: (String nickName) {
                                          Navigator.pop(context);
                                          addShop(addShopProvider, nickName);
                                        },
                                        shopName: addShopProvider
                                            .verifyShopResponse
                                            .vendorDetails
                                            .shopName,
                                      );
                                    },
                                  );
                                },
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> addShop(AddShopProvider addShopProvider, String nickName) async {
    await addShopProvider.addShop(
        addShopProvider.verifyShopResponse.vendorDetails.vendorId, nickName);

    if (addShopProvider.addShopRespnose['status'] == 'success') {
      Provider.of<OfferListProvider>(context, listen: false).getOfferList();
      Provider.of<ManageShopsProvider>(context, listen: false).getShopList();
      Navigator.pop(context);
    } else {
      showSnackBar('Shop Already added !');
    }
  }
}
