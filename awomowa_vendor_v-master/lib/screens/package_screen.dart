import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/providers/PackageDetailsProvider.dart';
import 'package:awomowa_vendor/screens/coupon_code_bottom_sheet.dart';
import 'package:awomowa_vendor/screens/payment_success_screen.dart';
import 'package:awomowa_vendor/widgets/loader_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PackageScreen extends StatefulWidget {
  static const routeName = 'packageScreen';
  final bool isFromSignUp;

  const PackageScreen({this.isFromSignUp = false});
  @override
  _PackageScreenState createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showCouponBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return CouponCodeSheet();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PackageDetailsProvider>(
      builder: (BuildContext context,
          PackageDetailsProvider packageDetailsProvider, Widget child) {
        return Scaffold(
          body: packageDetailsProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        SizedBox(
                          height: 32.0,
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: AppTheme.themeColor.withOpacity(0.2)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SvgPicture.asset(
                                'assets/star.svg',
                                color: AppTheme.themeColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        Text(
                          '${packageDetailsProvider.packageDetailsResponse.packageInforamtion[0].packageName}',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 24.0),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          '${packageDetailsProvider.packageDetailsResponse.packageInforamtion[0].limitaionDetails[0].displayContent}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        Text(
                          '${packageDetailsProvider.packageDetailsResponse.packageInforamtion[0].limitaionDetails[1].displayContent}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                        Spacer(),
                        Card(
                          shape: CircleBorder(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.themeColor,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(36.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '\$ ${packageDetailsProvider.packageDetailsResponse.packageInforamtion[0].packageAmount}',
                                    style: TextStyle(
                                        fontSize: 32.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    'One Time ',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Visibility(
                          visible: false,
                          child: InkWell(
                              onTap: () {
                                _showCouponBottomSheet();
                              },
                              child: Text('Have a Coupon Code ?')),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        LoaderButton(
                          btnTxt: 'Activate Now',
                          isLoading: packageDetailsProvider.isLoading,
                          onPressed: () async {
                            subscribePackage(packageDetailsProvider);
                          },
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  showPaymentFailedDialog(BuildContext context) {
    // set up the buttons

    Widget continueButton = FlatButton(
      child: Text("Retry"),
      onPressed: () async {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      title: Text("Sorry"),
      content: Text("Your Payment has failed !"),
      actions: [
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

  Future<void> subscribePackage(
      PackageDetailsProvider packageDetailsProvider) async {
    await packageDetailsProvider.subscribePackage(widget.isFromSignUp);

    if (packageDetailsProvider.packageSubscribeResponse['status'] ==
        'success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) =>
              PaymentSuccessScreen(isFromSignUp: widget.isFromSignUp),
        ),
      );
    } else {
      showSnackBar(
          packageDetailsProvider.packageSubscribeResponse['message'], context);
    }
  }
}
