import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReusableFunctions {
  // int home_page_popup;
  // int learn_marketplace_page_popup;
  // int exchange_page_popup;


  formatCurrencyNo(String money) {
    print("format no");
    final usFormat = new NumberFormat("#,##0.00", "en_US");
    // print(usFormat.format(double.parse(money)));
    return usFormat.format(double.parse(money));
  }

  homePagePopupGetData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('home_page_popup');
  }

  learnMarketplacePagePopupGetData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('learn_marketplace_page_popup');
  }

  exchangePagePopupGetData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('exchange_page_popup');
  }


  homePagePopupPressed() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('home_page_popup',1);
    // home_page_popup = 1;
  }

  learnMarketplacePagePopupPressed() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('learn_marketplace_page_popup',1);
    // learn_marketplace_page_popup = 1;
  }

  exchangePagePopupPressed() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('exchange_page_popup',1);
    // exchange_page_popup = 1;
  }
}
