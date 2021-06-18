import 'dart:convert';
import 'dart:io';
import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/provider_abhinav/stock_pitch_provider.dart';
import 'package:auroim/reusable_widgets/customButton.dart';
import 'package:auroim/widgets/aws/aws_client.dart';
import 'package:auroim/widgets/stock_and_portfolio_pitch/stock_pitch_comments_section.dart';
import 'package:auroim/widgets/stock_and_portfolio_pitch/stock_pitch_return_chart.dart';
import 'package:auroim/widgets/stock_and_portfolio_pitch/stock_pitch_return_drawdown.dart';
import 'package:auroim/widgets/stock_and_portfolio_pitch/stock_pitch_social_info.dart';
import 'package:auroim/widgets/stock_and_portfolio_pitch/stock_pitch_video.dart';
import 'package:auroim/widgets/stock_and_portfolio_pitch/topic_tags.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ShowStockPitchPage extends StatefulWidget {
  final stockPitchData;
  final String userEmail;

  const ShowStockPitchPage({
    Key key,
    this.stockPitchData,
    this.userEmail,
  }) : super(key: key);

  @override
  _ShowStockPitchPageState createState() => _ShowStockPitchPageState();
}

class _ShowStockPitchPageState extends State<ShowStockPitchPage> {
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();
  List monthList = [
    "Jan",
    "Feb",
    "Mar",
    "April",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  AWSClient awsClient = AWSClient();

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(widget.stockPitchData["date"]);
    print("date : ${date.year}");
    print(widget.stockPitchData["videoUrl"]);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Text(
                          "${widget.stockPitchData["company_name"]} : ${widget.stockPitchData["title"]}"
                              .toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: "RosarioSemiBold",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FutureBuilder(
                      future:
                          _featuredCompaniesProvider.getSinglePublicCompanyData(
                        widget.stockPitchData["stock_id"],
                        "head",
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          return Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              width: 100,
                              child: Image.network(
                                  "${snapshot.data["logo_img_name"]}"),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        widget.stockPitchData["isLong"] == 0
                            ? "Short / SELL"
                            : "Long / BUY",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD8AF4F),
                          fontFamily: "RosarioSemiBold",
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                // Consumer<StockPitchProvider>(
                //   builder: (context, pitchProvider, _) {
                //     return StockPitchSocialInfo(
                //       email: widget.userEmail,
                //       likes: widget.stockPitchData["likes"],
                //       dislikes: widget.stockPitchData["dislikes"],
                //       pitchNumber: widget.stockPitchData["pitch_number"],
                //     );
                //   },
                // ),
                StockPitchSocialInfo(
                  email: widget.userEmail,
                  likes: widget.stockPitchData["likes"],
                  dislikes: widget.stockPitchData["dislikes"],
                  pitchNumber: widget.stockPitchData["pitch_number"],
                ),
                StockPitchReturnDrawdown(
                  date: date,
                  pitchData: widget.stockPitchData,
                ),
                // StockPitchVideo(
                //   videoLink: "",
                // ),
                Visibility(
                  visible:
                      widget.stockPitchData["videoUrl"] == "" ? false : true,
                  child: StockPitchVideo(
                    videoLink: widget.stockPitchData["videoUrl"],
                    isYoutubeVideo:
                        widget.stockPitchData["is_youtube_video"] ?? 0,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Text(
                            "Investment Thesis",
                            style: TextStyle(
                              fontFamily: "RosarioSemiBold",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${widget.stockPitchData["investment_thesis"]}",
                          style: TextStyle(
                            fontFamily: "Roboto",
                          ),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width - 30,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                  ),
                  child: TopicTags(
                    listOfTags: jsonDecode(
                      widget.stockPitchData["topic_tags"],
                    ),
                  ),
                ),
                StockPitchReturnChart(
                  userEmail: widget.stockPitchData["email"],
                  userInceptionDate: widget.stockPitchData["date"],
                  pitchNumber: widget.stockPitchData["pitch_number"],
                ),
                Visibility(
                  visible: widget.stockPitchData["docUrl"] == "" ? false : true,
                  child: CustomButton(
                    textColor: Colors.white,
                    borderColor: globals.isGoldBlack
                        ? Color(0xFFD8AF4F)
                        : Color(0xFF1D6177),
                    color: globals.isGoldBlack
                        ? Color(0xFFD8AF4F)
                        : Color(0xFF1D6177),
                    text: "View Pitch Doc",
                    callback: _download,
                  ),
                ),
                StockPitchCommentsSection(
                  userEmail: widget.userEmail,
                  pitchNumber: widget.stockPitchData["pitch_number"],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _download() async {
    print("download file save");
    Toast.show(
      "Downloading...",
      context,
    );
    File file = await awsClient.downloadFile(widget.stockPitchData["docUrl"],
        "auro_stock_pitch${widget.stockPitchData["pitch_number"]}");
    if (await file.length() != 0) {
      Toast.show(
        "File Successfully Downloaded",
        context,
      );
    } else {
      Toast.show(
        "Some Error Occurred",
        context,
      );
    }
    print(file.path);
  }
}
