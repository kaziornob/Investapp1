import 'dart:convert';

import 'package:auroim/constance/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LongShortProvider with ChangeNotifier {
  var proConsForPublicCompany;
  List finbertArticles;

  getProConsForPublicCompany(ticker) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "company_details/procons?ticker=$ticker";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get pro cons response: ${jsonDecode(response.body)}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (result["message"] == "Ticker not in database") {
        return {};
      } else {
        print("results $result");
        proConsForPublicCompany = result["message"];
        notifyListeners();
      }
    }
  }

  getQuarterlyVotes(ticker) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "long_short/get_quarterly_votes";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get votes url: $url");
    // print("session token: $sessionToken");

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({"ticker": ticker}),
    );
    print("get long short response: ${jsonDecode(response.body)}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return result["message"];
    }
  }

  castLongShortVote(
    email,
    ticker,
    isLong,
    comment,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "long_short/vote_listed";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get cast vote  url: $url");
    // print("session token: $sessionToken");

    var body = {
      "email": email,
      "ticker": ticker,
      "isLong": isLong,
      "comment": comment,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    print("get long short cast vote response: ${jsonDecode(response.body)}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return result["message"];
    }
  }

  getLongShortVotes(ticker) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "long_short/get_all_votes";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get votes url: $url");
    // print("session token: $sessionToken");

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({"ticker": ticker}),
    );
    print("get long short response: ${jsonDecode(response.body)}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return result["message"];
    }
  }

  sortedFinbertArticleByPositiveSentimentScore() {
    List newList = [...finbertArticles];
    newList =
        newList.where((article) => article["sentiment_score"] > 0).toList();
    // newList
    //     .where((article) => article["sentiment_score"] > 0)
    //     .toList().forEach((element) {
    //   print("${element["sentiment_score"]}");
    // });
    newList
        .sort((a, b) => b["sentiment_score"].compareTo(a["sentiment_score"]));
    return newList;
  }

  sortedFinbertArticleByNegativeSentimentScore() {
    List newList = [...finbertArticles];
    newList =
        newList.where((article) => article["sentiment_score"] < 0).toList();
    newList
        .sort((a, b) => a["sentiment_score"].compareTo(b["sentiment_score"]));

    return newList;
  }

  finbertArticleWithMostPositiveSentiment() {
    var article;
    finbertArticles.forEach((element) {
      if (article == null) {
        article = element;
      } else {
        if (article["sentiment_score"] < element["sentiment_score"]) {
          article = element;
        }
      }
    });

    return article;
  }

  finbertArticleWithMostNegetiveSentiment() {
    var article;
    finbertArticles.forEach((element) {
      if (article == null) {
        article = element;
      } else {
        if (article["sentiment_score"] > element["sentiment_score"]) {
          article = element;
        }
      }
    });

    return article;
  }

  getFinbertArticleForPublicCompany(ticker) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "company_details/searchFinbert?tckr=$ticker";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get finbert url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("finbert response: ${jsonDecode(response.body)}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (result["message"] == "Ticker not in database") {
        return [];
      } else {
        print("results $result");
        finbertArticles = result["message"];
        notifyListeners();
      }
    }
  }
}
