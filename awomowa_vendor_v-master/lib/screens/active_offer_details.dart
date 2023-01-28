import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/providers/ActiveOfferListProvider.dart';
import 'package:awomowa_vendor/providers/DarkThemeProvider.dart';
import 'package:awomowa_vendor/providers/EditOfferProvider.dart';
import 'package:awomowa_vendor/reponse_models/offer_list_response.dart';
import 'package:awomowa_vendor/screens/edit_offer_screen.dart';
import 'package:awomowa_vendor/widgets/splash_screen_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ActiveOfferDetails extends StatelessWidget {
  static const routeName = 'activeOfferDetails';
  final Histories offer;

  const ActiveOfferDetails({this.offer});
  showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditOfferProvider>(
      builder: (BuildContext context, EditOfferProvider editOfferProvider,
          Widget child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
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
          backgroundColor: AppTheme.themeColor,
          body: Stack(
            children: [
              SplashScreenBg(),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Center(
                                  child: Image.network(
                                    '${offer.imageUrl}',
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width: MediaQuery.of(context).size.height *
                                        0.2,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    color: offer.status == 'Active'
                                        ? Colors.green[100]
                                        : Colors.red[100],
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        '${offer.status}',
                                        style: TextStyle(
                                            color: offer.status == 'Active'
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    color: Colors.red.shade50,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.favorite_rounded,
                                            color: Colors.red,
                                          ),
                                          Text(
                                            '${offer.noOfLikes ?? 0} Likes',
                                            style: TextStyle(color: Colors.red),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${offer.productName}',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${offer.categoryName} - ${offer.subcategoryName} ',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            ),
                            Divider(),
                            SizedBox(
                              height: 8.0,
                            ),
                            Expanded(
                              child: Scrollbar(
                                isAlwaysShown: true,
                                child: SingleChildScrollView(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${offer.comments}',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              height: 24.0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Offer Details',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey),
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Card(
                              color: Colors.black,
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Open from',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.0),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          '${offer.createdAt}',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Expires on',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.0),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          '${offer.expireDate}',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            SizedBox(
                              height: 16.0,
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Container(
                                height: 100.0,
                                width: 100.0,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/price_bg.svg',
                                      height: 100.0,
                                      width: 100.0,
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppTheme.themeColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                '\$ ${offer.price}',
                                                style: TextStyle(
                                                    fontSize: 32.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text('${offer.unit}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            offer.status == 'Active'
                                ? Row(
                                    children: [
                                      Expanded(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.black),
                                              onPressed: () {
                                                showDeactivateOfferAlert(
                                                    context,
                                                    editOfferProvider,
                                                    offer.broadcastId);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(14.0),
                                                child: Text(
                                                  'Un-Publish',
                                                  style: TextStyle(
                                                      color:
                                                          AppTheme.themeColor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ))),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Expanded(
                                          child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                  side: BorderSide(
                                                      color:
                                                          Provider.of<DarkThemeProvider>(
                                                                      context)
                                                                  .darkTheme
                                                              ? Colors.white
                                                              : AppTheme
                                                                  .textBlack),
                                                  primary:
                                                      Provider.of<DarkThemeProvider>(
                                                                  context)
                                                              .darkTheme
                                                          ? Colors.white
                                                          : AppTheme.textBlack),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditOfferScreen(
                                                      offer: offer,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(14.0),
                                                child: Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                      color:
                                                          Provider.of<DarkThemeProvider>(
                                                                      context)
                                                                  .darkTheme
                                                              ? Colors.white
                                                              : AppTheme
                                                                  .textBlack,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ))),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Expanded(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.black),
                                              onPressed: () {
                                                // showDialog(
                                                //   context: context,
                                                //   builder:
                                                //       (BuildContext context) =>
                                                //           RepublishDialog(
                                                //     onPressed:
                                                //         (String newDate) {
                                                //       rePublishOffer(
                                                //           context,
                                                //           editOfferProvider,
                                                //           offer.broadcastId,
                                                //           newDate);
                                                //     },
                                                //   ),
                                                // );
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditOfferScreen(
                                                      offer: offer,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(14.0),
                                                child: Text(
                                                  'Re-Publish',
                                                  style: TextStyle(
                                                      color:
                                                          AppTheme.themeColor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ))),
                                      // SizedBox(
                                      //   width: 8.0,
                                      // ),
                                      // Expanded(
                                      //     child: OutlinedButton(
                                      //         style: OutlinedButton.styleFrom(
                                      //             primary: Colors.black),
                                      //         onPressed: () {
                                      //           Navigator.push(
                                      //             context,
                                      //             MaterialPageRoute(
                                      //               builder: (context) =>
                                      //                   EditOfferScreen(
                                      //                 offer: offer,
                                      //               ),
                                      //             ),
                                      //           );
                                      //         },
                                      //         child: Padding(
                                      //           padding:
                                      //               const EdgeInsets.all(14.0),
                                      //           child: Text(
                                      //             'Edit',
                                      //             style: TextStyle(
                                      //                 color: AppTheme.textBlack,
                                      //                 fontWeight:
                                      //                     FontWeight.w700),
                                      //           ),
                                      //         ))),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  rePublishOffer(BuildContext context, EditOfferProvider editOfferProvider,
      String id, String newDate) async {
    await editOfferProvider.rePublishOffer(newDate, id);
    Navigator.pop(context);
    if (editOfferProvider.republishResponse['status'] == 'success') {
      showSnackBar('A new offer has been published successfully !', context);
    } else {
      showSnackBar(editOfferProvider.republishResponse['message'], context);
    }
  }

  showDeactivateOfferAlert(
      BuildContext context, EditOfferProvider editOfferProvider, String id) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Un-Publish"),
      onPressed: () async {
        await editOfferProvider.deactivateOffer(id);

        if (editOfferProvider.deactivateOfferResponse['status'] == 'success') {
          showSnackBar('This offer has been unpublished!', context);
          Provider.of<ActiveOfferListProvider>(context, listen: false)
              .getOfferList();
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          showSnackBar(
              editOfferProvider.deactivateOfferResponse['message'], context);
        }
      },
    );
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      title: Text("Alert !"),
      content: Text("Are You sure you want to unpublish this offer?"),
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
