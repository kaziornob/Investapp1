import 'package:flutter/material.dart';

class AllCryptoMetricsData extends StatelessWidget {
  final metrics;

  AllCryptoMetricsData({this.metrics});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            singleRow(context, "Trading Volume", Colors.indigo[100], ""),
            singleRow(context, "Volume / Market Cap", Colors.indigo[50],
                getMarketCap(metrics)),
            singleRow(context, "24h Low / 24h High", Colors.indigo[100],
                get24hLowHigh(metrics)),
            singleRow(context, "7d Low / 7d High", Colors.indigo[50],
                get7dLowHigh(metrics)),
            singleRow(context, "Market Cap Rank", Colors.indigo[100],
                getMarketCapRank(metrics)),
            singleRow(context, "All Time High", Colors.indigo[50],getAllTimeHigh(metrics)),
            singleRow(context, "Gas Price (Median)", Colors.indigo[100],getAllTimeLow(metrics)),
            singleRow(context, "Stock-to-Flow Ratio", Colors.indigo[50],""),
            singleRow(context, "SOPR ", Colors.indigo[100],""),
            singleRow(context, "Circulating Supply ", Colors.indigo[50],""),
          ],
        ),
      ),
    );
  }

  singleRow(context, text, color, value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: (MediaQuery.of(context).size.width / 2) - 4,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: color,
          ),
          child: Center(child: Text(text)),
        ),
        Container(
          width: (MediaQuery.of(context).size.width / 2) - 4,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: color,
          ),
          child: Center(child: Text(value,textAlign: TextAlign.center,)),
        ),
      ],
    );
  }

  getMarketCap(coinDetails) {
    List list = [];
    if (coinDetails != null) {
      list = coinDetails[4].split("Volume / Market Cap");
      var marketCap = list[list.length - 1];
      print("marketCap: $marketCap");
      return marketCap;
    } else {
      return "";
    }
  }

  getAllTimeHigh(coinDetails) {
    List list = [];
    if (coinDetails != null) {
      list = coinDetails[8].split("All-Time High");
      var marketCap = list[list.length - 1];
      print("marketCap: $marketCap");
      return marketCap;
    } else {
      return "";
    }
  }

  getAllTimeLow(coinDetails) {
    List list = [];
    if (coinDetails != null) {
      list = coinDetails[10].split("All-Time Low");
      var marketCap = list[list.length - 1];
      print("marketCap: $marketCap");
      return marketCap;
    } else {
      return "";
    }
  }

  get7dLowHigh(coinDetails) {
    List list = [];
    if (coinDetails != null) {
      list = coinDetails[6].split("7d Low / 7d High");
      var marketCap = list[list.length - 1];
      print("marketCap: $marketCap");
      return marketCap;
    } else {
      return "";
    }
  }

  get24hLowHigh(coinDetails) {
    List list = [];
    if (coinDetails != null) {
      list = coinDetails[5].split("24h Low / 24h High");
      var marketCap = list[list.length - 1];
      print("marketCap: $marketCap");
      return marketCap;
    } else {
      return "";
    }
  }

  getMarketCapRank(coinDetails) {
    List list = [];
    if (coinDetails != null) {
      list = coinDetails[7].split("Market Cap Rank");
      var marketCapRank = list[list.length - 1];
      print("marketCapRank: $marketCapRank");
      return marketCapRank;
    } else {
      return "";
    }
  }

  get24hChange(coinDetails) {
    // List list = [];
    if (coinDetails != null) {
      String coin24hChange = coinDetails["24h"];
      // var coin24hChange = list[list.length - 1];
      print("coin24hChange: $coin24hChange");
      return coin24hChange;
    } else {
      return "";
    }
  }

  getPriceOfCoin(coinDetails) {
    List list = [];
    if (coinDetails != null) {
      list = coinDetails[0].split("\$");
      var price = list[list.length - 1];
      print("price: $price");
      return price;
    } else {
      return "";
    }
  }
}
