import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/widgets/crypto_marketplace/all_crypto_list.dart';
import 'package:auroim/widgets/crypto_marketplace/crypto_coins_marketplace.dart';
import 'package:auroim/widgets/crypto_marketplace/all_cryptocurrencies_list.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;

import '../go_to_marketplace_button.dart';

class CryptoMarketplace extends StatefulWidget {
  @override
  _CryptoMarketplaceState createState() => _CryptoMarketplaceState();
}

class _CryptoMarketplaceState extends State<CryptoMarketplace> {


  @override
  void initState() {
    print("Crypto Marketplace init");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 100,
            padding: const EdgeInsets.only(
              bottom: 8,
              top: 10,
            ),
            child: Center(
              child: Text(
                "Crypto Marketplace",
                style: TextStyle(
                    color: AllCoustomTheme.getHeadingThemeColors(),
                    fontSize: ConstanceData.SIZE_TITLE20,
                    fontFamily: "Rosarivo",
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.1),
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AllCoustomTheme.getHeadingThemeColors(),
                  width: 2,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
            child: Container(
              // margin: EdgeInsets.only(left: 35.0,right: 20.0),
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.07,
                  right: MediaQuery.of(context).size.width * 0.03),
              child: Text(
                "The Cryptocurrency marketplace is your opportunity to invest in trending cryptocurrencies,"
                "All you need to do is select the coin that you want to trade and press "
                "the buy button.",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: AllCoustomTheme.getNewSecondTextThemeColor(),
                    fontSize: 14.5,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0.2),
              ),
            ),
          ),
          globals.isGoldBlack
              ? AllCryptoListBlack(
                  sortingType: "market_cap",
                )
              : AllCryptocurrenciesList(
                  sortingType: "market_cap",
                ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
