import 'dart:convert';

import 'package:auroim/constance/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CryptoCoinsProvider with ChangeNotifier{
  Future<List> getTopXCryptoCoins(noOfCryptos) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "company_details/cryptoTopX?num=$noOfCryptos";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get top x crypto response: ${jsonDecode(response.body)}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return result["message"];
    }else{
      return [];
    }
  }

}