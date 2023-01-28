import 'package:avatar_glow/avatar_glow.dart';
import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/providers/PackageDetailsProvider.dart';
import 'package:awomowa_vendor/providers/VendorDetailsProvider.dart';
import 'package:awomowa_vendor/screens/user_register_screen.dart';
import 'package:awomowa_vendor/widgets/splash_screen_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PaymentSuccessScreen extends StatefulWidget {
  static const routeName = 'paymentSuccess';
  final bool isFromSignUp;

  const PaymentSuccessScreen({this.isFromSignUp});
  @override
  _PaymentSuccessScreenState createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PackageDetailsProvider>(
      builder: (BuildContext context,
          PackageDetailsProvider packageDetailsProvider, Widget child) {
        return Scaffold(
          backgroundColor: AppTheme.themeColor,
          body: Stack(
            children: [
              SplashScreenBg(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Center(
                      child: AvatarGlow(
                        glowColor: Colors.green,
                        endRadius: 100.0,
                        duration: Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: Duration(milliseconds: 100),
                        child: Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: SvgPicture.asset(
                              'assets/check.svg',
                              color: Colors.white,
                              height: 60,
                            ),
                            radius: 60.0,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Payment Successful',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 24.0),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      'Your 1 month Free trial has been Activated',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.0),
                    ),
                    Divider(),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Continue to get FREE Access by doing the following',
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18.0),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1) Follow Awomowa and Share your App on social media and tag AWOMOWA (1 month Free *)',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14.0),
                        ),
                        Text(
                          '2) For every 10 unique users linked to your App (1 month Free *)',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Spacer(),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if (widget.isFromSignUp) {
                                Navigator.popAndPushNamed(
                                    context, UserDetailsScreen.routeName);
                              } else {
                                Provider.of<VendorDetailsProvider>(context,
                                        listen: false)
                                    .getVendorDetails();
                                Navigator.pop(context);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text(
                                'Proceed',
                                style: TextStyle(
                                    color: AppTheme.themeColor,
                                    fontWeight: FontWeight.w700),
                              ),
                            ))),
                    SizedBox(
                      height: 32.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
