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

  Future login(urlString) async
  {
    String url = GlobalInstance.apiBaseUrl+urlString;

    Map<String, String> headers = {"Content-type": "application/json"};
    bool responseData = false;

    try
    {
      var response = await http.get(url, headers: headers);
      print("req statusCode: ${response.statusCode}");

      print("req response: ${json.decode(response.body)}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // If the call to the server was successful, parse the JSON.
        var result = json.decode(response.body);
        var now = new DateTime.now();
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('Session_token', result['token']);
        prefs.setString('DateTime', new DateFormat("yyyy-MM-dd HH:mm").format(now));
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

  Future postSubmitWithParams(urlString) async
  {
    String url = GlobalInstance.apiBaseUrl+urlString;
    print("post req url: $url");
    var responseData;

    Map<String, String> headers = {"Content-type": "application/json"};

    var response = await http.post(url, headers: headers);
    try{
      if (response.statusCode == 200 || response.statusCode == 201)
      {
        var result = json.decode(response.body);
        responseData = result;
      } else {
        responseData = null;
      }
    } catch (e) {
      print("exception");
      print(e);
    }
    return responseData;
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
      var response = await http.get(Uri.encodeFull(urlString + pairName), headers: {
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

  Future<List<TransactionDetail>> getPairsTransactionDetail(String pairName) async {
    String urlString = ConstanceData.PairsTransaction;
    List<TransactionDetail> responseData = List<TransactionDetail>();
    try {
      var response = await http.get(Uri.encodeFull(urlString + pairName), headers: {
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
    String urlString = 'https://newsapi.org/v2/everything?q=$pairName&apiKey=dc47f2d8143a4a24b6935f7ea7413c63';
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
