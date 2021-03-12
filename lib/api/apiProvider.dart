import 'dart:convert';
import 'package:auroim/constance/global.dart';
import 'package:auroim/model/PairDetailInfoModel.dart';
import 'package:auroim/model/PairTransactionDetailModel.dart';
import 'package:auroim/model/liveCryptoNewsModel.dart';
import 'package:http/http.dart' as http;
import 'package:auroim/constance/constance.dart';
import 'package:auroim/model/liveTradingPairModel.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  Future login(funName, body) async {
    String url = GlobalInstance.apiBaseUrl + funName;
    bool responseData = false;

    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.post(url, headers: headers, body: body);

      print("req statusCode: ${response.statusCode}");

      print("req response: ${json.decode(response.body)}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // If the call to the server was successful, parse the JSON.
        var result = json.decode(response.body);
        var now = new DateTime.now();
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('Session_token', result['token']);
        prefs.setString(
            'DateTime', new DateFormat("yyyy-MM-dd HH:mm").format(now));
        responseData = true;
        print("req after true modify: $responseData");
      } else {
        responseData = false;
        print("req after false modify: $responseData");
      }
    } catch (e) {
      print("exception");
      print(e);
    }
    return responseData;
  }

  Future signUp(funName, body) async {
    String url = GlobalInstance.apiBaseUrl + funName;
    print("signup req url: $url");
    var responseData;

    Map<String, String> headers = {"Content-type": "application/json"};
    print("json req Body: $body");

    var response = await http.post(url, headers: headers, body: body);

    print("signup submit response: ${response.statusCode}");

    try {
      responseData = response;
      /*if (response.statusCode == 200 || response.statusCode == 201)
      {
        var result = json.decode(response.body);
        responseData = result;
      } else {
        responseData = null;
      }*/
    } catch (e) {
      print("exception");
      print(e);
    }
    return responseData;
  }

  Future postSubmit(funName, body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String url = GlobalInstance.apiBaseUrl + funName;
    print("post req url: $url");
    print("session token: $sessionToken");

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken',
    };

    var response = await http.post(url, headers: headers, body: body);
    print("post submit response: ${response.statusCode}");
    return response;
  }

  Future getRunAlgoExistingPortfolio(funName) async {
    var token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTE5MCwiaWF0IjoxNjE0NjU5NzM1fQ.ERmIJcyOT15FOX_8dh1F3JaG4-Vf6aqRgP4RO0hIo-I";
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String sessionToken = prefs.getString('Session_token');
    // set up Get request arguments
    final String url = GlobalInstance.apiBaseUrl + funName;
    print("get url : $url");
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $token',
    };

    // make get request
    var response = await http
        .get(url, headers: headers)
        .whenComplete(() => {print("response complete")})
        .catchError((error) {
      print(error.toString());
      print("Error with response");
    });
    // print("response of run algo : ${response.body}");
    print("get existing portfolio: ${response.statusCode}");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return json.decode(response.body);
    } else {
      print("returning false");
      return false;
    }
  }

  Future getRequest(funName) async {
    print("getting the portfolio algo response");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');
    print("session token: $sessionToken");

    // set up Get request arguments
    final String url = GlobalInstance.apiBaseUrl + funName;
    print("get url : $url");
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken',
    };

    // make get request
    var response = await http
        .get(url, headers: headers)
        .whenComplete(() => {print("response complete")})
        .catchError((error) {
      print(error.toString());
      print("Error with response");
    });
    // print("response of run algo : ${response.body}");
    print("response status of run algo : ${response.statusCode}");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return json.decode(response.body);
    } else {
      print("return ning false");
      return false;
    }
  }

  Future<List<TradingPair>> getTradingPairsDetail() async {
    String urlString = ConstanceData.LiveTradingPairs;
    List<TradingPair> responseData = List<TradingPair>();
    try {
      var response = await http.get(Uri.encodeFull(urlString), headers: {
        "Accept": "application/json",
      });
      if (response.statusCode == 200) {
        var responseBody = new JsonDecoder().convert(response.body);
        for (var key in responseBody) {
          responseData.add(TradingPair.fromMap(key));
        }
      }
    } catch (e) {
      print(e);
    }
    return responseData;
  }

  Future<PairDetailInfo> getPairInfoDetail(String pairName) async {
    String urlString = ConstanceData.PairsDetail;
    PairDetailInfo responseData;
    try {
      var response =
          await http.get(Uri.encodeFull(urlString + pairName), headers: {
        "Accept": "application/json",
      });
      if (response.statusCode == 200) {
        responseData = PairDetailInfo.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return responseData;
  }

  Future<List<TransactionDetail>> getPairsTransactionDetail(
      String pairName) async {
    String urlString = ConstanceData.PairsTransaction;
    List<TransactionDetail> responseData = List<TransactionDetail>();
    try {
      var response =
          await http.get(Uri.encodeFull(urlString + pairName), headers: {
        "Accept": "application/json",
      });
      if (response.statusCode == 200) {
        var responseBody = new JsonDecoder().convert(response.body);
        for (var key in responseBody) {
          responseData.add(TransactionDetail.fromMap(key));
        }
      }
    } catch (e) {
      print(e);
    }
    return responseData;
  }

  Future<CryptoNewsLive> cryptoNews(String pairName) async {
    String urlString =
        'https://newsapi.org/v2/everything?q=$pairName&apiKey=dc47f2d8143a4a24b6935f7ea7413c63';
    CryptoNewsLive responseData;
    try {
      var response = await http.get(Uri.encodeFull(urlString), headers: {
        "Accept": "application/json",
      });
      if (response.statusCode == 200) {
        responseData = CryptoNewsLive.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return responseData;
  }
}
