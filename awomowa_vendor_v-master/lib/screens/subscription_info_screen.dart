import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/providers/SubscriptionInfoProvider.dart';
import 'package:awomowa_vendor/screens/package_screen.dart';
import 'package:awomowa_vendor/utils/SharedPreferences.dart';
import 'package:awomowa_vendor/widgets/loader_button.dart';
import 'package:awomowa_vendor/widgets/login_screen_bg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionInfoScreen extends StatefulWidget {
  static const routeName = 'subscriptionDetails';
  @override
  _SubscriptionInfoScreenState createState() => _SubscriptionInfoScreenState();
}

class _SubscriptionInfoScreenState extends State<SubscriptionInfoScreen> {
  SharedPrefManager sharedPrefManager = SharedPrefManager();
  bool allowToRenew = false;

  @override
  void initState() {
    // TODO: implement initState
    checkRenewalStatus();
    super.initState();
  }

  checkRenewalStatus() async {
    allowToRenew = await sharedPrefManager.isAllowToRenew();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return SubscriptionInfoProvider();
      },
      child: Consumer<SubscriptionInfoProvider>(
        builder: (BuildContext context,
            SubscriptionInfoProvider subscriptionInfoProvider, Widget child) {
          return Scaffold(
            // backgroundColor: AppTheme.themeColor,

            body: subscriptionInfoProvider.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            color: AppTheme.themeColor,
                            child: Stack(
                              children: [
                                LoginScreenBg(),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .padding
                                                      .top -
                                                  12),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Card(
                                                color: Colors.black,
                                                shape: CircleBorder(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Icon(
                                                    Icons.chevron_left,
                                                    color: AppTheme.themeColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            'Statistics',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 24.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SafeArea(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: AspectRatio(
                                      aspectRatio: 2 / 1.2,
                                      child: Card(
                                        color: AppTheme.themeColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  'Updates Count',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              Spacer(),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  subscriptionInfoProvider
                                                      .subscriptionInfoResponse
                                                      .totalUpdatesCnt,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      letterSpacing: 2.0,
                                                      fontSize: 28.0),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  'Updates',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                                    Expanded(
                                        child: AspectRatio(
                                      aspectRatio: 2 / 1.2,
                                      child: Card(
                                        color: AppTheme.themeColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  'Offers Count',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              Spacer(),
                                              IntrinsicHeight(
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Text(
                                                            subscriptionInfoProvider
                                                                .subscriptionInfoResponse
                                                                .activeOfferCnt,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                letterSpacing:
                                                                    2.0,
                                                                fontSize: 28.0),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Text(
                                                            'Active',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14.0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    VerticalDivider(
                                                        width: 18.0,
                                                        indent: 16.0,
                                                        color: Colors.black),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Text(
                                                            subscriptionInfoProvider
                                                                .subscriptionInfoResponse
                                                                .inActiveOffersCnt,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                letterSpacing:
                                                                    2.0,
                                                                fontSize: 28.0),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Text(
                                                            'InActive',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14.0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: AspectRatio(
                                      aspectRatio: 2 / 1.2,
                                      child: Card(
                                        color: AppTheme.themeColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  'Total Offers',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              Spacer(),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  subscriptionInfoProvider
                                                      .subscriptionInfoResponse
                                                      .totalOffersCnt,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      letterSpacing: 2.0,
                                                      fontSize: 28.0),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  'Offers',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                                    Expanded(
                                        child: AspectRatio(
                                      aspectRatio: 2 / 1.2,
                                      child: Card(
                                        color: AppTheme.themeColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  'Total Customers',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              Spacer(),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  subscriptionInfoProvider
                                                      .subscriptionInfoResponse
                                                      .totalCustomersCnt,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      letterSpacing: 2.0,
                                                      fontSize: 28.0),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  'Customers',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 22.0, horizontal: 8.0),
                                child: Text(
                                  'SUBSCRIPTION DETAILS',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.0,
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: Container(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            AspectRatio(
                                                aspectRatio: 1 / 1,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 8.0,
                                                  value: (1 / 28) *
                                                      (int.parse(
                                                          subscriptionInfoProvider
                                                              .subscriptionInfoResponse
                                                              .noDaystoExpire)),
                                                )),
                                            Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    subscriptionInfoProvider
                                                        .subscriptionInfoResponse
                                                        .noDaystoExpire,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 24.0),
                                                  ),
                                                  SizedBox(
                                                    width: 4.0,
                                                  ),
                                                  Text(
                                                    'days',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14.0),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 24.0,
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SubscriptionDetailsLabelValue(
                                              label: 'Package',
                                              value: subscriptionInfoProvider
                                                  .subscriptionInfoResponse
                                                  .details
                                                  .packageName,
                                            ),
                                            SizedBox(
                                              height: 18.0,
                                            ),
                                            Row(
                                              children: [
                                                SubscriptionDetailsLabelValue(
                                                  label: 'Expiry',
                                                  value: subscriptionInfoProvider
                                                      .subscriptionInfoResponse
                                                      .expireDate,
                                                ),
                                                SizedBox(
                                                  width: 24.0,
                                                ),
                                                SubscriptionDetailsLabelValue(
                                                  label: 'Price',
                                                  value:
                                                      '\$ ${subscriptionInfoProvider.subscriptionInfoResponse.details.packageAmount}',
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          Visibility(
                            visible: allowToRenew,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: LoaderButton(
                                btnTxt: 'Renew Now',
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, PackageScreen.routeName);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class SubscriptionDetailsLabelValue extends StatelessWidget {
  final String label;
  final String value;

  const SubscriptionDetailsLabelValue({this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
