import 'dart:convert';
import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:animator/animator.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/listingsModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;

import 'constance.dart';

var deviceId = '';
var isLight = true;
var isGoldBlack = false;

var isOnLocation = true;
var isNotification = true;
var pushtokenId = '';
var primaryColorString = '101622';
var secondaryColorString = '101622';
var usertoken = '';

var buttoncolor1 = Color(0xFF123962);
var buttoncolor2 = Color(0xFF7635ff);

var iconButtonColor1 = isGoldBlack ? Color(0xFFD8AF4F) : Color(0xFF7499C6);
var iconButtonColor2 = isGoldBlack ? Color(0xFFD8AF4F) : Color(0xFF7499C6);

String coinMarketcap = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=";
// String coinMarketcap = "https://api.coinmarketcap.com/v1/ticker/?start=";
// String imageURL = "https://s2.coinmarketcap.com/static/img/coins/128x128/";
String coinImageURL = 'https://static.coincap.io/assets/icons/';

normalizeNumNoCommas(num input) {
  if (input == null) {
    input = 0;
  }
  if (input >= 1000) {
    return input.toStringAsFixed(2);
  } else {
    return input.toStringAsFixed(6 - input.round().toString().length);
  }
}

String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return '';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-5575162454233793/7463434777';
  }
  return null;
}

String getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return '';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-5575162454233793/3535782148';
  }
  return null;
}

String getRewardBasedVideoAdUnitId() {
  if (Platform.isIOS) {
    return '';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-5575162454233793/9475655911';
  }
  return null;
}

AdmobBannerSize bannerSize;

void handleEvent(AdmobAdEvent event, Map<String, dynamic> args, String adType) {
  switch (event) {
    case AdmobAdEvent.loaded:
      print('New Admob $adType Ad loaded!');
      break;
    case AdmobAdEvent.opened:
      print('Admob $adType Ad opened!');
      break;
    case AdmobAdEvent.closed:
      print('Admob $adType Ad closed!');
      break;
    case AdmobAdEvent.failedToLoad:
      print('Admob $adType failed to load. :(');
      break;
    // case AdmobAdEvent.rewarded:
    //   showDialog(
    //     context: _scaffoldKey.currentContext,
    //     builder: (BuildContext context) {
    //       return WillPopScope(
    //         child: AlertDialog(
    //           content: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: <Widget>[
    //               Text('Reward callback fired. Thanks Andrew!'),
    //               Text('Type: ${args['type']}'),
    //               Text('Amount: ${args['amount']}'),
    //             ],
    //           ),
    //         ),
    //         onWillPop: () async {
    //           _scaffoldKey.currentState.hideCurrentSnackBar();
    //           return true;
    //         },
    //       );
    //     },
    //   );
    //break;
    default:
  }
}

Future<List<CryptoCoinDetail>> getData1(int start) async {
  List<CryptoCoinDetail> lstCryptoCoinDetail = new List<CryptoCoinDetail>();
  try {
    var response = await http.get(
      Uri.encodeFull(coinMarketcap + start.toString()),
      headers: {
        "Accept": "application/json",
        "X-CMC_PRO_API_KEY": "41939c64-03af-467f-8e62-f150722470e0", //41939c64-03af-467f-8e62-f150722470e0
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data != null) {
        var response = Listings.fromJson(data);
        if (response != null) {
          lstCryptoCoinDetail = response.data;
        }
      }
      return lstCryptoCoinDetail;
    } else {
      return lstCryptoCoinDetail;
    }
  } catch (e) {
    print("Something Wrong $e");
    return lstCryptoCoinDetail;
  }
}

final Map ohlcvWidthOptions = {
  "1h": [
    ["1m", 60, 1, "minute"],
    ["2m", 30, 2, "minute"],
    ["3m", 20, 3, "minute"]
  ],
  "6h": [
    ["5m", 72, 5, "minute"],
    ["10m", 36, 10, "minute"],
    ["15m", 24, 15, "minute"]
  ],
  "12h": [
    ["10m", 72, 10, "minute"],
    ["15m", 48, 15, "minute"],
    ["30m", 24, 30, "minute"]
  ],
  "24h": [
    ["15m", 96, 15, "minute"],
    ["30m", 48, 30, "minute"],
    ["1h", 24, 1, "hour"]
  ],
  "3D": [
    ["1h", 72, 1, "hour"],
    ["2h", 36, 2, "hour"],
    ["4h", 18, 4, "hour"]
  ],
  "7D": [
    ["2h", 86, 2, "hour"],
    ["4h", 42, 4, "hour"],
    ["6h", 28, 6, "hour"]
  ],
  "1M": [
    ["12h", 60, 12, "hour"],
    ["1D", 30, 1, "day"]
  ],
  "3M": [
    ["1D", 90, 1, "day"],
    ["2D", 45, 2, "day"],
    ["3D", 30, 3, "day"]
  ],
  "6M": [
    ["2D", 90, 2, "day"],
    ["3D", 60, 3, "day"],
    ["7D", 26, 7, "day"]
  ],
  "1Y": [
    ["7D", 52, 7, "day"],
    ["14D", 26, 14, "day"]
  ],
};

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

class AnimatedForwardArrow extends StatelessWidget {
  final bool isShowingarroeForward;
  const AnimatedForwardArrow({
    Key key,
    this.isShowingarroeForward,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Animator(
      tween: Tween<Offset>(
        begin: Offset(0, 0),
        end: Offset(0.3, 0),
      ),
      duration: Duration(milliseconds: 500),
      cycles: 0,
      builder: (anim) => FractionalTranslation(
        translation: anim.value,
        child: isShowingarroeForward
            ? Icon(
                Icons.arrow_forward_ios,
                color: AllCoustomTheme.getTextThemeColors(),
                size: 18,
              )
            : SizedBox(),
      ),
    );
  }
}

class AnimatedDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Animator(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500),
      cycles: 1,
      builder: (anim) => SizeTransition(
        sizeFactor: anim,
        axis: Axis.horizontal,
        axisAlignment: 1,
        child: Divider(
          thickness: 0.5,
          color: AllCoustomTheme.getsecoundTextThemeColor(),
        ),
      ),
    );
  }
}

class PinEnable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [globals.buttoncolor1, globals.buttoncolor2],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: CircleAvatar(
            radius: 4,
            backgroundColor: AllCoustomTheme.getTextThemeColors(),
          ),
        ),
      ),
    );
  }
}

class PinDisable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        border: Border.all(
          color: AllCoustomTheme.getsecoundTextThemeColor(),
          width: 1.5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}

class PinNumberStyle extends StatelessWidget {
  final String digit;
  const PinNumberStyle({Key key, this.digit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      digit,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AllCoustomTheme.getTextThemeColors(),
        fontWeight: FontWeight.bold,
        fontSize: ConstanceData.SIZE_TITLE25,
      ),
    );
  }
}

class MagicBoxGradiantLine extends StatelessWidget {
  final double height;

  const MagicBoxGradiantLine({Key key, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height == 0 || height == null ? 2 : height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            globals.buttoncolor1,
            globals.buttoncolor2,
          ],
        ),
      ),
    );
  }
}

String getConvertTime(String utcTime) {
  String year = utcTime.substring(0, 4);
  String month = utcTime.substring(5, 7);
  String day = utcTime.substring(8, 10);
  String hours = utcTime.substring(11, 13);
  String min = utcTime.substring(14, 16);
  return day + '-' + month + '-' + year + ' ' + hours + ':' + min;
}



class GlobalInstance {
  static final GlobalInstance _singleton = GlobalInstance._internal();
  static String apiBaseUrl = 'http://54.212.199.127/';
  static String deviceToken;
  static List riskInfoQusAns = [];

  // static int fileChunkSize = 50000; //in bytes i.e 50kb

  factory GlobalInstance() {
    return _singleton;
  }

  GlobalInstance._internal();
}