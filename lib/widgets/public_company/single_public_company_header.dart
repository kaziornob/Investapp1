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
    this.fixRate, this.ticker,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 10.0, left: 5.0, right: 3.0),
      child: Column(
        children: [
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: <Widget>[
          //     Container(
          //       width: 100,
          //       height: 100,
          //       decoration: new BoxDecoration(
          //         // border: Border.all(color: Colors.white),
          //         color: Color(0xFFfec20f),
          //         shape: BoxShape.circle,
          //         image: new DecorationImage(
          //           fit: BoxFit.fill,
          //           image: new AssetImage('assets/logo.png'),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(
          //         left: 8.0,
          //       ),
          //       child: Container(
          //         padding: EdgeInsets.all(8.0),
          //         width: MediaQuery.of(context).size.width - 120,
          //         height: 100,
          //         decoration: new BoxDecoration(
          //           border: Border.all(
          //             color: Color(0xFFfec20f),
          //             width: 1,
          //           ),
          //           borderRadius: BorderRadius.all(
          //             Radius.circular(5.0),
          //           ),
          //         ),
          //         child: SingleChildScrollView(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: <Widget>[
          //               Padding(
          //                 padding: EdgeInsets.only(left: 5.0, top: 10.0),
          //                 child: Text(
          //                   'MKT Cap:  \$$marketCapital' + 'M',
          //                   style: new TextStyle(
          //                       fontFamily: "Poppins",
          //                       color: Color(0xFFFFFFFF),
          //                       fontSize: 18.0,
          //                       letterSpacing: 0.2),
          //                   overflow: TextOverflow.clip,
          //                 ),
          //               ),
          //               Padding(
          //                 padding: EdgeInsets.only(left: 5.0, top: 15.0),
          //                 child: Text(
          //                   'HQ:',
          //                   style: new TextStyle(
          //                       fontFamily: "Poppins",
          //                       color: Color(0xFFFFFFFF),
          //                       fontSize: 18.0,
          //                       letterSpacing: 0.2),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

          KeySocialInvestIndicators(
            fixRate: fixRate,
            companyTicker: ticker,
          ),
          listItem1(context),
          // Padding(
          //   padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 8.0),
          //   child: Row(
          //     // crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Container(
          //         margin: EdgeInsets.only(top: 3.0),
          //         width: MediaQuery.of(context).size.width * 0.47,
          //         decoration: new BoxDecoration(
          //           border: Border.all(
          //             color: Color(0xFFfec20f),
          //             width: 1,
          //           ),
          //           borderRadius: BorderRadius.all(
          //             Radius.circular(2.0),
          //           ),
          //         ),
          //         child: Center(
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text(
          //               'Buy',
          //               style: new TextStyle(
          //                 fontFamily: "Poppins",
          //                 color: Color(0xFFFFFFFF),
          //                 fontSize: 18.0,
          //                 letterSpacing: 0.2,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       Container(
          //         margin: EdgeInsets.only(top: 3.0),
          //         width: MediaQuery.of(context).size.width * 0.47,
          //         decoration: new BoxDecoration(
          //           border: Border.all(
          //             color: Color(0xFFfec20f),
          //             width: 1,
          //           ),
          //           borderRadius: BorderRadius.all(
          //             Radius.circular(2.0),
          //           ),
          //         ),
          //         child: Center(
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text(
          //               'Sell',
          //               style: new TextStyle(
          //                 fontFamily: "Poppins",
          //                 color: Color(0xFFFFFFFF),
          //                 fontSize: 18.0,
          //                 letterSpacing: 0.2,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // )
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
            : singleRow(context, "Market Cap($currency)", Colors.indigo[100],
            "${double.parse(marketCapLocal.toString().replaceAll(",", ""))
                .toStringAsFixed(3)}" + "M"),
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
        width: MediaQuery
            .of(context)
            .size
            .width - 20,
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
              padding: const EdgeInsets.only(right: 8.0),
              child: Center(child: Text(value)),
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
        width: MediaQuery
            .of(context)
            .size
            .width - 20,
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
