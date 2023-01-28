import 'package:awomowa/app/theme.dart';
import 'package:awomowa/screens/login_screen.dart';
import 'package:awomowa/widgets/loader_button.dart';
import 'package:flutter/material.dart';

class NickNameDialog extends StatelessWidget {
  final Function onPressed;
  final String shopName;

  NickNameDialog({this.onPressed, this.shopName});

  final _formKey = GlobalKey<FormState>();

  TextEditingController nickNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nickNameController.text = shopName;

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
                        'Nick Name',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LoginFormField(
                    hint: 'Nick name',
                    prefixIcon: Icons.date_range,
                    controller: nickNameController,
                    validator: (value) {
                      if (value.length < 3) {
                        return 'Enter valid nick name';
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
                  child: Row(
                    children: [
                      Expanded(
                        child: LoaderButton(
                          btnTxt: 'Proceed',
                          isLoading: false,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              onPressed(nickNameController.text);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        child: LoaderButton(
                          btnTxt: 'Skip',
                          isLoading: false,
                          onPressed: () {
                            onPressed(shopName);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
