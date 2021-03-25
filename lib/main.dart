import 'dart:convert';
import 'dart:io';

// import 'package:admob_flutter/admob_flutter.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/auth/empStatus.dart';
import 'package:auroim/auth/investorType.dart';
import 'package:auroim/auth/riskApetitePages/riskApetiteForm.dart';
import 'package:auroim/auth/userPersonalDetails.dart';
import 'package:auroim/model/listingsModel.dart';
import 'package:auroim/model/radioQusModel.dart';
import 'package:auroim/modules/introduction/IntroductionScreen.dart';
import 'package:auroim/provider_abhinav/coin_url.dart';
import 'package:auroim/provider_abhinav/go_pro_data_provider.dart';
import 'package:auroim/provider_abhinav/public_company_historical_pricing.dart';
import 'package:auroim/provider_abhinav/select_industry.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:auroim/resources/radioQusTemplateData.dart';
import 'package:auroim/splash/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constance/global.dart';
import 'constance/routes.dart';
import 'constance/themes.dart';
import 'modules/home/homeScreen.dart';
import 'package:auroim/constance/global.dart' as globals;


// Thanks for signing up to Auro. Please wait as we allow our AI engine to custom build your portfolio.
Map portfolioMap;
List marketListData = [];
var userAllDetail;

getUserDetails() async {
  print("getting user Details");
  ApiProvider request = new ApiProvider();
  // print("call set screen");
  var response = await request.getRequest('users/get_details');
  print("user detail response: $response");
  if (response != null && response != false) {
    userAllDetail = response['data'];

    print(userAllDetail.toString());
  } else {
    print("Not got user data");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await getUserDetails();
  // Admob.initialize();

  Map portfolioMap;
  Screen.keepOn(true);
  await getApplicationDocumentsDirectory().then((Directory directory) async {
    File jsonFile = new File(directory.path + "/portfolio.json");
    if (jsonFile.existsSync()) {
      portfolioMap = json.decode(jsonFile.readAsStringSync());
    } else {
      jsonFile.createSync();
      jsonFile.writeAsStringSync("{}");
      portfolioMap = {};
    }
    if (portfolioMap == null) {
      portfolioMap = {};
    }
    jsonFile = new File(directory.path + "/marketData.json");
    if (jsonFile.existsSync()) {
      marketListData = json.decode(jsonFile.readAsStringSync());
    } else {
      jsonFile.createSync();
      jsonFile.writeAsStringSync("[]");
      marketListData = [];
    }
  });

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then(
    (_) => runApp(
      MyApp(prefs: prefs),
    ),
  );
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;

  MyApp({this.prefs});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool allCoin = false;

  ApiProvider request = new ApiProvider();

  @override
  void initState() {
    super.initState();
    // GlobalInstance.getDoughnutPortfolioData();
    globals.isGoldBlack = widget.prefs != null &&
            widget.prefs.containsKey('InvestorType') &&
            widget.prefs.getString('InvestorType') != null &&
            widget.prefs.getString('InvestorType') == 'Accredited Investor'
        ? true
        : false;

    // if(userAllDetail["inv_status"] == "Accredited Investor"){
    //   globals.isGoldBlack  = false;
    // }else{
    //   globals.isGoldBlack = true;
    // }
    print(widget.prefs.getString('InvestorType'));
    print("globals main function: ${globals.isGoldBlack}");
    // getApiAllData(1);
  }

  Future<Null> getApiAllData(int index) async {
    List<CryptoCoinDetail> allCoinList = [];
    // var coindata = await getData(index);
    var coindata = await getData1(index);
    if (coindata != null) {
      if (coindata.length != 0) {
        index += coindata.length;
        if (index == 1) {
          setState(() {
            allCoinList.addAll(coindata);
          });
        } else {
          allCoinList.addAll(coindata);
          setState(() {
            // allCoinList.removeWhere((length) => length['quotes']['USD']['market_cap'] == null);
            allCoinList
                .removeWhere((length) => length.quote.uSD.marketCap == null);
            if (allCoin == true) {
              getApiAllData(index);
            }
            marketListData.addAll(allCoinList);
          });
        }
      }
    }
  }

  _decideMainPage(context) {
    if (widget.prefs != null &&
        widget.prefs.containsKey('Session_token') &&
        widget.prefs.getString('Session_token') != null &&
        widget.prefs.containsKey('DateTime') &&
        widget.prefs.getString('DateTime').isNotEmpty) {
      /*var now = new DateTime.now();
      var strTodayDateTime = new DateFormat("yyyy-MM-dd HH:mm").format(now);
      var todayDateTime = DateTime.parse("$strTodayDateTime");

      var storedDateTime =
      DateTime.parse("${widget.prefs.getString('DateTime')}");

      final daysMinDifference = todayDateTime.difference(storedDateTime).inDays;

      if (daysMinDifference >= 30) {
        setLocalStorageValues();
        return new Login();
      } else {
        return new MyHomePage();
      }*/

      return new HomeScreen();
    } else {
      return new IntroductionScreen();
    }
  }

  setScreen() {
    if (widget.prefs != null &&
        widget.prefs.containsKey('Session_token') &&
        widget.prefs.getString('Session_token') != null &&
        widget.prefs.containsKey('DateTime') &&
        widget.prefs.getString('DateTime').isNotEmpty) {
      if (userAllDetail != null && userAllDetail != false) {
        if (userAllDetail['f_name'] != null &&
            userAllDetail['l_name'] != null &&
            userAllDetail['dob'] != null &&
            userAllDetail['inv_status'] != null &&
            userAllDetail['emp_status'] != null &&
            userAllDetail['occupation'] != null &&
            userAllDetail['business_area'] != null &&
            userAllDetail['risk_appetite'] != null &&
            userAllDetail['drawdown'] != null) {
          return new HomeScreen();
        } else if (userAllDetail['f_name'] == null &&
            userAllDetail['l_name'] == null &&
            userAllDetail['dob'] == null) {
          return new UserPersonalDetails();
        } else if (userAllDetail['inv_status'] == null) {
          return new InvestorType();
        } else if (userAllDetail['emp_status'] == null &&
            userAllDetail['occupation'] == null &&
            userAllDetail['business_area'] == null) {
          return new EmpStatus(parentFrom: "${userAllDetail['inv_status']}");
        }
/*      else if(userAllDetail['risk_appetite']==null && userAllDetail['drawdown']==null)
      {
        List<RadioQusModel> questions = await getRadioQusTempData(userAllDetail['inv_status'],'piVersion');
        return new RiskAptForm(optionData: questions);
      }*/
        else {
          return new HomeScreen();
        }
      } else {
        return new HomeScreen();
      }
    } else {
      return new IntroductionScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AllCoustomTheme.getThemeData().primaryColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));



    return Container(
      color: AllCoustomTheme.getThemeData().primaryColor,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => SelectIndustry(),
          ),
          ChangeNotifierProvider(
            create: (_) => CoinUrl(),
          ),
          ChangeNotifierProvider(
            create: (_) => PublicCompanyHistoricalPricing(),
          ),
          ChangeNotifierProvider(
            create: (_) => UserDetails(),
          ),
          ChangeNotifierProvider(
            create: (_) => GoProDataProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Auro',
/*        home: FutureBuilder<dynamic>(
            future: getUserDetails(), // async work
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting: return ModalProgressHUD(
                  inAsyncCall: false,
                  opacity: 0,
                  progressIndicator: SizedBox(),
                  child: Text(""),
                );
                default:
                  if (snapshot.hasError)
                    {
                      return Container(
                        child: Text(
                          'Error: ${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontSize: 18,
                            fontFamily: "Rasa",
                          ),
                        ),
                      );
                    }
                  else
                    return HomeScreen();
              }
            },
          ),*/
          home: _decideMainPage(context),
          // routes: routes,
          theme: AllCoustomTheme.getThemeData(),
        ),
      ),
    );
  }

  var routes = <String, WidgetBuilder>{
    Routes.SPLASH: (BuildContext context) => SplashScreen(),
    Routes.Introdution: (BuildContext context) => IntroductionScreen(),
    Routes.Home: (BuildContext context) => HomeScreen(),
  };

  var logInRoutes = <String, WidgetBuilder>{
    Routes.SPLASH: (BuildContext context) => SplashScreen(),
    Routes.Home: (BuildContext context) => HomeScreen(),
  };
}
