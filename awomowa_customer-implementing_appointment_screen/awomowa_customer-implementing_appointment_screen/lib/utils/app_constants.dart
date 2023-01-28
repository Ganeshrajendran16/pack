import 'dart:ui';

import 'package:flutter/cupertino.dart';

const String MOBILE_UNIQUE_CODE = "mohansmk23";

Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
  return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
}

final navigatorKey = GlobalKey<NavigatorState>();
