import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/provider_abhinav/stock_pitch_provider.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:auroim/static_data/static_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class StockPitchSocialInfo extends StatefulWidget {
  final email;
  final likes;
  final dislikes;
  final pitchNumber;

  StockPitchSocialInfo({
    Key key,
    this.email,
    this.dislikes,
    this.likes,
    this.pitchNumber,
  }) : super(key: key);

  @override
  _StockPitchSocialInfoState createState() => _StockPitchSocialInfoState();
}

class _StockPitchSocialInfoState extends State<StockPitchSocialInfo> {
  final FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();
  int likes;
  int dislikes;

  @override
  void initState() {
    likes = widget.likes;
    dislikes = widget.dislikes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        [
          _featuredCompaniesProvider.getUserDetailsByUserId(widget.email),
          Provider.of<UserDetails>(context).getUserBadge(),
        ],
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userBadge = snapshot.data[1];
          var userData = snapshot.data[0];
          return Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 5.0),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 15,
                            ),
                          ],
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "${userData["score"]}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(width: 5.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 5.0),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            StaticData.leagues[userData["club"]]["asset_path"],
                            height: 30,
                            width: 30,
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Image.asset(
                          StaticData.badges[userBadge] == null
                              ? StaticData.badges["Challenger"]["asset_path"]
                              : StaticData.badges[userBadge]["asset_path"],
                          height: 30,
                          width: 50,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () => submitLike(
                        1,
                        widget.pitchNumber,
                        widget.email,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 5.0),
                          Image.asset(
                            "assets/like_sharp_gold.png",
                            height: 25,
                            width: 25,
                          ),
                          SizedBox(width: 5.0),
                          Text("$likes")
                        ],
                      ),
                    ),
                    SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () => submitLike(
                        -1,
                        widget.pitchNumber,
                        widget.email,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 5.0),
                          Image.asset(
                            "assets/dislike_sharp_gold.png",
                            height: 25,
                            width: 25,
                          ),
                          SizedBox(width: 5.0),
                          Text("$dislikes"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  submitLike(
    like,
    pitchNumber,
    userEmail,
  ) async {
    var message =
        await Provider.of<StockPitchProvider>(context, listen: false).likePitch(
      like,
      pitchNumber,
      userEmail,
    );

    if (message == "Pitch Liked") {
      setState(() {
        likes = likes + 1;
      });
    } else if (message == "Pitch Disliked") {
      setState(() {
        dislikes = dislikes - 1;
      });
    }
    await Provider.of<StockPitchProvider>(context, listen: false)
        .getStockPitches(userEmail);
    Toast.show(message, context);
    // setState(() {});
  }
}
