import 'dart:convert';

import 'package:auroim/constance/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CoinUrl with ChangeNotifier {
  Map<String,String> imageUrl = {};

  getImageUrl(coinId) async {
    print("single coin imageurl");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken',
    };

    String url = GlobalInstance.apiBaseUrl + "company_details/cryptoLogos?coin_name=$coinId";
    print("post url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get image url response $coinId : ${response.body}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      // print("result");
      // return result;
      imageUrl[coinId] = result["message"]["logo_link"];
      notifyListeners();
      print("after notify listener");
      // imageUrl = "";
      // return getCompaniesList(result["message"]);

      // if (result != null &&a
      //     result.containsKey('auth') &&
      //     result['auth'] == true) {
      //   Toast.show("${result['message']}", context,
      //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // }
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
    } else {
      // Toast.show("Something went wrong!", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }



}
