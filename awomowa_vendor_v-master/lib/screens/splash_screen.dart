import 'dart:async';

import 'package:awomowa_vendor/providers/VendorDetailsProvider.dart';
import 'package:awomowa_vendor/screens/approval_screen.dart';
import 'package:awomowa_vendor/screens/home_screen.dart';
import 'package:awomowa_vendor/screens/login_screen.dart';
import 'package:awomowa_vendor/screens/user_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _value = true;

  @override
  void initState() {
    Timer(Duration(milliseconds: 600), () {
      setState(() {
        _value = false;
      });
    });

    Timer(Duration(seconds: 2), () {
      checkLoginStatus();
    });
    super.initState();

    showSnackBar(String message, BuildContext context) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VendorDetailsProvider>(
      builder: (BuildContext context,
          VendorDetailsProvider vendorDetailsProvider, Widget child) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: AnimatedContainer(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: Duration(seconds: 2),
                  height: _value ? 50 : 200,
                  width: _value ? 50 : 200,
                  child: Image.asset(
                    'assets/awomowa-round.png',
                    fit: BoxFit.fill,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green[900], width: 2.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green[800],
                        blurRadius: 150,
                        spreadRadius: 1,
                      ),
                    ],
                    color: Colors.white,
                    //borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> checkLoginStatus() async {
    VendorDetailsProvider vendorDetailsProvider =
        Provider.of<VendorDetailsProvider>(context, listen: false);
    await vendorDetailsProvider.getVendorDetails();

    if (vendorDetailsProvider.vendorDetailsResponse.status == 'success') {
      if (vendorDetailsProvider
              .vendorDetailsResponse.merchantInformations.registrationStatus ==
          'registrationCompleted') {
        // Navigator.popAndPushNamed(context, PackageScreen.routeName);
        Navigator.popAndPushNamed(context, ApprovalScreen.routeName);
      } else if (vendorDetailsProvider
              .vendorDetailsResponse.merchantInformations.registrationStatus ==
          'adminApprovalCompleted') {
        Navigator.popAndPushNamed(context, UserDetailsScreen.routeName);
      } else if (vendorDetailsProvider
              .vendorDetailsResponse.merchantInformations.registrationStatus ==
          'shopProfileCompleted') {
        Navigator.popAndPushNamed(context, HomeScreen.routeName);
      } else if (vendorDetailsProvider
              .vendorDetailsResponse.merchantInformations.registrationStatus ==
          'adminDeclined') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) =>
                ApprovalScreen(isDeclined:true),
          ),
        );
      }
    } else {
      Navigator.popAndPushNamed(context, LoginScreen.routeName);
    }
  }
}
