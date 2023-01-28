import 'package:avatar_glow/avatar_glow.dart';
import 'package:awomowa_vendor/app/theme.dart';
import 'package:awomowa_vendor/widgets/splash_screen_bg.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PublishSuccessScreen extends StatefulWidget {
  static const routeName = 'publishScreen';

  final bool isUpdate;

  const PublishSuccessScreen({this.isUpdate = false});

  @override
  _PublishSuccessScreenState createState() => _PublishSuccessScreenState();
}

class _PublishSuccessScreenState extends State<PublishSuccessScreen> {
  ConfettiController _confettiController;

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    _confettiController.play();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.themeColor,
      body: Stack(
        children: [
          SplashScreenBg(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Center(
                  child: AvatarGlow(
                    glowColor: Colors.green,
                    endRadius: 100.0,
                    duration: Duration(milliseconds: 2000),
                    repeat: true,
                    showTwoGlows: true,
                    repeatPauseDuration: Duration(milliseconds: 100),
                    child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: SvgPicture.asset(
                          'assets/offer_live.svg',
                          color: Colors.white,
                          height: 60,
                        ),
                        radius: 60.0,
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.isUpdate
                      ? 'Your update is now Published'
                      : 'Your offer is live now',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.0),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  widget.isUpdate
                      ? 'Your Customers will be notified about the update in the next few seconds. Send more updates and attract your customers.'
                      : 'Your Customers will be notified about the offer in the next few seconds. Send more offers and attract your customers.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Spacer(),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          int count = 0;
                          Navigator.of(context).popUntil((_) => count++ >= 2);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            'Proceed',
                            style: TextStyle(
                                color: AppTheme.themeColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ))),
                SizedBox(
                  height: 32.0,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality
                  .explosive, // don't specify a direction, blast randomly
              shouldLoop:
                  true, // start again as soon as the animation is finished
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ], // manually specify the colors to be used a custom shape/path.
            ),
          ),
        ],
      ),
    );
  }
}
