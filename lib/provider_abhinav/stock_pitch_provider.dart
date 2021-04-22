import 'dart:convert';

import 'package:auroim/constance/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StockPitchProvider with ChangeNotifier {
  String stockSelected;
  List allStockPitches;

  uploadStockPitch(body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "stock_pitch/upload_pitch";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("upload stock pitch url: $url");

    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    print("get upload stock pitch response: ${response.statusCode}");
    var result = jsonDecode(response.body);
    print(result.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  getDailyReturnChartList(body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "users/get_daily_stock_return";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    print(body);


    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get stock pitch daily Return url: $url");

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    print(response.body);
    print("get stock pitch daily Return response: ${response.statusCode}");
    var result = jsonDecode(response.body);
    print(result.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      return result["returns"];
    }else{
      return [];
    }
  }

  getStockPitches(email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "stock_pitch/get_stock_pitches";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get stock pitches url: $url");

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({"email": email}),
    );
    print("get stock pitches response: ${response.statusCode}");
    var result = jsonDecode(response.body);
    print(result.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      allStockPitches = result["message"];
      notifyListeners();
    }
  }
}
