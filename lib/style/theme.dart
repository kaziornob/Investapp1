import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

//
//  static const Color loginGradientStart = const Color(0xFFfbab66);
//  static const Color loginGradientEnd = const Color(0xFFf7418c);

  ///color codes for out of the app pages
  static const Color backgroundColor = const Color(0xFF000000);
  static const Color backgroundLoginColor = const Color(0xFFFFFFFF);


  static const Color loginGradientStart = const Color(0xFFfec20f);
  static const Color loginGradientEnd = const Color(0xFFe70b31);

  ///floatingAction color codes

  static const Color floatingActionBackground = const Color(0xfffec20f);
  static const Color floatingActionIconColor = const Color(0xff161946);
  static const Color floatingActionLabelTextColor = const Color(0xff161946);

  ///BottomNavBar color codes

  static const Color BottomNavBarTextColor = const Color(0xff161946);
  static const Color SelectedBottomNavBarTextColor = const Color(0xFFe70b31);

  static const Color BottomNavBarIconColor = const Color(0xff161946);
  static const Color SelectedBottomNavBarIconColor = const Color(0xFFe70b31);

  static const Color BottomNavBarLabelTextColor = const Color(0xff000000);
  static const Color SelectedBottomNavBarLabelTextColor = const Color(0xFFe70b31);

  ///Drawer color codes

  static const Color drawerIconColor = const Color(0xfffec20f);

  ///App bar color codes
  static const Color AppBarTitleTextColor = const Color(0xff161946);
  static const Color AppBarMenuIconColor = const Color(0xFFe70b31);
  static const Color AppBarTabTextColor = const Color(0xff161946);
  static const Color AppBarSelectedTabLineColor = const Color(0xFFe70b31);
  static const Color AppBarSearchIconColor = const Color(0xfffec20f);
  static const Color AppBarBackIconColor = const Color(0xFFe70b31);















  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}