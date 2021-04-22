import 'dart:convert';

import 'package:auroim/constance/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UsernameFunctionalityProvider with ChangeNotifier {
  getUsernameList(subString) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "users/search_username";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    var body = {"search_string": "$subString"};

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get set following url : $url");
    // print("session token: $sessionToken");

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    print("get search username response: ${response.statusCode}");
    var result = jsonDecode(response.body);
    print("results : ${result["message"]}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return result["message"];
    } else {
      print("Error occurred during searching username");
    }
  }

  checkUniqueUsername(username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "users/check_username";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    var body = {"username": "$username"};

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get set following url : $url");

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    print("get check username response: ${response.statusCode}");
    var result = jsonDecode(response.body);
    print("results :  ${result["message"]}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (result["message"] == "unique username") {
        return true;
      } else {
        return false;
      }
    } else {
      print("Error occurred during checking username");
      return false;

    }
  }
}
