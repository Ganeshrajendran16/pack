import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/providers/ActiveOfferListProvider.dart';
import 'package:awomowa_vendor/providers/LoginProvider.dart';
import 'package:awomowa_vendor/providers/ManageOffersProvider.dart';
import 'package:awomowa_vendor/providers/VendorDetailsProvider.dart';
import 'package:awomowa_vendor/screens/approval_screen.dart';
import 'package:awomowa_vendor/screens/error_screen.dart';
import 'package:awomowa_vendor/screens/home_screen.dart';
import 'package:awomowa_vendor/screens/signup_screen.dart';
import 'package:awomowa_vendor/screens/user_register_screen.dart';
import 'package:awomowa_vendor/utils/SharedPreferences.dart';
import 'package:awomowa_vendor/widgets/form_field.dart';
import 'package:awomowa_vendor/widgets/loader_button.dart';
import 'package:awomowa_vendor/widgets/login_screen_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = 'loginScreen';
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder:
          (BuildContext context, LoginProvider loginProvider, Widget child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    color: AppTheme.themeColor,
                    child: Stack(
                      children: [
                        LoginScreenBg(),
                        SafeArea(
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  'Awomowa',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 24.0),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '-Let us grow together-',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.0),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Vendor Application',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0),
                                ),
                              ),
                              Expanded(
                                child: SvgPicture.asset(
                                  'assets/shop_illus.svg',
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Get your business Online !',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.0),
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 24.0),
                            ),
                          ),
                          Spacer(
                            flex: 3,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 32.0,
                                ),
                                GlobalFormField(
                                  hint: 'Mobile',
                                  prefixIcon: Icons.phone_android,
                                  controller: mobileNumberController,
                                  isMobile: true,
                                  validator: (value) {
                                    if (value.length < 10) {
                                      return 'Please Enter Valid Mobile Number';
                                    }

                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 24.0,
                                ),
                                GlobalFormField(
                                  hint: 'Password',
                                  prefixIcon: Icons.vpn_key,
                                  controller: passwordController,
                                  isPassword: true,
                                  validator: (value) {
                                    if (value.length < 8) {
                                      return 'Please Enter Valid Password';
                                    }

                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          ForgotPasswordScreen.routeName);
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                          color: AppTheme.themeColor,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(
                            flex: 8,
                          ),
                          Column(
                            children: [
                              LoaderButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    signIn(loginProvider, context);
                                  }
                                },
                                btnTxt: 'Sign in',
                                isLoading: loginProvider.isLoading,
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don\'t have an account?',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, SignUpScreen.routeName);
                                    },
                                    child: Text(
                                      ' Sign Up',
                                      style: TextStyle(
                                          color: AppTheme.themeColor,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void signIn(LoginProvider loginProvider, BuildContext context) async {
    await loginProvider.signIn(
        mobileNumberController.text, passwordController.text);

    if (loginProvider.isError) {
      Navigator.pushNamed(context, NoInternet.routeName);
      return;
    }

    if (loginProvider.loginResponse.status == 'success') {
      SharedPrefManager prefManger = SharedPrefManager();

      if (loginProvider.loginResponse.merchantInformations.registrationStatus ==
          'registrationCompleted') {
        await prefManger.setShopCategory(
            loginProvider.loginResponse.merchantInformations.shopCategoryName);
        await prefManger.setShopLogo(
            loginProvider.loginResponse.merchantInformations.shopLogo);
        await prefManger.setShopName(
            loginProvider.loginResponse.merchantInformations.shopName);
        await prefManger.setAuthKey(
            loginProvider.loginResponse.merchantInformations.authKey);
        // Navigator.pushAndRemoveUntil<dynamic>(
        //   context,
        //   MaterialPageRoute<dynamic>(
        //     builder: (BuildContext context) => PackageScreen(
        //       isFromSignUp: true,
        //     ),
        //   ),
        //   (route) => false, //if you want to disable back feature set to false
        // );

        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => ApprovalScreen(),
          ),
          (route) => false, //if you want to disable back feature set to false
        );
      } else if (loginProvider
              .loginResponse.merchantInformations.registrationStatus ==
          'adminApprovalCompleted') {
        print('ssdsd');
        await prefManger.setShopCategory(
            loginProvider.loginResponse.merchantInformations.shopCategoryName);
        await prefManger.setShopLogo(
            loginProvider.loginResponse.merchantInformations.shopLogo);
        await prefManger.setShopName(
            loginProvider.loginResponse.merchantInformations.shopName);
        await prefManger.setAuthKey(
            loginProvider.loginResponse.merchantInformations.authKey);
        Navigator.popAndPushNamed(context, UserDetailsScreen.routeName);
      } else if (loginProvider
              .loginResponse.merchantInformations.registrationStatus ==
          'shopProfileCompleted') {
        await prefManger.setShopName(
            loginProvider.loginResponse.merchantInformations.shopName);
        await prefManger.setAuthKey(
            loginProvider.loginResponse.merchantInformations.authKey);
        await prefManger.setShopCategory(
            loginProvider.loginResponse.merchantInformations.shopCategoryName);
        await prefManger.setShopLogo(
            loginProvider.loginResponse.merchantInformations.shopLogo);

        Provider.of<ActiveOfferListProvider>(context, listen: false)
            .getOfferList();
        Provider.of<ManageOffersProvider>(context, listen: false)
            .getOfferList();

        Provider.of<VendorDetailsProvider>(context, listen: false)
            .getVendorDetails();

        Navigator.popAndPushNamed(context, HomeScreen.routeName);
      } else if (loginProvider
              .loginResponse.merchantInformations.registrationStatus ==
          'adminDeclined') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => ApprovalScreen(isDeclined: true),
          ),
        );
      }
    } else {
      showSnackBar(loginProvider.loginResponse.message, context);
    }
  }
}
