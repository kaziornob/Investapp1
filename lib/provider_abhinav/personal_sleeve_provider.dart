import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalSleeveProvider with ChangeNotifier {
  ApiProvider request = new ApiProvider();
  var portfolioData;
  var dailyPortfolioReturnData;

  getPortfolioData() async {
    print("getDoughnutPortfolioData provider called");
    var response = await request
        .getRunAlgoExistingPortfolio('personal_sleeve/paper_portfolio');
    print(response);
    print("portfolio chart list: $response");
    if (response != null &&
        response != false &&
        response.containsKey('auth') &&
        response['auth'] == true) {
      portfolioData =
          response['message'] != null && response['message']['data'] != null
              ? response['message']
              : null;

      notifyListeners();
    }
  }

  getDailyReturnPortfolio() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "personal_sleeve/get_daily_portfolio_return";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get daily return portfolio : $url");

    var response = await http.get(Uri.parse(url), headers: headers);
    print("get daily return portfolio response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("results ${result["returns"]}");
      dailyPortfolioReturnData = result["returns"];
      return dailyPortfolioReturnData;
      // notifyListeners();
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
    } else {
      print("Error occurred in gopro risk metrics");
    }
  }
}
