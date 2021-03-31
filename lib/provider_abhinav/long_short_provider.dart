import 'dart:convert';

import 'package:auroim/constance/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LongShortProvider with ChangeNotifier {
  var proConsForPublicCompany;

  getProConsForPublicCompany(ticker) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "company_details/procons?ticker=$ticker";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get pro cons response: ${jsonDecode(response.body)}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (result["message"] == "Ticker not in database") {
        return {};
      } else {
        print("results $result");
        proConsForPublicCompany = result["message"];
        notifyListeners();
      }
    }
  }
}
