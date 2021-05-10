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
                  singleRow(context, "Security", 'Weight', 'In-Price',
                      'Current Price', '% Return', Colors.indigo[100], 15.0),
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
                            index % 2 == 0
                                ? Colors.indigo[100]
                                : Colors.indigo[50],
                            12.0,
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  // Center(
                  //   child: Container(
                  //     height: 360,
                  //     child: Stack(
                  //       fit: StackFit.expand,
                  //       children: [
                  //         Center(
                  //           child: Column(
                  //             children: (portfolioChartData["lowest_securities"] +
                  //                 portfolioChartData["lowest_securities"])
                  //                 .map<Widget>(
                  //                   (rowData) {
                  //                 index = index + 1;
                  //                 return singleRow(
                  //                   context,
                  //                   rowData["ticker"],
                  //                   (rowData["weight"] * 100).toStringAsFixed(2),
                  //                   rowData["inprice"].toStringAsFixed(2),
                  //                   rowData["current_price"].toStringAsFixed(2),
                  //                   rowData["return"] == null
                  //                       ? "0.00"
                  //                       : rowData["return"].toStringAsFixed(2),
                  //                   index % 2 == 0
                  //                       ? Colors.indigo[100]
                  //                       : Colors.indigo[50],
                  //                   12.0,
                  //                 );
                  //               },
                  //             ).toList(),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: MediaQuery.of(context).size.width - 15,
                  //           child: ClipRect(
                  //             child: BackdropFilter(
                  //               filter: ImageFilter.blur(
                  //                 sigmaX: 5.0,
                  //                 sigmaY: 5.0,
                  //               ),
                  //               child: Container(
                  //                 color: Colors.grey.withOpacity(0.1),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Center(
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Container(
                  //                 width: MediaQuery.of(context).size.width * 0.55,
                  //                 child: Image.asset('assets/logo.png'),
                  //               ),
                  //               GestureDetector(
                  //                 onTap: () {
                  //                   Navigator.of(context).push(
                  //                     MaterialPageRoute(
                  //                       builder: (context) => PaymentPurchaseScreen(),
                  //                     ),
                  //                     // MaterialPageRoute(
                  //                     //   builder: (context) => PaymentTypes(),
                  //                     // ),
                  //                   );
                  //                 },
                  //                 child: Container(
                  //                   decoration: BoxDecoration(
                  //                     border: Border(
                  //                       bottom: BorderSide(
                  //                         color: Colors.blue,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   child: Text(
                  //                     "Click here to see entire portfolio",
                  //                     style: TextStyle(
                  //                       color: Colors.blue,
                  //                       fontWeight: FontWeight.bold,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // )
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
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: color,
          ),
          child: Center(
            child: Text(
              "$security",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: color,
          ),
          child: Center(
            child: Text(
              "$share",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: color,
          ),
          child: Center(
            child: Text(
              "$ip",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: color,
          ),
          child: Center(
            child: Text(
              cp,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: color,
          ),
          child: Center(
            child: Text(
              perReturn,
              style: TextStyle(
                fontSize: fontSize,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
