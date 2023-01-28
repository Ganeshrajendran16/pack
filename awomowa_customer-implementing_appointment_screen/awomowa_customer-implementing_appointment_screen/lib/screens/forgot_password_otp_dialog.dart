import 'dart:async';

import 'package:awomowa/app/theme.dart';
import 'package:awomowa/model/ForgotPasswordProvider.dart';
import 'package:awomowa/widgets/loader_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class ForgotPasswordOTPDialog extends StatefulWidget {
  final String mobileNumber;
  final Function onVerified;
  final Function onRetryClick;

  ForgotPasswordOTPDialog(
      {this.mobileNumber, this.onVerified, this.onRetryClick});

  @override
  _ForgotPasswordOTPDialogState createState() =>
      _ForgotPasswordOTPDialogState();
}

class _ForgotPasswordOTPDialogState extends State<ForgotPasswordOTPDialog> {
  TextEditingController pinController = TextEditingController();

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  Timer _timer;

  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordProvider>(
      builder: (BuildContext context,
          ForgotPasswordProvider forgotPasswordProvider, Widget child) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Material(
              color: Colors.transparent,
              child: Container(
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(16.0)),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/otp_illus.svg',
                                width: 250.0,
                                height: 250.0,
                              ),
                              Text(
                                'OTP Verification',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Enter OTP code sent to',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    '+1 ${widget.mobileNumber}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 24.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(36.0),
                                child: PinCodeTextField(
                                  length: 5,
                                  controller: pinController,
                                  animationType: AnimationType.fade,
                                  onChanged: (String value) {},
                                  appContext: context,
                                  enableActiveFill: true,
                                  keyboardType: TextInputType.number,
                                  errorAnimationController: errorController,
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 50,
                                    fieldWidth: 40,
                                    activeColor: AppTheme.themeColor,
                                    inactiveColor: AppTheme.themeColor,
                                    selectedColor: Colors.green,
                                    selectedFillColor:
                                        AppTheme.themeColor.withOpacity(0.2),
                                    inactiveFillColor:
                                        AppTheme.themeColor.withOpacity(0.2),
                                    activeFillColor:
                                        AppTheme.themeColor.withOpacity(0.2),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: false,
                                child: Text(
                                  '${forgotPasswordProvider.requestOtpResponse['forgotOtp']}',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              SizedBox(
                                height: 24.0,
                              ),
                              Text(
                                'Didn\'t recieve OTP code?',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Stack(
                                children: [
                                  Visibility(
                                      visible: forgotPasswordProvider.isLoading,
                                      child: SizedBox(
                                        width: 24.0,
                                        height: 24.0,
                                        child: CircularProgressIndicator(),
                                      )),
                                  Opacity(
                                    opacity: forgotPasswordProvider.isLoading
                                        ? 0
                                        : 1,
                                    child: InkWell(
                                      onTap: () async {
                                        if (_start == 0) {
                                          await widget.onRetryClick();

                                          _start = 10;
                                          startTimer();
                                        }
                                      },
                                      child: Text(
                                        _start == 0
                                            ? 'Retry'
                                            : 'Retry in $_start seconds',
                                        style: TextStyle(
                                            color: _start == 0
                                                ? AppTheme.themeColor
                                                : null,
                                            decoration: _start == 0
                                                ? TextDecoration.underline
                                                : null,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 36.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: LoaderButton(
                                      onPressed: () {
                                        if (pinController.text ==
                                            forgotPasswordProvider
                                                    .requestOtpResponse[
                                                'forgotOtp']) {
                                          print('verified');
                                          widget.onVerified();
                                        } else {
                                          print('notverified');
                                          errorController
                                              .add(ErrorAnimationType.shake);
                                        }
                                      },
                                      btnTxt: 'Verify & Proceed',
                                    )),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Expanded(
                                        child: LoaderButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      btnTxt: 'Cancel',
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
