import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuroStars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          smallImage(
              context,
              "assets/auro_asia_quantimental_portfolio_header.jpg",
              "assets/auro_asia_quantimental_portfolio.jpg"),
          smallImage(
              context,
              "assets/auro_asia_technology_portfolio_header.jpg",
              "assets/auro_asia_technology_portfolio.jpg"),
          smallImage(
              context,
              "assets/auro_global_consumer_portfolio_header.jpg",
              "assets/auro_global_consumer_portfolio.jpg"),
          smallImage(
              context,
              "assets/auro_global_thematic_portfolio_header.jpg",
              "assets/auro_global_thematic_portfolio.jpg"),
          smallImage(
              context,
              "assets/auro_india_healthcare_portfolio_header.jpg",
              "assets/auro_india_healthcare_portfolio.jpg"),
          smallImage(context, "assets/auro_us_consumer_portfolio_header.jpg",
              "assets/auro_us_consumer_portfolio.jpg"),
        ],
      ),
    );
  }

  // AssetImage('assets/logo.png')

  smallImage(context, imagePath, bigImagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => bigImage(bigImagePath, context),
            ),
          );
        },
        child: Container(
          // decoration: BoxDecoration(
          //   border: Border.all(),
          // ),
          height: 200,
          width: 250,
          child: Image.asset(imagePath),
        ),
      ),
    );
  }

  bigImage(imagePath, context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height - 20,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
