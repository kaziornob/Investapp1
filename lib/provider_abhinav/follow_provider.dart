import 'dart:convert';

import 'package:auroim/constance/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class FollowProvider with ChangeNotifier {
  Map<String, bool> mapOfFollowingListedCompanies = {};
  Map<String, bool> mapOfFollowingCrypto = {};
  Map<String, bool> mapOfFollowingPrivate = {};
  Map<String, bool> mapOfFollowingInvestors = {};

  setFollowingToItems(type, uniqueTypeIdentifier) {
    switch (type) {
      case "crypto":
        mapOfFollowingCrypto[uniqueTypeIdentifier] = true;
        break;
      case "listed":
        mapOfFollowingListedCompanies[uniqueTypeIdentifier] = true;
        break;
      case "private":
        mapOfFollowingPrivate[uniqueTypeIdentifier] = true;
        break;
      case "user":
        mapOfFollowingInvestors[uniqueTypeIdentifier] = true;
        break;
    }
  }

  setUnfollowToItems(type, uniqueTypeIdentifier) {
    switch (type) {
      case "crypto":
        mapOfFollowingCrypto[uniqueTypeIdentifier] = false;
        break;
      case "listed":
        mapOfFollowingListedCompanies[uniqueTypeIdentifier] = false;
        break;
      case "private":
        mapOfFollowingPrivate[uniqueTypeIdentifier] = false;
        break;
      case "user":
        mapOfFollowingInvestors[uniqueTypeIdentifier] = false;
        break;
    }
  }

  setFollowing(userEmail, type, uniqueTypeIdentifier,context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath =
        "company_details/setFollowing?user_email=$userEmail&type=$type&value=$uniqueTypeIdentifier";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get set following url : $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get set following response: ${response.statusCode}");
    var result = jsonDecode(response.body);
    print("results ${result["message"]}");
    if ((response.statusCode == 200 || response.statusCode == 201) &&
        result["message"] == "Following added successfully") {
      Toast.show("Followed Successfully", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // print("ggggg");

      // Toast.show("${result['data']}", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setFollowingToItems(type, uniqueTypeIdentifier);
      notifyListeners();
      // return true;
    } else {
      print("Error occurred setting follow for $type");
      // Toast.show("Something went wrong!", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  getFollowingForSingleItem(userEmail, type, uniqueId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath =
        "company_details/checkFollowing?user_email=$userEmail&value=$uniqueId";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get following for user url : $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get following response: ${response.statusCode}");
    print(response.body);
    var result = jsonDecode(response.body);
    // print("get following single: " + result);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      // print("user following $type list length : ${result["message"].length}");
      // Toast.show("${result['data']}", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      if (result["message"] == "True") {
        setFollowingToItems(type, uniqueId);
        notifyListeners();
      } else {

      }

      // return result["message"];
    } else {
      print("Error occurred checking follow");
      // Toast.show("Something went wrong!", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  unfollowSingleItem(userEmail, type, uniqueId,context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath =
        "company_details/removeFollowing?user_email=$userEmail&value=$uniqueId";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get unfollow for user url : $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get following response: ${response.statusCode}");
    print(response.body);
    var result = jsonDecode(response.body);
    // print("ffff: "+result);

    if ((response.statusCode == 200 || response.statusCode == 201) &&
        result["message"] == "Unfollowed Successfully") {
      setUnfollowToItems(type, uniqueId);
      notifyListeners();
      Toast.show("Unfollowed Successfully", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // return result["message"];
    } else {
      print("Error occurred checking follow");
      // Toast.show("Something went wrong!", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  getFollowing(userEmail, type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath =
        "company_details/getFollowing?user_email=$userEmail&type=$type";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get following for user url : $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get following response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if ((response.statusCode == 200 || response.statusCode == 201) &&
        result["message"] != "User does not follow anything for type $type") {
      // print("ggggg");
      print("user following $type list length : ${result["message"].length}");

      // Toast.show("${result['data']}", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      return result["message"];
    } else {
      print("Error occurred getting follow for $type");
      // Toast.show("Something went wrong!", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
