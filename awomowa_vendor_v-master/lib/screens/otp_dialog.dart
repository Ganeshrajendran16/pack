import 'dart:async';

import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/widgets/loader_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPDialog extends StatefulWidget {
  final String mobileNumber;
  final String OTP;
  final Function onVerified;
  final Function onRetryClick;
  final bool isLoading;

  OTPDialog(
      {this.mobileNumber,
      this.OTP,
      this.onVerified,
      this.onRetryClick,
      this.isLoading = false});

  @override
  _OTPDialogState createState() => _OTPDialogState();
}

class _OTPDialogState extends State<OTPDialog> {
  TextEditingController pinController = TextEditingController();

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  Timer _timer;

  int _start = 5;
  bool isRetryClicked = false;

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
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                fontSize: 18.0, fontWeight: FontWeight.w800),
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
                                style: TextStyle(fontWeight: FontWeight.w800),
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
                          Text(
                            '${widget.OTP}',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w800),
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
                              Opacity(
                                opacity: isRetryClicked ? 0.0 : 1.0,
                                child: InkWell(
                                  onTap: () async {
                                    if (_start == 0) {
                                      widget.onRetryClick();
                                      isRetryClicked = true;
                                      setState(() {});
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
                              SizedBox(
                                height: 24.0,
                                width: 24.0,
                                child: Visibility(
                                    visible: isRetryClicked,
                                    child: CircularProgressIndicator()),
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
                                    isLoading: widget.isLoading,
                                    onPressed: () {
                                      if (pinController.text == widget.OTP) {
                                        widget.onVerified();
                                      } else {
                                        errorController
                                            .add(ErrorAnimationType.shake);
                                      }
                                    },
                                    btnTxt: 'Verify & Proceed',
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: LoaderButton(
                                    isLoading: false,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    btnTxt: 'Cancel',
                                  ),
                                ),
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
  }
}
