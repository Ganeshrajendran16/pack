import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OfferScreenBg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.0),
          bottomRight: Radius.circular(32.0)),
      child: Stack(
        children: [
          Positioned(
              top: -100,
              left: -150.0,
              child: SvgPicture.asset(
                'assets/outline_blob2.svg',
                color: Colors.grey.withOpacity(0.2),
                height: 300.0,
                width: 200.0,
              )),
          Positioned(
              bottom: -80,
              right: -150.0,
              child: RotatedBox(
                quarterTurns: 1,
                child: SvgPicture.asset(
                  'assets/blob_1.svg',
                  color: Color(0xffE0A500).withOpacity(0.5),
                  height: 400.0,
                  width: 200.0,
                  fit: BoxFit.fitHeight,
                ),
              )),
          Positioned(
              right: -50.0,
              top: 50.0,
              child: SvgPicture.asset(
                'assets/shop_offer_illus.svg',
                height: 200.0,
                width: 200.0,
              ))
        ],
      ),
    );
  }
}
