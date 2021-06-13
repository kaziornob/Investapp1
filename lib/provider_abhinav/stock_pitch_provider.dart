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

  addComment(email, pitchNumber, answer) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "forum/create_stock_pitch_answer";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    var body = {
      "email": email,
      "pitch_number": "$pitchNumber",
      "answer": answer,
    };
    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get stock pitch comments: $url");

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    print("get stock pitch comments response: ${response.statusCode}");
    // print(response.body);
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return result["message"]["message"];
    } else {
      return "";
    }
  }

  addCommentReply(commentId, reply) async {
    print("baba here");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "forum/create_stock_pitch_answer_comment";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    var body = {
      "answer_id": "$commentId",
      "comment": reply,
    };
    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("add stock pitch comments: $url");

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    print("add stock pitch comments response: ${response.statusCode}");
    // print(response.body);
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return result["message"]["message"];
    } else {
      return "";
    }
  }

  Future<dynamic> getStockPitchComments(email, pitchNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "forum/get_stock_pitch_answer";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    var body = {
      "email": email,
      "pitch_number": "$pitchNumber",
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get stock pitch comments: $url");

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    print("get stock pitch comments response: ${response.statusCode}");
    // print(response.body);
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return result["message"]["answers"];
    } else {
      return [];
    }
  }

  getStockPitchCommentReplies(commentId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "forum/get_stock_pitch_answer_comment";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    var body = {
      "answer_id": "$commentId",
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get stock pitch comment replies: $url");

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    print("get stock pitch comments replies response: ${response.statusCode}");
    // print(response.body);
    var result = jsonDecode(response.body);
    print(result["message"]["comments"]);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("returning hxgdjsa");
      return result["message"]["comments"];
    } else {
      return [];
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

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get stock pitch daily Return url: $url");

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    print("get stock pitch daily Return response: ${response.statusCode}");
    // print(response.body);
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return result["returns"];
    } else {
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
