import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/providers/EditOfferProvider.dart';
import 'package:awomowa_vendor/widgets/form_field.dart';
import 'package:awomowa_vendor/widgets/loader_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RepublishDialog extends StatelessWidget {
  TextEditingController expiryDateController = TextEditingController();

  final Function onPressed;

  RepublishDialog({this.onPressed});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<EditOfferProvider>(
      builder: (BuildContext context, EditOfferProvider editOfferProvider,
          Widget child) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), //this right here
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      color: AppTheme.themeColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Enter new expiry date',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GlobalFormField(
                        hint: 'Offer Expiry date',
                        prefixIcon: Icons.date_range,
                        inputType: TextInputType.number,
                        isExpiryDate: true,
                        controller: expiryDateController,
                        validator: (value) {
                          if (value.length < 3) {
                            return 'Enter valid expiry date';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LoaderButton(
                        btnTxt: 'Re-publish',
                        isLoading: editOfferProvider.isLoading,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            onPressed(expiryDateController.text);
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
