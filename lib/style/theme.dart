import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

//
//  static const Color loginGradientStart = const Color(0xFFfbab66);
//  static const Color loginGradientEnd = const Color(0xFFf7418c);

  static const Color accAppBarBackgroundColor = const Color(0xFFfec20f);
  static const Color accScreenBackgroundColor = const Color(0xFF000000);
  static const Color accButtonBackgroundColor = const Color(0xFFfec20f);

  static const Color retailAppBarBackgroundColor = const Color(0xFFCD853F);
  static const Color retailScreenBackgroundColor = const Color(0xFFFFFFFF);
  static const Color retailButtonBackgroundColor = const Color(0xFFCD853F);



  ///color codes for out of the app pages
  static const Color backgroundColor = const Color(0xFF000000);
  static const Color backgroundLoginColor = const Color(0xFFFFFFFF);


  static const Color loginGradientStart = const Color(0xFFfec20f);
  static const Color loginGradientEnd = const Color(0xFFe70b31);


  ///all type button boxDecoration color codes for all of the app pages

  static const Color buttonBoxDecorationColor = const Color(0xFFfec20f);

  ///floatingAction color codes

  static const Color floatingActionBackground = const Color(0xfffec20f);
  static const Color floatingActionIconColor = const Color(0xff161946);
  static const Color floatingActionLabelTextColor = const Color(0xff161946);

  ///BottomNavBar color codes

  static const Color BottomNavBarTextColor = const Color(0xff161946);
  static const Color SelectedBottomNavBarTextColor = const Color(0xFFe70b31);

  static const Color BottomNavBarIconColor = const Color(0xFFFFFFFF);
  static const Color SelectedBottomNavBarIconColor = const Color(0xfffec20f);

  static const Color BottomNavBarLabelTextColor = const Color(0xFFFFFFFF);
  static const Color SelectedBottomNavBarLabelTextColor = const Color(0xfffec20f);

  ///Drawer color codes

  static const Color drawerIconColor = const Color(0xfffec20f);

  ///area chart below box color codes

  static const Color areaChartBelowBoxColorCode = const Color(0xff696969);

  ///App bar color codes
  // static const Color AppBarBackGroundColor = const Color(0xFF000000);
  static const Color AppBarBackGroundColor = const Color(0xff33A8FF);
  static const Color AppBarTitleTextColor = const Color(0xFFFFFFFF);
  static const Color AppBarMenuIconColor = const Color(0xFFFFFFFF);
  static const Color AppBarBackIconColor = const Color(0xfffec20f);
  static const Color AppBarSelectedTabLineColor = const Color(0xfffec20f);
  static const Color AppBarTabTextColor = const Color(0xFFFFFFFF);


  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

// remove auro version pi your personal asset manager logobottom line remove from home page- done
// usa, technology,usa technology,(at country sector selection)- done
// put the tabs below the search box on home screen(pi version) page
// put the gear box icon button with search box and it goes to settings page - done
// at login page put the slider of 5 images - partially done
// button should be rectangular with corner curve - done
// go live and go pro button should be in one row once all risk onboarding complete go pro button got disappear. - done(except condition)
// pie chart should be 3 slider at invest pi version(pi).(first, second screen should be donut chart) - partially done

// 3 point of note(company page):  at 22 page(long->buy,short->sell) also put the button long and short with long and short section of that page.
// note: user can vote only after 3 months - partially done

// at search area bar page the search text not there on app bar there should be back button.

// search box at invest page with icon - done
// voting bar section on company profile page
// bottom bar section same as linkedIn
