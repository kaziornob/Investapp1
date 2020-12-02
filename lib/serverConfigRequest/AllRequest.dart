import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:auro/shared/globalInstance.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AllHttpRequest extends StatelessWidget {

  static String apiUrl= GlobalInstance.apiBaseUrl;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future login(body) async
  {
    // set up POST request arguments
    String url = AllHttpRequest.apiUrl+'login';
    Map<String, String> headers = {"Content-type": "application/json"};

    // make POST request
    var response = await http.post(url, headers: headers, body: body);


    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      var result = json.decode(response.body);
      var now = new DateTime.now();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user_id', result['user_id']);
      prefs.setString('User_name', result['username']);
      prefs.setString('First_name', result['first_name']);
      prefs.setString('Last_name', result['last_name']);
      prefs.setString('Email_ID', result['Email_ID']);
      prefs.setString('Session_token', result['Session_token']);
      prefs.setString('Role', result['role']);
//      var tempCoins = result['coins'].toInt();
//      prefs.setInt('Coins', tempCoins);
      prefs.setDouble('Coins', result['coins']);
      prefs.setString('DateTime', new DateFormat("yyyy-MM-dd HH:mm").format(now));
      return true;
    } else {
      return false;
    }
  }

  Future submitSignUp(paramBody) async
  {
    // set up POST request arguments
    String url = AllHttpRequest.apiUrl+'signup';
    Map<String, String> headers = {"Content-type": "application/json"};

    // make POST request
    var response = await http.post(url, headers: headers, body: paramBody);


    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.

      var result = json.decode(response.body);

      if(result['user_id']!='None')
        {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('user_id', result['user_id']);
          prefs.setString('User_name', result['username']);
          prefs.setString('First_name', result['first_name']);
          prefs.setString('Last_name', result['last_name']);
          prefs.setString('Email_ID', result['Email_ID']);
          prefs.setString('Session_token', result['Session_token']);
          prefs.setString('Role', result['role']);
          /*var tempCoins = result['coins'].toInt();
          prefs.setInt('Coins', tempCoins);*/
          prefs.setDouble('Coins', result['coins']);

          return true;
        }

      else
        {
          return false;
        }
    } else {
      return false;
    }
  }

  Future forgotPassword(paramBody) async
  {
    // set up POST request arguments
    String url = AllHttpRequest.apiUrl+'reset_password';
    Map<String, String> headers = {"Content-type": "application/json"};

    // make POST request
    var response = await http.post(url, headers: headers, body: paramBody);


    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.

      return true;
    } else {
      return false;
    }
  }

  Future otpRequest(funName,body,reqOtp) async
  {

    // set up Get request arguments
    final String url = AllHttpRequest.apiUrl+funName;
    Map<String, String> headers = {"Content-type": "application/json",'otp':reqOtp};

    // make POST request
    var response = await http.post(url, headers: headers, body: body);


    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.

      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future postSubmit(funName,body) async
  {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('user_id');
    final String sessionToken = prefs.getString('Session_token');

    // set up POST request arguments
    String url = AllHttpRequest.apiUrl+funName;
    Map<String, String> headers = {"Content-type": "application/json",'user-id': userId, "session-token": sessionToken};

    // make POST request
    var response = await http.post(url, headers: headers, body: body);
    return response;
  }

  Future patchSubmit(funName,body) async
  {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('user_id');
    final String sessionToken = prefs.getString('Session_token');

    // set up PATCH request arguments
    String url = AllHttpRequest.apiUrl+funName;
    Map<String, String> headers = {"Content-type": "application/json",'user-id': userId, "session-token": sessionToken};

    // make POST request
    var response = await http.patch(url, headers: headers, body: body);
    return response;
  }

  Future newGetRequest(funName,id) async
  {
    // set up Get request arguments
    final String url = AllHttpRequest.apiUrl+funName;
    Map<String, String> headers = {'answer_id':id};


    // make POST request
    var response = await http.get(url, headers: headers);


    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.

      return json.decode(response.body);
    } else {
      return false;
    }
  }

}
