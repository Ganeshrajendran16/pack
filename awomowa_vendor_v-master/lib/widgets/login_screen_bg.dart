import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreenBg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            bottom: -100,
            right: -150.0,
            child: SvgPicture.asset(
              'assets/blob_1.svg',
              color: Color(0xffE0A500).withOpacity(0.5),
              height: 300.0,
              width: 300.0,
            )),
        Positioned(
            top: -150,
            left: -200.0,
            child: RotatedBox(
              quarterTurns: 2,
              child: SvgPicture.asset(
                'assets/outline_blob2.svg',
                color: Colors.grey.withOpacity(0.2),
                height: 350.0,
                width: 200.0,
                fit: BoxFit.fitHeight,
              ),
            )),
      ],
    );
  }
}
