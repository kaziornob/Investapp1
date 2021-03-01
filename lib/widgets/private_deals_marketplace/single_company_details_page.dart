import 'package:auroim/widgets/private_deals_marketplace/single_company_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'appbar_widget.dart';

class SingleCompanyDetailsPage extends StatefulWidget {
  final companyDetails;

  SingleCompanyDetailsPage({this.companyDetails});

  @override
  _SingleCompanyDetailsPageState createState() =>
      _SingleCompanyDetailsPageState();
}

class _SingleCompanyDetailsPageState extends State<SingleCompanyDetailsPage> {
  @override
  Widget build(BuildContext context) {
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
      body: SingleCompanyDetails(
        companyDetails: widget.companyDetails,
      ),
    );
  }
}
