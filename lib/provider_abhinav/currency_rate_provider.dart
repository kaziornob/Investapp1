import 'dart:convert';

import 'package:auroim/constance/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CurrencyRateProvider with ChangeNotifier {
  var listOfAllFxs = [];

  getListOfAllFx() async {
    print("get all fxs");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken',
    };

    String url = GlobalInstance.apiBaseUrl + "company_details/searchAllFX";
    print("post all fx url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    // print("get  response of all fxs : ${response.body}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      listOfAllFxs = result["message"];
      return listOfAllFxs;
    } else {
      print("error in getting all fxs");
    }
  }

  getSingleFxRate(fxId) async {
    print("get single fx rate");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken',
    };

    String url = GlobalInstance.apiBaseUrl +
        "company_details/searchOneFX?ccy_name=$fxId";
    print("post all fx url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    // print("get  response of all fxs : ${response.body}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return result["message"][0];
    } else {
      print("error in getting all fxs");
    }
  }
}
