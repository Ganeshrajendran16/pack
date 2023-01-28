import 'dart:async';
import 'dart:ui';

import 'package:awomowa/app/theme.dart';
import 'package:awomowa/screens/register_screen.dart';
import 'package:awomowa/utils/SharedPreferences.dart';
import 'package:awomowa/widgets/splash_screen_bg.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _slideInController;
  Animation<Offset> _offsetAnimation;

  AnimationController _buttonsSlideInController;
  Animation<Offset> _buttonOffsetAnimation;

  double _opacity = 0;
  bool _value = true, _bgVisibility = false;

  @override
  void initState() {
    super.initState();

    _slideInController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, 2.0),
      end: const Offset(0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideInController,
      curve: Curves.fastLinearToSlowEaseIn,
    ));

    _buttonsSlideInController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _buttonOffsetAnimation = Tween<Offset>(
      begin: Offset(0, 2.0),
      end: const Offset(0, 0.0),
    ).animate(CurvedAnimation(
      parent: _buttonsSlideInController,
      curve: Curves.fastLinearToSlowEaseIn,
    ));

    Timer(Duration(milliseconds: 2000), () async {
      SharedPrefManager prefManger = SharedPrefManager();

      if (await prefManger.getLoggedIn()) {
        Navigator.pushNamedAndRemoveUntil<dynamic>(
          context,
          HomeScreen.routeName,
          (route) => false, //if you want to disable back feature set to false
        );
      } else {
        _slideInController.forward();
        Timer(Duration(milliseconds: 500), () {
          setState(() {
            _buttonsSlideInController.forward().whenComplete(() {
              _bgVisibility = true;
              setState(() {});
            });
          });
        });
      }
    });

    Timer(Duration(milliseconds: 600), () {
      setState(() {
        _opacity = 1.0;
        _value = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.themeColor,
      body: Stack(
        children: [
          SplashScreenBg(),
          Center(
            child: AnimatedOpacity(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(seconds: 6),
              opacity: _opacity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  AnimatedContainer(
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: Duration(seconds: 2),
                    height: _value ? 50 : 200,
                    width: _value ? 50 : 200,
                    child: Image.asset(
                      'assets/a_logo.png',
                      fit: BoxFit.fill,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(52),
                      // border: Border.all(color: Colors.green[900], width: 2.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green[800],
                          blurRadius: 150,
                          spreadRadius: 1,
                        ),
                      ],
                      // color: Colors.white,
                      //borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: AppTheme.textBlack),
                  ),
                  Spacer(),
                  SlideTransition(
                    position: _offsetAnimation,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Awomowa',
                              style: TextStyle(
                                  color: AppTheme.textBlack,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 28.0),
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          SlideTransition(
                            position: _buttonOffsetAnimation,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, LoginScreen.routeName);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            color: AppTheme.themeColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, RegisterScreen.routeName);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
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
        ],
      ),
    );
  }
}
