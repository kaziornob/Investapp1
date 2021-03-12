import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/widgets/get_area_chart_view.dart';
import 'package:flutter/material.dart';

class PublicCompaniesList extends StatefulWidget {
  final Axis scrollDirection;

  PublicCompaniesList({this.scrollDirection});

  @override
  _PublicCompaniesListState createState() => _PublicCompaniesListState();
}

class _PublicCompaniesListState extends State<PublicCompaniesList> {
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _featuredCompaniesProvider.getPublicCompanyList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // print("yes baby");
          // print(snapshot.data);
          return Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.white,)),
            height: widget.scrollDirection == null ? 300 : null,
            child: ListView.builder(
                scrollDirection: widget.scrollDirection == null
                    ? Axis.horizontal
                    : widget.scrollDirection,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  print(snapshot.data[0]);
                  return GetAreaChartView(
                    // newSalesData: [
                    //   NewSalesData(2010, 35),
                    //   NewSalesData(2011, 28),
                    //   NewSalesData(2012, 34),
                    //   NewSalesData(2013, 32),
                    //   NewSalesData(2014, 40),
                    // ],
                    color: [
                      Colors.blue[50],
                      Colors.blue[200],
                      Colors.blue,
                    ],
                    stops: [0.0, 0.5, 1.0],
                    companyData: snapshot.data[index],
                  );
                }),
          );
        } else {
          return Container(
            height: 300,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.redAccent,
                valueColor: AlwaysStoppedAnimation(Colors.green),
                strokeWidth: 10,
              ),
            ),
          );
        }
      },
    );
  }
}
