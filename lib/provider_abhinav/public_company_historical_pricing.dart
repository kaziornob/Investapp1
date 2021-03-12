import 'dart:convert';

import 'package:auroim/constance/global.dart';
import 'package:auroim/widgets/crypto_coin_price_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PublicCompanyHistoricalPricing with ChangeNotifier {
  Map historicalPriceData = {};

  getSinglePublicCompanyData(String ticker, int noOfDays) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath =
        "company_details/listedPricing?ticker=$ticker&timeperiod=$noOfDays";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get historical pricing url: $url");

    var response = await http.get(url, headers: headers);
    print("get single company response: ${response.statusCode}");
    var result = jsonDecode(response.body);
    print(result.toString());
    print(result.runtimeType.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("results ${result["messsage"]}");
      if(result["message"] == "Ticker not in database"){
        // historicalPriceData = ;
        notifyListeners();
      }else{
        historicalPriceData[ticker] = result["message"];
        notifyListeners();
      }

    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
    } else {
      // Toast.show("Something went wrong!", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
