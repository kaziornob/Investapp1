import 'package:auroim/widgets/public_company/auro_paper_portfolio_performance.dart';
import 'package:auroim/widgets/public_company/company_historical_performance.dart';
import 'package:flutter/material.dart';

class SinglePublicCompanyDetailsTechnicalTab extends StatefulWidget {
  final marketCapital;
  final netDebt;
  final roe3yr;
  final currency;
  final equityBeta;
  final marketCapLocal;
  final fixRate;
  final ticker;

  SinglePublicCompanyDetailsTechnicalTab({
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
  _SinglePublicCompanyDetailsTechnicalTabState createState() =>
      _SinglePublicCompanyDetailsTechnicalTabState();
}

class _SinglePublicCompanyDetailsTechnicalTabState
    extends State<SinglePublicCompanyDetailsTechnicalTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        // AuroPaperPortfolioPerformace(),
        PublicCompanyHistoricalPerformance(
          ticker: widget.ticker,
        ),
        SizedBox(
          height: 20.0,
        ),
        listItem1(),
      ],
    );
  }

  listItem1() {
    // print("list item 1");
    // print(widget.marketCapital.runtimeType.toString());
    // print(widget.marketCapLocal.runtimeType.toString());

    // print();

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Padding(
          //   padding: EdgeInsets.only(top: 4),
          //   child: singleRow(context, "Key Stats : ", Colors.white, ""),
          // ),
          Container(
            height: 5,
            width: MediaQuery.of(context).size.width - 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              color: Color(0xff5A56B9),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 8,
                  right: 4.0,
                  top: 4.0,
                  bottom: 4.0,
                ),
                child: Text(
                  "Key Stats",
                  style: TextStyle(
                      // color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto"),
                ),
              ),
            ],
          ),
          singleRow(context, "Market Cap(USD)", Colors.indigo[50],
              "${widget.marketCapital.toStringAsFixed(3)}" + "M"),
          widget.currency == "USD"
              ? SizedBox()
              : singleRow(
                  context,
                  "Market Cap(${widget.currency})",
                  Colors.indigo[100],
                  "${double.parse(widget.marketCapLocal.toString().replaceAll(",", "")).toStringAsFixed(3)}" +
                      "M"),
          singleRowWithToolTip(
              context,
              "Enterprise Value(USD)",
              widget.currency == "USD" ? Colors.indigo[100] : Colors.indigo[50],
              "58.78"),
          singleRowWithToolTip(
              context,
              "Net Debt(USD)",
              widget.currency == "USD" ? Colors.indigo[50] : Colors.indigo[100],
              "${widget.netDebt.toStringAsFixed(3)}" + "M"),
          singleRowWithToolTip(
              context,
              "RoE",
              widget.currency == "USD" ? Colors.indigo[100] : Colors.indigo[50],
              "${widget.roe3yr}"),
          singleRowWithToolTip(
              context,
              "Beta",
              widget.currency == "USD" ? Colors.indigo[50] : Colors.indigo[100],
              "1"),
          singleRowWithToolTip(
              context,
              "Dividend yield",
              widget.currency == "USD" ? Colors.indigo[100] : Colors.indigo[50],
              "2%"),
        ],
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
        width: MediaQuery.of(context).size.width - 15,
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
              padding: const EdgeInsets.only(right: 8.0),
              child: Center(child: Text(value)),
            ),
          ],
        ),
      ),
    );
  }
}
