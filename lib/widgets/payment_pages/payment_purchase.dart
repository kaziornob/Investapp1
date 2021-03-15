import 'package:auroim/constance/themes.dart';
import 'package:auroim/widgets/private_deals_marketplace/appbar_widget.dart';
import 'package:flutter/material.dart';

class PaymentPurchaseScreen extends StatefulWidget {
  @override
  _PaymentPurchaseScreenState createState() => _PaymentPurchaseScreenState();
}

class _PaymentPurchaseScreenState extends State<PaymentPurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(65.0),
        //   child: AppBar(
        //     bottom: PreferredSize(
        //       preferredSize: Size.fromHeight(3),
        //       child: Container(
        //         height: 4,
        //         color: Colors.grey[400],
        //       ),
        //     ),
        //     automaticallyImplyLeading: false,
        //     backgroundColor: Color(0xff7499C6),
        //     title: AppbarWidget(),
        //   ),
        // ),
        body: Container(
          decoration: BoxDecoration(border: Border.all()),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            padding: EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width - 80,
            height: MediaQuery.of(context).size.height - 20,
            child: Column(
              children: [
                Container(
                  // decoration: BoxDecoration(border: Border.all()),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width-60,
                  child: Image.asset('assets/logo.png'),
                ),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff5A56B9),),
                  ),
                  height: 350,
                  width: MediaQuery.of(context).size.width - 50,
                  child: Column(
                    children: [
                      oneRow("SEE TOP 1 HOLDING [\$9]"),
                      oneRow("SEE TOP 3 HOLDING [\$15]"),
                      oneRow("SEE TOP 5 HOLDING [\$25]"),
                      oneRow("See All Holdings- Snapshot\n[\$49]"),
                      oneRow(
                          "See All Holdings- Dynamic\n[\$99 + 9.99 MONTHLY]"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  oneRow(text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 50,
            // decoration: BoxDecoration(
            //   border: Border.all(color: Color(0xff5A56B9),),
            // ),
            width: MediaQuery.of(context).size.width - 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  // decoration: BoxDecoration(border: Border.all()),
                  padding: EdgeInsets.only(top: 6,left: 10,),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xff5A56B9),
                        radius: 5.0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            text,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 18,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
