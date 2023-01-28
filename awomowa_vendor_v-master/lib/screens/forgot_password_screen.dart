import 'package:awomowa_vendor/providers/ForgotPasswordProvider.dart';
import 'package:awomowa_vendor/screens/forgot_password_otp_dialog.dart';
import 'package:awomowa_vendor/screens/reset_password_screen.dart';
import 'package:awomowa_vendor/widgets/form_field.dart';
import 'package:awomowa_vendor/widgets/loader_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'error_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = 'forgotPassword';
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController mobileNumberController = TextEditingController();
  showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordProvider>(
      builder: (BuildContext context,
          ForgotPasswordProvider forgotPasswordProvider, Widget child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: 100.h,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 18.0,
                    ),
                    Center(
                      child: SvgPicture.asset(
                        'assets/forgot_password_illus.svg',
                        height: 250.0,
                        width: 250.0,
                      ),
                    ),
                    Text(
                      'Forgot Your Password ?',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    Text(
                      'Enter your registered phone number below to receive your OTP for resetting your password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w300),
                    ),
                    Spacer(),
                    GlobalFormField(
                      controller: mobileNumberController,
                      hint: 'Mobile',
                      prefixIcon: Icons.phone_android,
                      isMobile: true,
                    ),
                    Spacer(),
                    LoaderButton(
                      btnTxt: 'Send OTP',
                      isLoading: forgotPasswordProvider.isLoading,
                      onPressed: () {
                        if (mobileNumberController.text.length < 10) {
                          showSnackBar('Please Enter Valid Mobile Number !');
                        } else {
                          requestOtp(forgotPasswordProvider);
                        }
                      },
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Back to Login',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> requestOtp(ForgotPasswordProvider forgotPasswordProvider) async {
    await forgotPasswordProvider.requestOtp(mobileNumberController.text);
    if (forgotPasswordProvider.isError) {
      Navigator.pushNamed(context, NoInternet.routeName);
      return;
    }

    if (forgotPasswordProvider.requestOtpResponse['status'] == 'success') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ForgotPasswordOTPDialog(
              mobileNumber: mobileNumberController.text,
              onVerified: () {
                Navigator.pop(context);
                Navigator.popAndPushNamed(
                    context, ResetPasswordScreen.routeName);
              },
              onRetryClick: () async {
                await forgotPasswordProvider
                    .requestOtp(mobileNumberController.text);
              },
            );
          }).then((value) {});
    } else {
      showSnackBar(forgotPasswordProvider.requestOtpResponse['message']);
    }
  }
}
