import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/provider_abhinav/follow_provider.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:auroim/widgets/public_company/single_notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class KeySocialInvestIndicators extends StatefulWidget {
  final fixRate;
  final companyTicker;

  KeySocialInvestIndicators({this.fixRate, this.companyTicker});

  @override
  _KeySocialInvestIndicatorsState createState() =>
      _KeySocialInvestIndicatorsState();
}

class _KeySocialInvestIndicatorsState extends State<KeySocialInvestIndicators> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 15,
        height: 245,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                bottom: 4.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    width: 60,
                    child: Center(
                      child: Text(
                        "${widget.fixRate}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    // color: Colors.grey[300],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: 150,
                    height: 30,
                    // color: Colors.grey[300],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_drop_up_outlined,
                          color: Colors.green,
                        ),
                        Text(
                          "+0.50(+0.41%)",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 2.0,
                right: 2.0,
                top: 8.0,
                bottom: 4.0,
              ),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 3.0),
                    width: (MediaQuery.of(context).size.width / 3) - 10,
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Color(0xff4472C4),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      color: Color(0xff4472C4),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Ask Auro',
                          style: new TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 18.0,
                            letterSpacing: 0.2,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3.0),
                    width: (MediaQuery.of(context).size.width / 3) - 10,
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Color(0xff4472C4),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      color: Color(0xff4472C4),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Trade',
                          style: new TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 18.0,
                            letterSpacing: 0.2,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Consumer<FollowProvider>(
                    builder: (context, followProvider, _) {
                      var isFollowing = false;
                      if (followProvider.mapOfFollowingListedCompanies[
                              widget.companyTicker] !=
                          null) {
                        isFollowing =
                            followProvider.mapOfFollowingListedCompanies[
                                widget.companyTicker];
                      }
                      return GestureDetector(
                        onTap: () => onPressedFollow(isFollowing),
                        child: Container(
                          margin: EdgeInsets.only(top: 3.0),
                          width: (MediaQuery.of(context).size.width / 3) - 10,
                          decoration: new BoxDecoration(
                            border: Border.all(
                              color: Color(0xff90AADC),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            color: Color(0xff90AADC),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                isFollowing ? "Unfollow" : 'Follow',
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 18.0,
                                  letterSpacing: 0.2,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: Color(0xFFfec20f),
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(bottom: 4.0),
                  child: Center(
                    child: Text(
                      "Key Social Invest Indicators",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Rosarivo",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  SingleNotificationTile(
                    trailingText: "had Q&A on this stock",
                  ),
                  SingleNotificationTile(
                    trailingText: "own this stock",
                  ),
                  SingleNotificationTile(
                    trailingText: "follow this stock",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onPressedFollow(isFollowing) async {
    print("follow button pressed");
    var userEmail;
    if (Provider.of<UserDetails>(context, listen: false).userDetails["email"] !=
        null) {
      userEmail =
          Provider.of<UserDetails>(context, listen: false).userDetails["email"];
    } else {
      await getUserDetails();
      Provider.of<UserDetails>(context, listen: false)
          .setUserDetails(userAllDetail);
      userEmail =
          Provider.of<UserDetails>(context, listen: false).userDetails["email"];
    }

    if (isFollowing) {
      Provider.of<FollowProvider>(context, listen: false).unfollowSingleItem(
        userEmail,
        "listed",
        widget.companyTicker,
        context,
      );
    } else {
      Provider.of<FollowProvider>(context, listen: false).setFollowing(
        userEmail,
        "listed",
        widget.companyTicker,
        context,
      );
    }
  }

  getUserDetails() async {
    print("getting user Details");
    ApiProvider request = new ApiProvider();
    // print("call set screen");
    var response = await request.getRequest('users/get_details');
    print("user detail response: $response");
    if (response != null && response != false) {
      userAllDetail = response['data'];

      print(userAllDetail.toString());
    } else {
      print("Not got user data");
    }
  }
}
