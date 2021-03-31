import 'package:auroim/constance/themes.dart';
import 'package:auroim/widgets/private_deals_marketplace/buy_company_stocks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:url_launcher/url_launcher.dart';

import 'appbar_widget.dart';

class SingleCompanyDetails extends StatefulWidget {
  final companyDetails;

  SingleCompanyDetails({this.companyDetails});

  @override
  _SingleCompanyDetailsState createState() => _SingleCompanyDetailsState();
}

class _SingleCompanyDetailsState extends State<SingleCompanyDetails> {
  SuperTooltip tooltip;

  @override
  void initState() {
    print("in sonhhhh");
    print("company data : ${widget.companyDetails.toString()}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff5A56B9),
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width - 20,
                  height: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        // decoration: BoxDecoration(
                        //   border: Border.all(),
                        // ),
                        child:
                            Image.network(widget.companyDetails["logo_link"]),
                      ),
                      Text(
                        widget.companyDetails["company_name"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          fontFamily: 'Roboto',
                          color: Color(0xff5A56B9),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 25,
                        // decoration: BoxDecoration(border: Border.all(),),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                widget.companyDetails["company_description"],
                                style: TextStyle(
                                    color: AllCoustomTheme
                                        .getNewSecondTextThemeColor(),
                                    fontFamily: "Roboto",
                                    fontSize: 14.5,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0.1),
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 25,
                          height: 60,
                          // decoration: BoxDecoration(
                          //   border: Border.all(),
                          // ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                // decoration: BoxDecoration(
                                //   border: Border.all(),
                                // ),
                                height: 60,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Funding",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                    Text(
                                      widget.companyDetails["total_funding"] ?? "",
                                      style: TextStyle(
                                          color: AllCoustomTheme
                                              .getNewSecondTextThemeColor(),
                                          fontFamily: "Roboto",
                                          fontSize: 14.5,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0.1),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Founders",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: lisOfFounders(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 25,
                          height: 60,
                          // decoration: BoxDecoration(
                          //   border: Border.all(),
                          // ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Headquarters",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    height: 40,
                                    // decoration:
                                    //     BoxDecoration(border: Border.all()),
                                    child: SingleChildScrollView(
                                      child: Text(
                                        widget.companyDetails["location"] ?? "",
                                        style: TextStyle(
                                            color: AllCoustomTheme
                                                .getNewSecondTextThemeColor(),
                                            fontFamily: "Roboto",
                                            fontSize: 14.5,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: 0.1),
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                // decoration: BoxDecoration(
                                //   border: Border.all(),
                                // ),
                                height: 60,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Age",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                    Text(
                                      "${date(widget.companyDetails["founded_date"])} Years",
                                      style: TextStyle(
                                          color: AllCoustomTheme
                                              .getNewSecondTextThemeColor(),
                                          fontFamily: "Roboto",
                                          fontSize: 14.5,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0.1),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Container(
                          height: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Website",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              GestureDetector(
                                onTap: () => launch(
                                    "https://${widget.companyDetails["web_link"]}"),
                                child: Text(
                                  widget.companyDetails["web_link"] ?? "",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Color(0xff5A56B9),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 15, bottom: 10),
                child: Container(
                  height: 150,
                  child: Row(
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width / 2.3,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff5A56B9),
                          ),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Deal Type:",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 14.5,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.1),
                                ),
                                Text(
                                  widget.companyDetails["deal_type"] ?? "",
                                  style: TextStyle(
                                      color: Color(0xff7499C6),
                                      fontFamily: "Roboto",
                                      fontSize: 30,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.1),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Most Recent Valuations",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 14.5,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.1),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      child: Text(
                                        widget.companyDetails["valuation"] ?? 0.0,
                                        style: TextStyle(
                                            color: Color(0xff7499C6),
                                            fontFamily: "Roboto",
                                            fontSize: 30,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.1),
                                      ),
                                      width: 120,
                                      // decoration:
                                      //     BoxDecoration(border: Border.all()),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Tooltip(
                                        message:
                                            "Last Funding Round Date \n ${widget.companyDetails["founded_date"]}",
                                        child: Icon(
                                          Icons.help,
                                          color: Color(0xff7499C6),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.3,
                              child: RaisedButton(
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Color(0xff7499C6),
                                  ),
                                ),
                                color: Color(0xff7499C6),
                                child: Text(
                                  "BUY",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BuyCompanyStocks(
                                        companyDetails: widget.companyDetails,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.3,
                              child: RaisedButton(
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Color(0xff7499C6),
                                  ),
                                ),
                                color: Color(0xff7499C6),
                                child: Text(
                                  "ADD TO WATCHLIST",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: "Roboto",
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onTapQuestionIcon() {
    if (tooltip != null && tooltip.isOpen) {
      tooltip.close();
      return;
    }

    // var renderBox = context.findRenderObject() as RenderBox;
    // final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    // var targetGlobalCenter = renderBox
    //     .localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);

    // We create the tooltip on the first use
    tooltip = SuperTooltip(
      popupDirection: TooltipDirection.up,
      maxWidth: 150,
      maxHeight: 120,
      content: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Last Funding Round Date"),
            Text(
              "April 2018",
              style: TextStyle(
                color: Color(0xff7499C6),
              ),
            )
          ],
        ),
      ),
      dismissOnTapOutside: true,
    );

    tooltip.show(context);
  }

  date(date) {
    print("date here");
    print(date.toString());
    int now = DateTime.now().year;
    int companyYears;
    if(date != null){
      if (date.length == 4) {
        companyYears = now - int.parse(date);
      } else {
        companyYears = now - DateFormat("dd-MM-yyyy").parse(date).year;
      }
      return companyYears;
    }else{
      return 0;
    }
  }

  List<Widget> lisOfFounders() {
    List<Widget> all = [];
    if(widget.companyDetails["founders"] != null){
      widget.companyDetails["founders"].split(", ").forEach(
            (e) => all.add(Text(
          e,
          style: TextStyle(
              color: AllCoustomTheme.getNewSecondTextThemeColor(),
              fontFamily: "Roboto",
              fontSize: 14.5,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.1),
        )),
      );
    }

    return all;
  }
}
