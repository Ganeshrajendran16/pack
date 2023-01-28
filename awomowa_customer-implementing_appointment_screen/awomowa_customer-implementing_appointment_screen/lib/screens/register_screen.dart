import 'package:awomowa/app/theme.dart';
import 'package:awomowa/model/SignUpProvider.dart';
import 'package:awomowa/screens/error_screen.dart';
import 'package:awomowa/screens/privacy_policy_dialog.dart';
import 'package:awomowa/screens/sign_up_otp_dialog.dart';
import 'package:awomowa/screens/welcome_screen.dart';
import 'package:awomowa/utils/SharedPreferences.dart';
import 'package:awomowa/widgets/genderSelector.dart';
import 'package:awomowa/widgets/loader_button.dart';
import 'package:awomowa/widgets/register_screen_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<bool> selectedGender = [false, false, false];
  TextEditingController nameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController mailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isDialogOpen = false;
  bool isTermsAndConditionsAgreed = false;
  String _getGender() {
    if (selectedGender[0] == true) {
      return 'Male';
    } else if (selectedGender[1] == true) {
      return 'Female';
    } else if (selectedGender[2] == true) {
      return 'Others';
    }
    return null;
  }

  void setGender(String gender) {
    if (gender == 'Male') {
      selectedGender = [true, false, false];
    } else if (gender == 'Female') {
      selectedGender = [false, true, false];
    } else if (gender == 'Others') {
      selectedGender = [false, false, true];
    }

    print('changed');
    setState(() {});
  }

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
          backgroundColor: AppTheme.themeColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Stack(
                    children: [
                      RegisterScreenBg(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SafeArea(
                                child: Align(
                                  alignment: Alignment.topLeft,
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
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.chevron_left,
                                            color: AppTheme.themeColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 24.0,
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Create',
                                  style: TextStyle(
                                      color: AppTheme.textBlack,
                                      fontSize: 38.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Account',
                                  style: TextStyle(
                                      color: AppTheme.textBlack,
                                      fontSize: 38.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(38.0),
                          topRight: Radius.circular(38.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 32.0,
                            ),
                            LoginFormField(
                              hint: 'Name',
                              textCapitalization: TextCapitalization.words,
                              prefixIcon: Icons.person,
                              controller: nameController,
                              validator: (value) {
                                if (value.length < 4) {
                                  return 'Name must be at least 3 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                GenderSelector(
                                  label: 'Male',
                                  icon: Icon(
                                    FontAwesome.mars,
                                    color: Colors.blue,
                                  ),
                                  isSelected: selectedGender[0],
                                  onTap: () => setGender('Male'),
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                GenderSelector(
                                  label: 'Female',
                                  icon: Icon(
                                    FontAwesome.venus,
                                    color: Colors.pink,
                                  ),
                                  isSelected: selectedGender[1],
                                  onTap: () => setGender('Female'),
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                GenderSelector(
                                  label: 'Others',
                                  icon: Icon(
                                    FontAwesome.transgender,
                                    color: Colors.green,
                                  ),
                                  isSelected: selectedGender[2],
                                  onTap: () => setGender('Others'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                            LoginFormField(
                              hint: 'Date of birth',
                              prefixIcon: FontAwesome.calendar,
                              controller: dateOfBirthController,
                              isDateOfBirth: true,
                              validator: (value) {
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                            LoginFormField(
                              hint: 'Mobile Number',
                              prefixIcon: FontAwesome.mobile_phone,
                              isMobile: true,
                              controller: mobileNumberController,
                              validator: (value) {
                                if (value.length < 10) {
                                  return 'Please enter valid mobile number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                            LoginFormField(
                              hint: 'Email',
                              prefixIcon: Icons.mail,
                              textCapitalization: TextCapitalization.none,
                              inputType: TextInputType.emailAddress,
                              controller: mailIdController,
                              validator: (value) {
                                if (RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return null;
                                } else {
                                  return 'Please enter valid email';
                                }
                              },
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                            LoginFormField(
                              hint: 'Password',
                              prefixIcon: Icons.vpn_key,
                              isPassword: true,
                              inputType: TextInputType.emailAddress,
                              controller: passwordController,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value.length < 8) {
                                  return 'Password must be at least 8 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                            LoginFormField(
                              hint: 'Confirm Password',
                              prefixIcon: Icons.vpn_key,
                              isConfirmPass: true,
                              inputType: TextInputType.emailAddress,
                              controller: confirmPassController,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value.length < 8) {
                                  return 'Password must be at least 8 characters';
                                } else if (confirmPassController.text !=
                                    passwordController.text) {
                                  return 'Password & Confirm Password not matching';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 56.0,
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
                            LoaderButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  if (isTermsAndConditionsAgreed) {
                                    requestOtp(signUpProvider);
                                  } else {
                                    showSnackBar(
                                        'Please Accept Terms and Conditions');
                                  }
                                }
                              },
                              isLoading: signUpProvider.isLoading,
                              btnTxt: 'Sign up',
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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

  void requestOtp(SignUpProvider signUpProvider) async {
    await signUpProvider.requestOtp(nameController.text,
        mobileNumberController.text, mailIdController.text);

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
                await signUpProvider.requestOtp(nameController.text,
                    mobileNumberController.text, mailIdController.text);
              },
            );
          }).then((value) {
        // isDialogOpen = false;
      });
    } else {
      showSnackBar(signUpProvider.requestOtpResponse['message']);
    }
  }

  Future<void> signUp(SignUpProvider signUpProvider) async {
    await signUpProvider.signUp(
        nameController.text,
        mobileNumberController.text,
        mailIdController.text,
        _getGender(),
        dateOfBirthController.text,
        passwordController.text,
        confirmPassController.text,
        signUpProvider.requestOtpResponse['otp']);

    if (signUpProvider.isError) {
      Navigator.pushNamed(context, NoInternet.routeName);
      return;
    }

    if (signUpProvider.signUpResponse['status'] == 'success') {
      SharedPrefManager prefManger = SharedPrefManager();
      await prefManger.setAuthKey(
          signUpProvider.signUpResponse['userInformations']['authKey']);
      await prefManger.setUsername(nameController.text);
      await prefManger.setGender(_getGender());
      await prefManger.setDob(dateOfBirthController.text);
      await prefManger.setEmail(mailIdController.text);
      await prefManger.setMobile(mobileNumberController.text);
      await prefManger.setLoggedIn(true);
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => WelcomeScreen(),
        ),
        (route) => false, //if you want to disable back feature set to false
      );
    } else {
      showSnackBar(signUpProvider.signUpResponse['message']);
    }
  }
}
