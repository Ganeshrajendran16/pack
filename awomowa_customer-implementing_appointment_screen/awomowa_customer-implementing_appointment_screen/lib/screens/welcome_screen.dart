import 'package:animated_background/animated_background.dart';
import 'package:awomowa/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = 'welcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(
            behaviour: RacingLinesBehaviour(),
            vsync: this,
            child: Text('Hello'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/sign_up_success.svg',
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                SizedBox(
                  height: 24.0,
                ),
                Text(
                  'Account created Successfully !',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'Explore all the hidden Offers and Updates now',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
                ),
                SizedBox(
                  height: 56.0,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: AppTheme.themeColor),
                        onPressed: () {
                          Navigator.popAndPushNamed(
                              context, HomeScreen.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            'Proceed',
                            style: TextStyle(
                                color: AppTheme.textBlack,
                                fontWeight: FontWeight.w700),
                          ),
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
