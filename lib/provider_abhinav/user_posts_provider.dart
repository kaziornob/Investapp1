import 'dart:convert';

import 'package:auroim/constance/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class UserPostsProvider with ChangeNotifier {
  uploadPost(body, context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "user_posts/upload_post";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    print("get post upload response: ${response.statusCode}");

    if (response.statusCode == 200) {
      Toast.show(
        "Posted",
        context,
        duration: 3,
      );
    } else {
      Toast.show(
        "Some Error Occured",
        context,
        duration: 3,
      );
    }
  }
}
