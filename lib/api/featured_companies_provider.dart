import 'dart:convert';

import 'package:auroim/constance/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

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

  getUserCoinsScoreData()async{
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

    String filterPath = "company_details/listedName?substr=";

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

  getSinglePublicCompanyData(String ticker) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String filterPath = "company_details/listedInfo?ticker=$ticker";

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
