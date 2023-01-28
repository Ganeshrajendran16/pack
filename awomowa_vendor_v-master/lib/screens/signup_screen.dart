import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/providers/ActiveOfferListProvider.dart';
import 'package:awomowa_vendor/providers/ManageOffersProvider.dart';
import 'package:awomowa_vendor/providers/SignUpProvider.dart';
import 'package:awomowa_vendor/providers/VendorDetailsProvider.dart';
import 'package:awomowa_vendor/screens/approval_screen.dart';
import 'package:awomowa_vendor/screens/error_screen.dart';
import 'package:awomowa_vendor/screens/privacy_policy_dialog.dart';
import 'package:awomowa_vendor/screens/sign_up_otp_dialog.dart';
import 'package:awomowa_vendor/utils/SharedPreferences.dart';
import 'package:awomowa_vendor/widgets/drop_down_button.dart';
import 'package:awomowa_vendor/widgets/form_field.dart';
import 'package:awomowa_vendor/widgets/loader_button.dart';
import 'package:awomowa_vendor/widgets/login_screen_bg.dart';
import 'package:awomowa_vendor/widgets/logo_upload_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'signUpScreen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isDialogOpen = false;
  final _formKey = GlobalKey<FormState>();
  LogoUploadForm logoUploadForm = LogoUploadForm();
  int selectedCategoryIndex;
  int selectedSubCategoryIndex;
  bool isTermsAndConditionsAgreed = false;
  showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder:
          (BuildContext context, SignUpProvider signUpProvider, Widget child) {
        return Scaffold(
          body: signUpProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        color: AppTheme.themeColor,
                        child: Stack(
                          children: [
                            LoginScreenBg(),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        'Create Account',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 24.0),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 16.0,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Shop Details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.0),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                logoUploadForm,
                                SizedBox(
                                  height: 32.0,
                                ),
                                GlobalFormField(
                                    hint: 'Shop Name',
                                    prefixIcon: Icons.shopping_bag_outlined,
                                    controller: shopNameController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    validator: (value) {
                                      if (value.length < 3) {
                                        return 'Enter Valid Shop Name';
                                      }
                                      return null;
                                    }),
                                SizedBox(
                                  height: 16.0,
                                ),
                                GlobalFormField(
                                    hint: 'Mobile Number',
                                    prefixIcon: Icons.phone,
                                    isMobile: true,
                                    controller: mobileNumberController,
                                    validator: (value) {
                                      if (value.length < 10) {
                                        return 'Enter Valid Mobile Number';
                                      }
                                      return null;
                                    }),
                                SizedBox(
                                  height: 16.0,
                                ),
                                GlobalFormField(
                                  hint: 'Email',
                                  prefixIcon: Icons.mail,
                                  controller: emailController,
                                  inputType: TextInputType.emailAddress,
                                  textCapitalization: TextCapitalization.none,
                                  validator: (value) {
                                    if (RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                      return null;
                                    } else {
                                      return 'Enter Valid Email';
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                GlobalDropDownButton(
                                  prefixIcon: Icons.list,
                                  hint: 'Category',
                                  items: signUpProvider
                                      .categoryListResponse.categoryList
                                      .map((e) => e.categoryName)
                                      .toList(),
                                  onChanged: (int index) {
                                    setState(() {
                                      selectedCategoryIndex = index;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Select Valid Category';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                GlobalDropDownButton(
                                  prefixIcon: Icons.list,
                                  hint: 'Sub Category',
                                  items: selectedCategoryIndex == null
                                      ? []
                                      : signUpProvider
                                          .categoryListResponse
                                          .categoryList[selectedCategoryIndex]
                                          .subCategories
                                          .map((e) => e.subCategoryName)
                                          .toList(),
                                  onChanged: (int index) {
                                    setState(() {
                                      selectedSubCategoryIndex = index;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Select Valid Sub-Category';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                GlobalFormField(
                                  hint: 'Password',
                                  prefixIcon: Icons.vpn_key,
                                  isPassword: true,
                                  textCapitalization: TextCapitalization.none,
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value.length < 8) {
                                      return 'Password Must Be At Least 8 Characters';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                GlobalFormField(
                                  hint: 'Confirm Password',
                                  prefixIcon: Icons.vpn_key,
                                  isConfirmPass: true,
                                  controller: confirmPasswordController,
                                  textCapitalization: TextCapitalization.none,
                                  validator: (value) {
                                    if (value.length < 8) {
                                      return 'Confirm Password Must Be At Least 8 Characters';
                                    } else if (confirmPasswordController.text !=
                                        passwordController.text) {
                                      return 'Password & Confirm Password Not Matching';
                                    }
                                    return null;
                                  },
                                ),
                                CheckboxListTile(
                                  value: isTermsAndConditionsAgreed,
                                  onChanged: (sd) {
                                    isTermsAndConditionsAgreed =
                                        !isTermsAndConditionsAgreed;
                                    setState(() {});
                                  },
                                  title: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return PrivacyPolicyDialog();
                                        },
                                      );
                                    },
                                    child: Text(
                                      'I Agree to the terms and conditions',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 48.0,
                                ),
                                Column(
                                  children: [
                                    LoaderButton(
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          if (logoUploadForm.getShopLogo ==
                                              null) {
                                            showSnackBar(
                                                'Please Upload Shop Logo');
                                          } else {
                                            if (isTermsAndConditionsAgreed) {
                                              requestOtp(signUpProvider);
                                            } else {
                                              showSnackBar(
                                                  'Please Accept Terms and Conditions');
                                            }
                                          }
                                        } else {
                                          showSnackBar('Enter Valid Details !');
                                        }
                                      },
                                      btnTxt: 'Sign Up',
                                      isLoading: false,
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Already have an account?',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            ' Sign In',
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
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }

  Future<void> requestOtp(SignUpProvider signUpProvider) async {
    await signUpProvider.requestOtp(shopNameController.text,
        mobileNumberController.text, emailController.text);

    if (signUpProvider.isError) {
      Navigator.pushNamed(context, NoInternet.routeName);
      return;
    }

    if (signUpProvider.requestOtpResponse['status'] == 'success') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SignUpOTPDialog(
              mobileNumber: mobileNumberController.text,
              onVerified: () {
                // Navigator.pop(context);

                signUp(signUpProvider);
              },
              onRetryClick: () async {
                await signUpProvider.requestOtp(shopNameController.text,
                    mobileNumberController.text, emailController.text);
              },
            );
          }).then((value) {});
    } else {
      showSnackBar(signUpProvider.requestOtpResponse['message']);
    }
  }

  Future<void> signUp(SignUpProvider signUpProvider) async {
    await signUpProvider.signUp(
        shopNameController.text,
        mobileNumberController.text,
        emailController.text,
        passwordController.text,
        confirmPasswordController.text,
        logoUploadForm.getShopLogo,
        selectedCategoryIndex,
        selectedSubCategoryIndex);

    if (signUpProvider.isError) {
      Navigator.pushNamed(context, NoInternet.routeName);
      return;
    }

    if (signUpProvider.signUpResponse['status'] == 'success') {
      SharedPrefManager prefManger = SharedPrefManager();
      await prefManger.setAuthKey(signUpProvider.signUpResponse['authKey']);
      await prefManger.setEmail(emailController.text);
      await prefManger.setMobile(mobileNumberController.text);

      Provider.of<ActiveOfferListProvider>(context, listen: false)
          .getOfferList();

      Provider.of<VendorDetailsProvider>(context, listen: false)
          .getVendorDetails();
      Provider.of<ManageOffersProvider>(context, listen: false).getOfferList();
      // Navigator.pushAndRemoveUntil<dynamic>(
      //   context,
      //   MaterialPageRoute<dynamic>(
      //     builder: (BuildContext context) => PackageScreen(isFromSignUp: true,),
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
    } else {
      showSnackBar(signUpProvider.signUpResponse['message']);
    }
  }
}
