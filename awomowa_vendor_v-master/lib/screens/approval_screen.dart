import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/providers/DarkThemeProvider.dart';
import 'package:awomowa_vendor/providers/VendorDetailsProvider.dart';
import 'package:awomowa_vendor/screens/home_screen.dart';
import 'package:awomowa_vendor/screens/user_register_screen.dart';
import 'package:awomowa_vendor/utils/SharedPreferences.dart';
import 'package:awomowa_vendor/widgets/loader_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class ApprovalScreen extends StatelessWidget {
  static const routeName = '/approvalScreen';

  final bool isDeclined;

  const ApprovalScreen({this.isDeclined = false});

  showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<VendorDetailsProvider>(context, listen: true).isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: SvgPicture.asset(
                      isDeclined ? 'assets/declined.svg' : 'assets/waiting.svg',
                    ),
                  ),
                  Text(
                    isDeclined ? 'Approval Declined !' : 'Approval Pending !',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22.0,
                        color: isDeclined ? Colors.red : null),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    isDeclined
                        ? 'Your account request has been declined by the admin'
                        : 'Please wait for approval from admin for free services.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  isDeclined
                      ? SizedBox()
                      : LoaderButton(
                          btnTxt: 'Refresh',
                          isLoading: false,
                          onPressed: () async {
                            checkLoginStatus(context);
                          },
                        ),
                  SizedBox(
                    height: 24.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: Provider.of<DarkThemeProvider>(context)
                                        .darkTheme
                                    ? Colors.white
                                    : AppTheme.textBlack),
                            primary: Provider.of<DarkThemeProvider>(context)
                                    .darkTheme
                                ? Colors.white
                                : AppTheme.textBlack),
                        onPressed: () async {
                          SharedPrefManager prefManager = SharedPrefManager();

                          await prefManager.logout(context);

                          Navigator.pushAndRemoveUntil<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => LoginScreen(),
                            ),
                            (route) =>
                                false, //if you want to disable back feature set to false
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            isDeclined ? 'Logout' : 'Logout For Now',
                            style: TextStyle(
                                color: Provider.of<DarkThemeProvider>(context)
                                        .darkTheme
                                    ? Colors.white
                                    : AppTheme.textBlack,
                                fontWeight: FontWeight.w700),
                          ),
                        )),
                  )
                ],
              ),
            ),
    );
  }

  Future<void> checkLoginStatus(var context) async {
    VendorDetailsProvider vendorDetailsProvider =
        Provider.of<VendorDetailsProvider>(context, listen: false);
    await vendorDetailsProvider.getVendorDetails();

    if (vendorDetailsProvider.vendorDetailsResponse.status == 'success') {
      if (vendorDetailsProvider
              .vendorDetailsResponse.merchantInformations.registrationStatus ==
          'registrationCompleted') {
        // Navigator.popAndPushNamed(context, PackageScreen.routeName);
        showSnackBar('Approval Pending !', context);
      } else if (vendorDetailsProvider
              .vendorDetailsResponse.merchantInformations.registrationStatus ==
          'adminApprovalCompleted') {
        Navigator.popAndPushNamed(context, UserDetailsScreen.routeName);
      } else if (vendorDetailsProvider
              .vendorDetailsResponse.merchantInformations.registrationStatus ==
          'shopProfileCompleted') {
        Navigator.popAndPushNamed(context, HomeScreen.routeName);
      }
    } else {
      Navigator.popAndPushNamed(context, LoginScreen.routeName);
    }
  }
}
