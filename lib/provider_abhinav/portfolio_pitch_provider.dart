import 'dart:convert';

import 'package:auroim/constance/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PortfolioPitchProvider with ChangeNotifier {
  List portfolioSecurities = [];
  List allPortfolioPitches;

  addSecurityToPortfolio(ticker, weight) {
    portfolioSecurities.add({"ticker": ticker, "weight": weight});
    notifyListeners();
  }

  deleteSecurityFromPortfolio(index) {
    portfolioSecurities.removeAt(index);
    notifyListeners();
  }

  uploadPortfolioPitch(body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "portfolio_pitch/upload_pitch";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("upload portfolio pitch url: $url");

    var response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));
    print("get upload portfolio pitch response: ${response.statusCode}");
    var result = jsonDecode(response.body);
    print(result.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  getPortfolioPitches(email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "portfolio_pitch/get_portfolio_pitches";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get portfolio pitches url: $url");

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode({"email": email}),
    );
    print("get portfolio pitches response: ${response.statusCode}");
    var result = jsonDecode(response.body);
    print(result.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      allPortfolioPitches = result["message"];
      notifyListeners();
    }
  }
}
