import 'package:auroim/widgets/private_deals_marketplace/single_company_details_page.dart';
import 'package:flutter/material.dart';

class AllCompaniesSingleItem extends StatelessWidget {
  final companyDetails;

  AllCompaniesSingleItem({this.companyDetails});

  final List<BoxFit> listBoxFit = [BoxFit.fitWidth, BoxFit.contain];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Color(0xff5A56B9),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 4.0,
                bottom: 4.0,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width - 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                        child: Container(
                          // width: MediaQuery.of(context).size.height / 8,
                          child: Text(
                            companyDetails["company_name"],
                            style: TextStyle(
                              color: Color(0xff1D6177),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 16,
                          // width: MediaQuery.of(context).size.height / 8,
                          // decoration: BoxDecoration(
                          //   border: Border.all(),
                          // ),
                          child: Image.network(
                            companyDetails["logo_link"],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Container(
                    // decoration: BoxDecoration(border: Border.all()),
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(
                      companyDetails["company_description"],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        companyDetails["valuation"] == ""
                            ? "N/A"
                            : companyDetails["valuation"],
                        style: TextStyle(
                          color: Color(0xff5A56B9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Last Valuation"),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        companyDetails["fund_round_series"],
                        style: TextStyle(
                          color: Color(0xff5A56B9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Last Funding Round"),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SingleCompanyDetailsPage(
                          companyDetails: companyDetails,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Learn More",
                    style: TextStyle(
                      color: Color(0xff5A56B9),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
