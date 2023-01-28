import 'package:awomowa/model/ForgotPasswordProvider.dart';
import 'package:awomowa/widgets/loader_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const routeName = 'ResetPassword';

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordProvider>(
      builder: (BuildContext context,
          ForgotPasswordProvider forgotPasswordProvider, Widget child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Center(
                      child: SvgPicture.asset(
                        'assets/forgot_password_illus.svg',
                        height: 200.0,
                        width: 200.0,
                      ),
                    ),
                    Text(
                      'Reset Password',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Please enter Your new password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w300),
                    ),
                    Spacer(),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          LoginFormField(
                            hint: 'Password',
                            prefixIcon: Icons.vpn_key,
                            isPassword: true,
                            controller: passwordController,
                            inputType: TextInputType.emailAddress,
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
                        ],
                      ),
                    ),
                    Spacer(),
                    LoaderButton(
                      btnTxt: 'Reset Password',
                      isLoading: forgotPasswordProvider.isLoading,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          resetPassword(forgotPasswordProvider, context);
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

  Future<void> resetPassword(ForgotPasswordProvider forgotPasswordProvider,
      BuildContext context) async {
    await forgotPasswordProvider.resetPassword(
        passwordController.text, confirmPassController.text);

    if (forgotPasswordProvider.resetPasswordResponse['status'] == 'success') {
      Navigator.popUntil(context, ModalRoute.withName(LoginScreen.routeName));
      showSnackBar("Password has been reset Successfully !", context);
    } else {
      showSnackBar(
          forgotPasswordProvider.resetPasswordResponse['message'], context);
    }
  }
}
