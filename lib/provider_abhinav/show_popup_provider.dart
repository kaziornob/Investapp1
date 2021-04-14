import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowPopupProvider with ChangeNotifier{
  int home_page_popup;
  int learn_marketplace_page_popup;
  int exchange_page_popup;

  homePagePopupPressed() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('home_page_popup',1);
    home_page_popup = 1;
  }

  learnMarketplacePagePopupPressed() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('learn_marketplace_page_popup',1);
    learn_marketplace_page_popup = 1;
  }

  exchangePagePopupPressed() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('exchange_page_popup',1);
    exchange_page_popup = 1;
  }
}