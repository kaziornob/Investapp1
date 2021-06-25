import 'dart:convert';

import 'package:auroim/constance/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ListedCompanyProvider with ChangeNotifier {
  Future<List> getTopXListedCompanies(noOfCompanies) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "company_details/listedTopX?num=$noOfCompanies";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");

    var response = await http.get(Uri.parse(url), headers: headers);
    print("get top x listed response: ${jsonDecode(response.body)}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return result["message"];
    } else {
      return [];
    }
  }
}
