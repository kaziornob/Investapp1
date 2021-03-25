import 'package:flutter/material.dart';

class SinglePublicCompanyDetailsFundamentalTab extends StatefulWidget {
  final marketCapital;
  final netDebt;
  final roe3yr;
  final currency;
  final equityBeta;
  final marketCapLocal;
  final fixRate;

  SinglePublicCompanyDetailsFundamentalTab({
    this.marketCapital,
    this.currency,
    this.equityBeta,
    this.netDebt,
    this.roe3yr,
    this.marketCapLocal,
    this.fixRate,
  });

  @override
  _SinglePublicCompanyDetailsFundamentalTabState createState() =>
      _SinglePublicCompanyDetailsFundamentalTabState();
}

class _SinglePublicCompanyDetailsFundamentalTabState
    extends State<SinglePublicCompanyDetailsFundamentalTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        listItem3(),
        SizedBox(
          height: 15,
        ),
        listItem2(),
        SizedBox(
          height: 15,
        ),
        listItem1(),
      ],
    );
  }

  listItem3() {
    return Column(
      children: [
        Container(
          // decoration: BoxDecoration(border: Border.all()),
          width: MediaQuery.of(context).size.width - 15,
          height: 40,
          child: Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Auro Stock Pitches & Research",
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          // decoration: BoxDecoration(border: Border.all()),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.green,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey),
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Text(
                          "+9",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 8.0),
            child: Text(
              "Sky, Manuela (Ela), Lamia Lauren, Mathiues and 4 more",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
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

  listItem2() {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                  "KEY FINANCIALS",
                  style: TextStyle(
                      // color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto"),
                ),
              ),
            ],
          ),
          singleRow(
              context, "Revenue Growth(3-years)", Colors.indigo[50], "3.7"),
          singleRow(context, "Eps Growth(3-years)", Colors.indigo[100], "3.7"),
          singleRow(context, "EBIDTA(TTM)", Colors.indigo[50], "32.78"),
          singleRow(context, "Revenue(TTM)", Colors.indigo[100], "294,13500M"),
          singleRow(
              context, "Gross Profit Margin(TTM)", Colors.indigo[50], "38.78"),
          singleRow(
              context, "Net Profit Margin(TTM)", Colors.indigo[100], "21.73%"),
          singleRow(
              context, "Earnings Per Share(TTM)", Colors.indigo[50], "82.9%"),
        ],
      ),
    );
  }
}
