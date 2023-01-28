import 'package:awomowa/app/theme.dart';
import 'package:awomowa/model/LoginProvider.dart';
import 'package:awomowa/screens/error_screen.dart';
import 'package:awomowa/screens/forgot_password_screen.dart';
import 'package:awomowa/screens/home_screen.dart';
import 'package:awomowa/screens/register_screen.dart';
import 'package:awomowa/utils/SharedPreferences.dart';
import 'package:awomowa/widgets/loader_button.dart';
import 'package:awomowa/widgets/login_screen_bg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
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
          backgroundColor: AppTheme.themeColor,
          body: Column(
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    LoginScreenBg(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
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
                          Spacer(),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Welcome',
                              style: TextStyle(
                                  color: AppTheme.textBlack,
                                  fontSize: 42.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Back !',
                              style: TextStyle(
                                  color: AppTheme.textBlack,
                                  fontSize: 42.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(38.0),
                          topRight: Radius.circular(38.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 32.0,
                              ),
                              LoginFormField(
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
                              LoginFormField(
                                hint: 'Password',
                                prefixIcon: Icons.vpn_key,
                                controller: passwordController,
                                inputType: TextInputType.visiblePassword,
                                textCapitalization: TextCapitalization.none,
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
                                          context, RegisterScreen.routeName);
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
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> signIn(LoginProvider loginProvider, BuildContext context) async {
    await loginProvider.signIn(
        mobileNumberController.text, passwordController.text);

    if (loginProvider.isError) {
      Navigator.pushNamed(context, NoInternet.routeName);
      return;
    }

    if (loginProvider.loginResponse.status == 'success') {
      SharedPrefManager prefManger = SharedPrefManager();
      prefManger
          .setAuthKey(loginProvider.loginResponse.userInformations.authKey);
      prefManger
          .setUsername(loginProvider.loginResponse.userInformations.firstName);
      prefManger.setLoggedIn(true);
      prefManger.setGender(loginProvider.loginResponse.userInformations.gender);
      prefManger.setDob(loginProvider.loginResponse.userInformations.dob);
      prefManger.setEmail(loginProvider.loginResponse.userInformations.mailId);
      prefManger.setMobile(
          loginProvider.loginResponse.userInformations.contactNumber);
      Navigator.pushNamedAndRemoveUntil<dynamic>(
        context,
        HomeScreen.routeName,
        (route) => false, //if you want to disable back feature set to false
      );
    } else {
      showSnackBar(loginProvider.loginResponse.message, context);
    }
  }
}

class LoginFormField extends StatefulWidget {
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final Function validator;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool isAge;
  final bool isMobile;
  final bool isConfirmPass;
  final bool isDateOfBirth;
  final bool isEnabled;
  final TextCapitalization textCapitalization;

  LoginFormField(
      {this.hint,
      this.prefixIcon,
      this.isPassword = false,
      this.validator,
      this.controller,
      this.isAge = false,
      this.isMobile = false,
      this.isConfirmPass = false,
      this.inputType,
      this.isDateOfBirth = false,
      this.isEnabled = true,
      this.textCapitalization = TextCapitalization.sentences});

  @override
  _LoginFormFieldState createState() => _LoginFormFieldState();
}

class _LoginFormFieldState extends State<LoginFormField> {
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.isEnabled,
      textCapitalization: widget.textCapitalization,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTap: () async {
        if (widget.isDateOfBirth) {
          DateTime date = DateTime(1900);
          FocusScope.of(context).requestFocus(new FocusNode());

          date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1920),
              lastDate: DateTime.now());
          final DateFormat formatter = DateFormat('MM/dd/yyyy');
          widget.controller.text = formatter.format(date);
        }
      },
      // style: TextStyle(color: MediaQuery.of(context).platformBrightness == Brightness.da),
      keyboardType: widget.isMobile ? TextInputType.number : widget.inputType,
      maxLength: widget.isAge
          ? 2
          : widget.isMobile
              ? 10
              : null,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.0),
          counterText: "",
          labelText: widget.hint,
          fillColor: Colors.grey,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: Colors.grey)),
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(
            widget.prefixIcon,
          ),
          prefixText: widget.isMobile ? '+1' : null,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: AppTheme.themeColor,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : null),
      obscureText: widget.isPassword
          ? !_passwordVisible
          : widget.isConfirmPass
              ? true
              : false,
      validator: widget.validator,
    );
  }
}
