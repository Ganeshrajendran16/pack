import 'package:awomowa_vendor/providers/PackageDetailsProvider.dart';
import 'package:awomowa_vendor/widgets/form_field.dart';
import 'package:awomowa_vendor/widgets/loader_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class CouponCodeSheet extends StatefulWidget {
  @override
  _CouponCodeSheetState createState() => _CouponCodeSheetState();
}

class _CouponCodeSheetState extends State<CouponCodeSheet> {
  final TextEditingController couponCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(behavior: SnackBarBehavior.floating, content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PackageDetailsProvider>(builder: (BuildContext context,
        PackageDetailsProvider packageDetailsProvider, Widget child) {
      return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(24.0),
                  topRight: const Radius.circular(24.0))),
          child: packageDetailsProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : (packageDetailsProvider.couponCodeResponse.isEmpty)
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter Coupon Code',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20.0),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 24.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Form(
                                  key: _formKey,
                                  child: GlobalFormField(
                                      hint: 'Coupon Code',
                                      prefixIcon: FontAwesome5.file_code,
                                      controller: couponCodeController,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      validator: (value) {
                                        if (value.length < 3) {
                                          return 'Enter Coupon Code';
                                        }
                                        return null;
                                      }),
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Expanded(
                                flex: 3,
                                child: LoaderButton(
                                    btnTxt: 'Apply',
                                    isLoading: packageDetailsProvider.isLoading,
                                    onPressed: () async {
                                      await packageDetailsProvider
                                          .verifyCouponCode(
                                              packageDetailsProvider
                                                  .packageDetailsResponse
                                                  .packageInforamtion[0]
                                                  .packageAmount,
                                              couponCodeController.text);
                                      if (packageDetailsProvider
                                              .couponCodeResponse["status"] ==
                                          'success') {
                                      } else {
                                        showSnackBar(packageDetailsProvider
                                            .couponCodeResponse["message"]);
                                      }
                                    }),
                              )
                            ],
                          ),
                          Spacer(),
                          SizedBox(
                            height: 24.0,
                          ),
                        ],
                      ),
                    )
                  : (packageDetailsProvider.couponCodeResponse['status'] ==
                          'success')
                      ? Container(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Spacer(),
                                Center(
                                  child: Image.asset(
                                    'assets/confetti.png',
                                    height: 100.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 18.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 32.0,
                                    ),
                                    Text(
                                      'Coupon Code ${couponCodeController.text} Applied',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${packageDetailsProvider.couponCodeResponse['displayContent']}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      'Package Amount',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Spacer(),
                                    Text(
                                      '\$ ${packageDetailsProvider.packageDetailsResponse.packageInforamtion[0].packageAmount}',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Text(
                                      'Coupon',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Spacer(),
                                    Text(
                                      '- \$ ${packageDetailsProvider.couponCodeResponse['discountAmount']}',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Text(
                                      'Discounted amount',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Spacer(),
                                    Text(
                                      '\$ ${packageDetailsProvider.couponCodeResponse['responseAmount']}',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 24.0,
                                ),
                                LoaderButton(
                                  btnTxt: 'Activate Now',
                                  onPressed: () {
                                    couponCodeController.text = '';
                                    packageDetailsProvider
                                        .resetCouponResponse();
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Spacer(),
                                Icon(
                                  Icons.warning_amber_outlined,
                                  size: 60.0,
                                  color: Colors.red,
                                ),
                                Text(
                                  'Invalid Coupon Code',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Spacer(),
                                LoaderButton(
                                  btnTxt: 'Try Again',
                                  onPressed: () {
                                    couponCodeController.text = '';
                                    packageDetailsProvider
                                        .resetCouponResponse();
                                  },
                                )
                              ],
                            ),
                          ),
                        ));
    });
  }
}
