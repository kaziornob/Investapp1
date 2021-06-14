import 'package:auroim/widgets/public_company/key_social_invest_indicators.dart';
import 'package:flutter/material.dart';

class SinglePublicCompanyHeader extends StatelessWidget {
  final marketCapital;
  final netDebt;
  final roe3yr;
  final currency;
  final equityBeta;
  final marketCapLocal;
  final fixRate;
  final ticker;

  SinglePublicCompanyHeader({
    this.marketCapital,
    this.currency,
    this.equityBeta,
    this.netDebt,
    this.roe3yr,
    this.marketCapLocal,
    this.fixRate,
    this.ticker,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 10.0, left: 5.0, right: 3.0),
      child: Column(
        children: [

          KeySocialInvestIndicators(
            fixRate: fixRate,
            companyTicker: ticker,
          ),
          listItem1(context),
        ],
      ),
    );
  }

  listItem1(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 4, bottom: 4.0),
          child: Container(
            width: 300,
            child: Center(
              child: Text(
                "Key Performance Indicators : ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Rosarivo",
                ),
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFfec20f),
                  width: 2,
                ),
              ),
            ),
          ),
        ),
        singleRow(context, "Market Cap(USD)", Colors.indigo[50],
            "${marketCapital.toStringAsFixed(3)}" + "M"),
        currency == "USD"
            ? SizedBox()
            : singleRow(
                context,
                "Market Cap($currency)",
                Colors.indigo[100],
                "${double.parse(marketCapLocal.toString().replaceAll(",", "")).toStringAsFixed(3)}" +
                    "M"),
        singleRowWithToolTip(
            context,
            "Enterprise Value(USD)",
            currency == "USD" ? Colors.indigo[100] : Colors.indigo[50],
            "58.78"),
        singleRowWithToolTip(
            context,
            "Net Debt(USD)",
            currency == "USD" ? Colors.indigo[50] : Colors.indigo[100],
            "${netDebt.toStringAsFixed(3)}" + "M"),
        singleRowWithToolTip(
            context,
            "RoE",
            currency == "USD" ? Colors.indigo[100] : Colors.indigo[50],
            "${roe3yr.toStringAsFixed(3)}"),
        singleRowWithToolTip(context, "Beta",
            currency == "USD" ? Colors.indigo[50] : Colors.indigo[100], "1"),
        singleRowWithToolTip(context, "Dividend yield",
            currency == "USD" ? Colors.indigo[100] : Colors.indigo[50], "2%"),
      ],
    );
  }

  singleRowWithToolTip(context, text, color, value) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color),
          color: color,
        ),
        height: 25,
        width: MediaQuery.of(context).size.width - 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Center(
                  child: Row(
                children: [
                  Text(text),
                  SizedBox(
                    width: 2,
                  ),
                  Tooltip(
                    message: "$text",
                    child: Icon(
                      Icons.help,
                      size: 15,
                    ),
                  ),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
              ),
              child: Center(
                child: Text(value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  singleRow(context, text, color, value) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color),
          color: color,
        ),
        height: 25,
        width: MediaQuery.of(context).size.width - 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Center(child: Text(text)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Center(child: Text(value)),
            ),
          ],
        ),
      ),
    );
  }
}
