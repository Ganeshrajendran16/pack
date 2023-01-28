import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreenBg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
              bottom: -80,
              right: -100.0,
              child: SvgPicture.asset(
                'assets/blob_1.svg',
                color: Color(0xffE0A500).withOpacity(0.5),
                height: 400.0,
                width: 400.0,
              )),
          Positioned(
              top: -80,
              left: -100.0,
              child: SvgPicture.asset(
                'assets/blob_2.svg',
                color: Color(0xffE0A500).withOpacity(0.5),
                height: 300.0,
                width: 300.0,
              )),
          Positioned(
              top: -150,
              right: -200.0,
              child: SvgPicture.asset(
                'assets/outline_blob2.svg',
                color: Colors.grey.withOpacity(0.2),
                height: 400.0,
                width: 200.0,
                fit: BoxFit.fitHeight,
              )),
          Positioned(
              bottom: 120.0,
              right: 60.0,
              child: Transform.rotate(
                angle: 0.5,
                child: SvgPicture.asset(
                  'assets/shopping-bag.svg',
                  color: Colors.grey.withOpacity(0.2),
                  height: 60.0,
                  width: 60.0,
                ),
              )),
          Positioned(
              top: 58,
              left: 36.0,
              child: Transform.rotate(
                angle: 50.0,
                child: SvgPicture.asset(
                  'assets/shop.svg',
                  color: Colors.grey.withOpacity(0.2),
                  height: 60.0,
                  width: 60.0,
                ),
              )),
          Positioned(
              top: 150,
              left: 16.0,
              child: Transform.rotate(
                angle: 50.0,
                child: SvgPicture.asset(
                  'assets/outline_blob.svg',
                  color: Colors.grey,
                  height: 24.0,
                  width: 24.0,
                ),
              )),
          Positioned(
              top: 100,
              left: 120.0,
              child: Transform.rotate(
                angle: 50.0,
                child: SvgPicture.asset(
                  'assets/outline_blob1.svg',
                  color: Colors.grey,
                  height: 24.0,
                  width: 24.0,
                ),
              )),
          Positioned(
              bottom: 150,
              right: 16.0,
              child: Transform.rotate(
                angle: 50.0,
                child: SvgPicture.asset(
                  'assets/outline_blob.svg',
                  color: Colors.grey,
                  height: 24.0,
                  width: 24.0,
                ),
              )),
          Positioned(
              bottom: 150,
              right: 150.0,
              child: Transform.rotate(
                angle: 50.0,
                child: SvgPicture.asset(
                  'assets/outline_blob1.svg',
                  color: Colors.grey,
                  height: 24.0,
                  width: 24.0,
                ),
              )),
          Positioned(
              top: 120,
              right: 100.0,
              child: Transform.rotate(
                angle: 50.0,
                child: SvgPicture.asset(
                  'assets/outline_blob.svg',
                  color: Colors.grey,
                  height: 36.0,
                  width: 36.0,
                ),
              )),
          Positioned(
              top: 60,
              right: 70.0,
              child: Transform.rotate(
                angle: 50.0,
                child: SvgPicture.asset(
                  'assets/outline_blob1.svg',
                  color: Colors.grey,
                  height: 24.0,
                  width: 24.0,
                ),
              )),
          Positioned(
              top: 160,
              right: 30.0,
              child: Transform.rotate(
                angle: 50.0,
                child: SvgPicture.asset(
                  'assets/outline_blob.svg',
                  color: Colors.grey,
                  height: 24.0,
                  width: 24.0,
                ),
              )),
        ],
      ),
    );
  }
}
