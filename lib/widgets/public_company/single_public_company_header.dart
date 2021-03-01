import 'package:auroim/widgets/public_company/key_social_invest_indicators.dart';
import 'package:flutter/material.dart';

class SinglePublicCompanyHeader extends StatelessWidget {
  final marketCapital;

  SinglePublicCompanyHeader({this.marketCapital});

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
          KeySocialInvestIndicators(),
          Padding(
            padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 8.0),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 3.0),
                  width: (MediaQuery.of(context).size.width/3)-10,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xff7499C6),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                     color: Color(0xff7499C6),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Ask Auro',
                        style: new TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18.0,
                          letterSpacing: 0.2,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 3.0),
                  width: (MediaQuery.of(context).size.width/3)-10,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xff7499C6),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                    color: Color(0xff7499C6),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Trade',
                        style: new TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18.0,
                          letterSpacing: 0.2,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 3.0),
                  width: (MediaQuery.of(context).size.width/3)-10,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xff7499C6),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                    color: Color(0xff7499C6),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Follow',
                        style: new TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18.0,
                          letterSpacing: 0.2,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
}
