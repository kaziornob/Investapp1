import 'dart:convert';
import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/listingsModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;

import 'constance.dart';

var deviceId = '';
var isLight = true;
var isGoldBlack;

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
  ApiProvider request = new ApiProvider();

  static final GlobalInstance _singleton = GlobalInstance._internal();
  static String apiBaseUrl = 'http://44.240.12.174/';
  static String deviceToken;
  static List riskInfoQusAns = [];
  static var portfolioChartData;

  static List riskAptOptionsValue = [
    {
      "riskAptType": "0.07",
      "optionValue":
      [
        {
          "checked":false,
          "potentialLoss": "-6%",
          "potentialGain": "5%"
        },
        {
          "checked":false,
          "potentialLoss": "-7%",
          "potentialGain": "6%"
        },
        {
          "checked":false,
          "potentialLoss": "-8%",
          "potentialGain": "8%"
        },
        {
          "checked":false,
          "potentialLoss": "-9%",
          "potentialGain": "10%"
        },
        {
          "checked":false,
          "potentialLoss": "-10%",
          "potentialGain": "12%"
        }
      ]
    },
    {
      "riskAptType": "0.15",
      "optionValue":
          [
            {
              "checked":false,
              "potentialLoss": "-12%",
              "potentialGain": "10%"
            },
            {
              "checked":false,
              "potentialLoss": "-13%",
              "potentialGain": "12%"
            },
            {
              "checked":false,
              "potentialLoss": "-14%",
              "potentialGain": "14%"
            },
            {
              "checked":false,
              "potentialLoss": "-15%",
              "potentialGain": "17%"
            },
            {
              "checked":false,
              "potentialLoss": "-16%",
              "potentialGain": "21%"
            }
          ]
    },
    {
      "riskAptType": "0.25",
      "optionValue":
          [
            {
              "checked":false,
              "potentialLoss": "-22%",
              "potentialGain": "10%"
            },
            {
              "checked":false,
              "potentialLoss": "-23%",
              "potentialGain": "13%"
            },
            {
              "checked":false,
              "potentialLoss": "-24%",
              "potentialGain": "18%"
            },
            {
              "checked":false,
              "potentialLoss": "-25%",
              "potentialGain": "24%"
            },
            {
              "checked":false,
              "potentialLoss": "-26%",
              "potentialGain": "31%"
            }
          ]
    },
    {
      "riskAptType": "0.35",
      "optionValue":
        [
          {
            "checked":false,
            "potentialLoss": "-25%",
            "potentialGain": "21"
          },
          {
            "checked":false,
            "potentialLoss": "-28%",
            "potentialGain": "28%"
          },
          {
            "checked":false,
            "potentialLoss": "-31%",
            "potentialGain": "37%"
          },
          {
            "checked":false,
            "potentialLoss": "-34%",
            "potentialGain": "49%"
          },
          {
            "checked":false,
            "potentialLoss": "-37%",
            "potentialGain": "66%"
          }
        ]
    }
  ];

  Future getDoughnutPortfolioData() async {
    print("getDoughnutPortfolioData called");
    var response = await request.getRequest('users/run_algo');
    print("portfolio chart list: $response");
    if (response != null &&
        response != false &&
        response.containsKey('auth') &&
        response['auth'] == true) {

        portfolioChartData = response['message'] != null &&
          response['message']['algo_result'] != null
          ? response['message']['algo_result']
          : null;
    }
  }

   static List<String> countryList = <String>[
        "United Kingdom",
         "United States",
         "Bermuda",
         "Australia",
         "Canada",
         "Afghanistan",
          "Aland Islands"
         "Albania",
         "Algeria",
         "American",
         "Samoa",
         "Andorra",
         "Angola",
         "Anguilla",
         "Antarctica",
         "Antigua and Barbuda",
         "Argentina",
         "Armenia",
         "Aruba",
         "Austria",
         "Azerbaijan",
         "Bahamas",
         "Bahrain",
         "Bangladesh",
         "Barbados",
         "Belarus",
         "Belgium",
         "Belize",
         "Benin",
         "Bhutan",
         "Bolivia",
         "Bosnia and Herzegovina",
         "Botswana",
         "Brazil",
         "British Indian Ocean Territory",
         "British Virgin Islands",
         "Brunei Darussalam",
         "Bulgaria",
         "Burkina Faso",
         "Burundi Cambodia",
         "Cameroon",
         "Cape Verde",
         "Cayman Islands",
         "Central African Republic",
         "Chad",
         "Channel Islands and Jersey",
         "Chile",
         "China",
         "Colombia",
         "Comoros",
         "Congo",
         "Cook Islands",
         "Costa Rica",
         "Cote d'Ivoire" ,
         "Croatia",
         "Cuba",
         "Curacao",
         "Cyprus",
         "Czech Republic",
         "Democratic Peoples Republic of Korea (North Korea]",
         "Democratic Republic of the Congo",
         "Denmark",
         "Djibouti",
         "Dominica",
         "Dominican Republic",
         "East Timor",
         "Ecuador",
         "Egypt",
         "El Salvador",
         "Equatorial Guinea",
         "Eritrea",
         "Estonia",
         "Ethiopia",
         "Faeroe Islands",
         "Falkland Islands (Malvinas)",
         "Fiji",
         "Finland",
         "France",
         "French Guiana",
         "French Polynesia",
         "Gabon",
         "Gambia",
         "Georgia",
         "Germany",
         "Ghana",
         "Gibraltar",
         "Greece",
         "Greenland",
         "Grenada",
         "Guadeloupe",
         "Guam",
         "Guatemala",
         "Guernsey",
         "Guinea",
         "Guinea-Bissau",
         "Guyana",
         "Haiti",
         "Holy See",
         "Honduras",
         "Hong Kong Special Administrative Region of China",
         "Hungary",
         "Iceland",
         "India"
         "Indonesia",
         "Iran (Islamic Republic of)",
         "Iraq",
         "Ireland",
         "Isle of Man",
         "Israel Italy",
         "Jamaica",
         "Japan",
         "Jordan",
         "Kazakhstan",
         "Kenya",
         "Kiribati",
         "Kosovo",
         "Kuwait",
         "Kyrgyzstan",
         "Lao People`s Democratic Republic",
         "Latvia",
         "Lebanon",
         "Lesotho",
         "Liberia",
         "Libyan Arab Jamahiriya",
         "Liechtenstein",
         "Lithuania",
         "Luxembourg",
         "Macao Special Administrative Region of China",
         "Madagascar",
         "Malawi",
         "Malaysia",
         "Maldives",
         "Mali",
         "Malta",
         "Marshall Islands",
         "Martinique",
         "Mauritania",
         "Mauritius",
         "Mayotte",
         "Mexico",
         "Micronesia, Federated States of",
         "Monaco",
         "Mongolia",
         "Montenegro",
         "Montserrat",
         "Morocco",
         "Mozambique",
         "Myanmar",
         "Namibia",
         "Nauru",
         "Nepal",
         "Netherlands",
         "Netherlands Antilles",
         "New Caledonia",
         "New Zealand",
         "Nicaragua",
         "Niger",
         "Nigeria",
         "Niue",
         "Norfolk Island",
         "Northern Mariana Islands",
         "Norway",
         "Occupied Palestinian Territory",
         "Oman",
         "Pakistan",
         "Palau",
         "Panama",
         "Papua New Guinea",
         "Paraguay",
         "Peru",
         "Philippines",
         "Pitcairn",
         "Poland",
         "Portugal",
         "Puerto Rico",
         "Qatar",
         "Republic of Korea",
         "Republic of Moldova",
         "Reunion",
         "Romania",
         "Russian Federation",
         "Rwanda",
         "Saint Helena",
         "Saint Kitts and Nevis",
         "Saint Lucia",
         "Saint Pierre and Miquelon",
         "Saint Vincent and the Grenadines",
         "Samoa",
         "San Marino",
         "Sao Tome and Principe",
         "Saudi Arabia",
         "Senegal",
         "Serbia",
         "Seychelles",
         "Sierra Leone",
         "Singapore",
         "Slovakia",
         "Slovenia",
         "Solomon Islands",
         "Somalia",
         "South Africa",
         "South Sudan",
         "Spain",
         "Sri Lanka",
         "Sudan Suriname",
         "Svalbard and Jan Mayen Islands",
         "Swaziland",
         "Sweden",
         "Switzerland",
         "Syrian Arab Republic",
         "Taiwan (Republic of China)",
         "Tajikistan Thailand The former Yugoslav Republic of Macedonia",
         "Togo",
         "Tokelau",
         "Tonga",
         "Trinidad and Tobago",
         "Tunisia",
         "Turkey",
         "Turkmenistan",
         "Turks and Caicos Islands",
         "Tuvalu",
         "Uganda",
         "Ukraine",
         "United Arab Emirates",
         "United Republic of Tanzania",
         "United States Virgin Islands",
         "Uruguay",
         "Uzbekistan",
         "Vanuatu",
         "Venezuela",
         "Viet Nam",
         "Wallis and Futuna Islands",
         "Western Sahara",
         "Yemen",
         "Yugoslavia",
         "Zambia",
         "Zimbabwe"
  ];

  // static int fileChunkSize = 50000; //in bytes i.e 50kb

  factory GlobalInstance() {
    return _singleton;
  }

  GlobalInstance._internal();
}


class HelperClass {

  // Minimum eight characters, at least one letter, one number and one special character:
  static bool validatePassword(String value) {
    return RegExp(
        r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&^=+-])[A-Za-z\d@$!%*#?&^=+-]{6,}$")
        .hasMatch(value)
        ? true
        : false;
  }

  static bool validateString(String value)
  {
    Pattern pattern =
        r'^[A-Za-z _]*[A-Za-z][A-Za-z _]*$';
    RegExp regex = new RegExp(pattern);

    if(value!='' && value!=null)
    {
      if (!regex.hasMatch(value))
        return false;
      else
        return true;
    }
    else
    {
      return false;
    }
  }

  static void showLoading(context) {
    // var sLoadingContext;
    print("show loading call");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext loadingContext) {
        // sLoadingContext = loadingContext;
        return Container(
          height: MediaQuery.of(context).size.height * 0.05,
          margin: EdgeInsets.only(top: 50, bottom: 30),
          child: Dialog(
            backgroundColor: Color(0xff161946),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.0,bottom: 8.0),
                      child: new CircularProgressIndicator(),
                    )
                ),
                Padding(padding: EdgeInsets.only(left: 110.0,bottom: 10.0,top: 5.0),
                  child: new Text(
                    "Please wait...",
                    style: TextStyle(color: const Color(0xFFD9E4E9)),
                  ),)
              ],
            ),
          ),
        );
      },
    );
  }

  static void showAlert(context,msg) {
    showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blueGrey,
            title: Text(
              "",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE18,
              ),
            ),
            content: Text(
              "$msg",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE18,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.blueGrey,
                textColor: Colors.white,
                child: Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: ConstanceData.SIZE_TITLE12,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],);
        }
    );
  }
}
