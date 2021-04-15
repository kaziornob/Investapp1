import 'dart:convert';
import 'package:auroim/modules/home/homeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:auroim/constance/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class GoProDataProvider with ChangeNotifier {
  var firstPagePreferences = {};
  var secondPagePreferences = {};
  var thirdPagePreferences = {};
  var sixthPagePreferences = {};

  var allDataToSave;

  setFirstPagePreferences(data) {
    firstPagePreferences = data;
    print(firstPagePreferences);
  }

  setSecondPagePreferences(data) {
    secondPagePreferences = data;
    print(secondPagePreferences);
  }

  setThirdPagePreferences(data) {
    thirdPagePreferences = data;
    print(thirdPagePreferences);
  }

  setSixthPagePreferences(data) {
    sixthPagePreferences = data;
    print(sixthPagePreferences);
  }

  saveDataToSql(context) async {
    allDataToSave = {};
    firstPagePreferences.forEach((key, value) {
      allDataToSave[key] = value;
    });
    secondPagePreferences.forEach((key, value) {
      allDataToSave[key] = value;
    });
    thirdPagePreferences.forEach((key, value) {
      allDataToSave[key] = value;
    });
    sixthPagePreferences.forEach((key, value) {
      allDataToSave[key] = value;
    });
    print(allDataToSave);
    await addGoProDataToServer(allDataToSave, context);
    HelperClass.showLoading(
        context,
        "It requires a lot of computing power and analytics to incorporate this level of Customer Preferences while still staying as close as possible to your prior indicated risk appetite, so please be patient while Auro customizes your portfolio.",
        true);
    await runAlgo(context);
  }

  addGoProDataToServer(body, context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "users/add_gopro_details";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get static url: $url");
    // print("session token: $sessionToken");

    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    print("get static company response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      print("results ${result["message"]}");
      Toast.show("${result['message']}", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return result["message"];
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
    } else {
      Toast.show("Something went wrong!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  runAlgo(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "users/run_gopro_algo";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get static url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get go pro response: ${response.statusCode}");
    print("${response.body}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      Navigator.pop(context);
      print("results ${result["message"]}");
      Toast.show("${result['message']}", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        ModalRoute.withName("/Home"),
      );
      // return result["message"];
    } else {
      Navigator.pop(context);

      Toast.show("Not able to create portfolio", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        ModalRoute.withName("/Home"),
      );
    }
  }
}
