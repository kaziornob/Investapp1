import 'package:flutter/material.dart';

class FullListOfSecurities extends StatefulWidget {
  final allSecurities;

  const FullListOfSecurities({Key key, this.allSecurities}) : super(key: key);

  @override
  _FullListOfSecuritiesState createState() => _FullListOfSecuritiesState();
}

class _FullListOfSecuritiesState extends State<FullListOfSecurities> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 20,
          ),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Divider(
                    thickness: 1,
                    indent: 5,
                  ),
                  singleRow(context, "Security", 'Weight', 'In-Price',
                      'Current Price', '% Return', Color(0xFFD8AF4F), 15.0),
                  Divider(
                    thickness: 1,
                    indent: 5,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 60,
                    child: ListView(
                      children: widget.allSecurities.map<Widget>(
                        (rowData) {
                          index = index + 1;
                          return singleRow(
                            context,
                            rowData["security_name"],
                            (rowData["weight"] * 100).toStringAsFixed(2),
                            rowData["inprice"].toStringAsFixed(2),
                            rowData["current_price"].toStringAsFixed(2),
                            rowData["return"] == null
                                ? "0.00"
                                : (((rowData["current_price"] /
                                                rowData["inprice"]) -
                                            1) *
                                        100)
                                    .toStringAsFixed(2),
                            Colors.black,
                            12.0,
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget singleRow(
      context, security, share, ip, cp, perReturn, color, fontSize) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          child: Center(
            child: Text(
              "$security",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                color: color,
              ),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          child: Center(
            child: Text(
              "$share",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                color: color,
              ),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          child: Center(
            child: Text(
              "$ip",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                color: color,
              ),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          child: Center(
            child: Text(
              cp,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                color: color,
              ),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          child: Center(
            child: Text(
              perReturn,
              style: TextStyle(
                fontSize: fontSize,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
