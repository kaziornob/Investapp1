import 'dart:convert';

import 'package:auroim/constance/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordProvider with ChangeNotifier {
  sendOtp(email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token') == null
        ? ""
        : prefs.getString('Session_token');
    print("session token : $sessionToken");

    String filterPath = "company_details/sendOTP";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    var body = {
      "user_email": "$email",
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    print("get forgot pass send otp response: ${jsonDecode(response.body)}");
    var result = jsonDecode(response.body);

    if ((response.statusCode == 200 || response.statusCode == 201) &&
        result["message"] == "Email Sent Successfully!") {
      return true;
    } else {
      return false;
    }
  }

  resetPassword(email, otp, password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token') == null
        ? ""
        : prefs.getString('Session_token');
    print("session token : $sessionToken");

    String filterPath = "company_details/resetPassword";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    var body = {
      "email": "$email",
      "otp": "$otp",
      "password": "$password",
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    print("get reset pass response: ${jsonDecode(response.body)}");
    var result = jsonDecode(response.body);

    if ((response.statusCode == 200 || response.statusCode == 201) &&
        result["message"] == "Password updated Successfully!") {
      return result["message"];
    } else {
      return result["message"];
    }
  }
}
