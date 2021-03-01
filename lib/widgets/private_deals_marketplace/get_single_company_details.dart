import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/widgets/private_deals_marketplace/single_company_details.dart';
import 'package:flutter/material.dart';

import 'appbar_widget.dart';

class GetSingleCompany extends StatefulWidget {
  final companyData;

  GetSingleCompany({this.companyData});

  @override
  _GetSingleCompanyState createState() => _GetSingleCompanyState();
}

class _GetSingleCompanyState extends State<GetSingleCompany> {
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  @override
  Widget build(BuildContext context) {
    print("get single caompany data");
    print(widget.companyData["company_id"]);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(3),
            child: Container(
              height: 4,
              color: Colors.grey[400],
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff7499C6),
          title: AppbarWidget(),
        ),
      ),
      body: FutureBuilder(
        future: _featuredCompaniesProvider
            .getSingleCompanyById(widget.companyData["company_id"]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleCompanyDetails(companyDetails: snapshot.data,);
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
