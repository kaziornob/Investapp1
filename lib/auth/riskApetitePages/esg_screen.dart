import 'dart:convert';

import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/modules/home/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class EsgScreen extends StatefulWidget {
  EsgScreen({Key key}) : super(key: key);

  @override
  _EsgScreenState createState() => _EsgScreenState();
}

class _EsgScreenState extends State<EsgScreen> {
  ApiProvider request = new ApiProvider();
  String selected =
      "If you ascribe high importance to these factors alongside financial factors in your investment decision making, then click here";
  String skipSelected = "";
  String valueSelected = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/esg.png",
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Container(
                      child: Text(
                        "Auro AI’s proprietary ESG framework measures the environmental, social and governance factors that your investment in each security/company can have",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Roboto",
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  RadioListTile(
                    title: Text(
                      "If you ascribe high importance to these factors alongside financial factors in your investment decision making, then click here",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Roboto",
                        fontSize: 15,
                      ),
                    ),
                    value: selected,
                    activeColor: Color(0xFFD8AF4F),
                    groupValue: valueSelected,
                    onChanged: (value) {
                      // print("newValue: $value");
                      setState(() {
                        valueSelected = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(
                      "Skip for now",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Roboto",
                        fontSize: 15,
                      ),
                    ),
                    value: selected,
                    activeColor: Color(0xFFD8AF4F),
                    groupValue: skipSelected,
                    onChanged: (value) {
                      // print("newValue: $value");
                      setState(() {
                        skipSelected = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
                left: 14,
                right: 10,
                top: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: _submit,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFFD8AF4F),
                      child: Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _submit() async {
    var tempJsonReq = {
      "ETF": 0,
      "Individual Securities": 0,
      "assetclass_weights": {
        "Equity": {
          "min_weight": 0,
          "max_weight": 100,
        },
        "Crypto": {
          "min_weight": 0,
          "max_weight": 100,
        },
        "Real_Estate": {
          "min_weight": 0,
          "max_weight": 100,
        },
        "Commodity": {
          "min_weight": 0,
          "max_weight": 100,
        },
        "Private_Equity": {
          "min_weight": 0,
          "max_weight": 100,
        },
        "Fixed Income": {
          "min_weight": 0,
          "max_weight": 100,
        },
        "Hedge_Fund": {
          "min_weight": 0,
          "max_weight": 100,
        },
      },
      "assetclass_country_weights": {},
      "sector_weights": {},
      "assetclass_country_sector_weights": {},
      "One Off Deposit": 1000000,
      "Monthly Deposit": 0,
      "apply_ESG_filter": valueSelected == "" ? 0 : 1,
    };

    String jsonReq = jsonEncode(tempJsonReq);

    var jsonReqResp =
        await request.postSubmitResponse('users/add_gopro_details', jsonReq);

    var result = json.decode(jsonReqResp.body);
    print("post submit response: $result");

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      if (result != null &&
          result.containsKey('auth') &&
          result['auth'] == true) {
        HelperClass.showLoading(
          context,
          "Thanks for signing up to Auro. Please wait as we allow our AI engine to custom build your portfolio.Given the complex analytics involved, this could take a few minutes, so please be patient.",
          true,
        );

        createPortfolioData();
      }
    } else {
      Toast.show("Some Error Occurred", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Future<void> createPortfolioData() async {
    print("getDoughnutPortfolioData called");
    var response = await request.getRequest('users/run_algo');
    print("portfolio chart list: $response");
    if (response != null &&
        response != false &&
        response.containsKey('auth') &&
        response['auth'] == true) {
      Navigator.pop(context);

      Toast.show(response["message"], context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        ModalRoute.withName("/Home"),
      );
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
