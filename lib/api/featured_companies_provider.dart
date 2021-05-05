import 'dart:convert';

import 'package:auroim/constance/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
// import 'package:toast/toast.dart';

class FeaturedCompaniesProvider {
  Future companyDetails(path, body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + path;
    print("get url: $url");
    print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);

    print("get response: ${response.statusCode}");

    // try{
    //
    // } catch (e) {
    //   print("exception");
    //   print(e);
    // }
    return response;
  }

  // getPortFolioData() async {
  //   print("getDoughnutPortfolioData called");
  //   var response = await http.getRequest('users/run_algo');
  //   print("portfolio chart list: $response");
  //   if (response != null &&
  //       response != false &&
  //       response.containsKey('auth') &&
  //       response['auth'] == true) {
  //     setState(() {
  //       homeDonutArray = [];
  //       homeDonutArray.add(1);
  //       homeDonutArray.add(2);
  //       homeDonutArray.add(3);
  //       homeDonutArray.add(4);
  //       portfolioChartData = null;
  //       portfolioChartData = response['message'] != null &&
  //               response['message']['algo_result'] != null
  //           ? response['message']['algo_result']
  //           : null;
  //       setHomeDoughnutChartData();
  //     });
  //   }
  // }

  coinDetails(path) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    String url = path;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url);

    print("get response: ${response.statusCode}");

    // try{
    //
    // } catch (e) {
    //   print("exception");
    //   print(e);
    // }
    return response;
  }

  getSingleCoinDetails(path) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken',
    };

    String url = GlobalInstance.apiBaseUrl + path;
    print("post url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);

    print("get response: ${response.statusCode}");

    // try{
    //
    // } catch (e) {
    //   print("exception");
    //   print(e);
    // }
    return response;
  }

  getSingleCoinImageUrl(coinName) async {
    print("single coin imageurl");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken',
    };

    String url = GlobalInstance.apiBaseUrl + "cryptoLogos?coin_name=$coinName";
    print("post url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    var result = jsonDecode(response.body);
    print("get image url response: ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      // print("result");
      return result;
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

    // try{
    //
    // } catch (e) {
    //   print("exception");
    //   print(e);
    // }
    // return result["message"];
  }

  getCompareChartForPublicCompany(ticker) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "company_details/listedPerformance?ticker=" + ticker;

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get compare chart response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");

      if (result["message"] == "Ticker not in database") {
        return {};
      } else {
        print("results $result");
        return result["message"];
      }

      // return result["message"];
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

  getCompaniesByFilters(filter) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "company_details/pvtFilter?" + filter;

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get filters response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      print("results $result");
      return result["message"];
      // return result["message"];
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

  getSingleCompanyById(companyId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "company_details/pvtInfo?p_key=$companyId";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get single company response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      print("results ${result["messsage"]}");
      return result["message"];
      // return result["message"];
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

  searchIndustry(text) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');
    print(sessionToken);

    String filterPath = "company_details/pvtIndustry?substr=$text";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get industry response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      print("results ${result["messsage"]}");
      return result["message"];
      // return result["message"];
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

  searchCryptoCoins(text) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "company_details/cryptoName?substr=$text";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get public company list response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      print("results ${result["messsage"]}");
      return result["message"];
      // return result["message"];
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

  searchPublicCompanyList(text) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "company_details/listedName?substr=$text";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get public company list response: ${response.statusCode}");
    var result = jsonDecode(response.body);
    print("search compaiessssss");
    print(result.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      print("results ${result["messsage"]}");
      return result["message"];
      // return result["message"];
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

  getUserDetailsByUserId(email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "users/get_other_user_details";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    var body = {"email": email};

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get user details by email url : $url");

    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    print("get user badge response: ${response.statusCode}");
    var result = jsonDecode(response.body);
    print(result.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      return result["data"];
    } else {
      return null;
    }
  }

  getUserCoinsScoreData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "qa/score";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get public company list response: ${response.statusCode}");
    var result = jsonDecode(response.body);
    print(result.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      print("results ${result["message"]}");
      return result["message"];
      // return result["message"];
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

  getSimilarPublicCompaniesImageUrl(ticker) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "company_details/listedSimilar?ticker=$ticker";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get public company list response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      print("results ${result["messsage"]}");
      return result["message"];
      // return result["message"];
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

  getPublicCompanyList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "company_details/listedMain?type=all";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get public company list response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      print("results ${result["messsage"]}");
      return result["message"];
      // return result["message"];
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

  getCoinsListSorted(type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "company_details/cryptoMain?type=$type";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get single company response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      print("results ${result["messsage"]}");
      return result["message"];
      // return result["message"];
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

  getCoinPrices(coinId) async {
    print("get coin prices");

    // String jsonReq = jsonEncode(tempJsonReq);

    var jsonReqResp = await coinDetails(
        'https://api.coingecko.com/api/v3/coins/$coinId/market_chart?vs_currency=usd&days=365');

    var result = jsonDecode(jsonReqResp.body);
    print("coin prices response: $result");

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      return result["prices"];
    } else{
      return [];
    }
  }

  getSinglePublicCompanyHistoricalPricing(ticker, days) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath =
        "company_details/listedPricing?ticker=$ticker&timeperiod=$days";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get single company response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      if (result["message"] == "Ticker not in database") {
        // historicalPriceData = ;
        // notifyListeners();
        return null;
      } else {
        print("results ${result["messsage"]}");
        return result["message"];
      }

      // return result["message"];
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

  getDailyReturnPortfolio() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "users/get_daily_portfolio_return";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get daily return portfolio : $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get gopro risk metrics response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      print("results ${result["returns"]}");
      // Toast.show("${result['data']}", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return result["returns"];
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
    } else {
      print("Error occurred in gopro risk metrics");
      // Toast.show("Something went wrong!", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  getGoproRiskMetricsForUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "users/get_expected_risk_metrics";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get gopro risk metrics url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get gopro risk metrics response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      print("results ${result["data"]}");
      // Toast.show("${result['data']}", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return result["data"];
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
    } else {
      print("Error occurred in gopro risk metrics");
      // Toast.show("Something went wrong!", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  getSinglePublicCompanyDataFromStatic(
    String ticker,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "company_details/listedStaticTicker?ticker=$ticker";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get static url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get static company response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      print("results ${result["messsage"]}");
      return result["message"];
      // return result["message"];
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

  getSinglePublicCompanyData(String ticker, String type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "company_details/listedInfo?ticker=$ticker&type=$type";

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken'
    };

    String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url");
    // print("session token: $sessionToken");

    var response = await http.get(url, headers: headers);
    print("get single public company data response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      print("results ${result["messsage"]}");
      return result["message"];
      // return result["message"];
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

// Future searchCompanyByName(path,body) async
// {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final String sessionToken = prefs.getString('Session_token');
//
//
//   Map<String, String> headers = {"Content-type": "application/json",
//     'Authorization': 'Token $sessionToken'};
//
//   String url = GlobalInstance.apiBaseUrl+path;
//   print("post req url: $url");
//   print("session token: $sessionToken");
//
//   var response = await http.get(url, headers: headers);
//
//   print("post submit response: ${response.statusCode}");
//
//   // try{
//   //
//   // } catch (e) {
//   //   print("exception");
//   //   print(e);
//   // }
//   return response;
// }
}
