import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/modules/investRelatedPages/securityFirstPage.dart';
import 'package:auroim/modules/settings/user_profile_page.dart';
import 'package:auroim/provider_abhinav/follow_provider.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:auroim/widgets/crypto_marketplace/single_crypto_details_by_id.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class ShowListOfFollowing extends StatefulWidget {
  final String text;
  final type;
  final otherUserEmail;
  bool getOtherUserData;

  ShowListOfFollowing({
    this.text,
    this.type,
    this.otherUserEmail,
    this.getOtherUserData,
  });

  @override
  _ShowListOfFollowingState createState() => _ShowListOfFollowingState();
}

class _ShowListOfFollowingState extends State<ShowListOfFollowing> {
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.getOtherUserData == true
          ? getFollowingDataForOtherUser()
          : getFollowingData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("future ${widget.type}");
          print("${snapshot.data.length}");
          return Container(
            height: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1.2,
                          color: Color(0xFFD8AF4F),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '${widget.text}',
                      style: new TextStyle(
                          fontFamily: "Roboto",
                          color: Color(0xFFD8AF4F),
                          fontSize: 18.0,
                          letterSpacing: 0.2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          // decoration: BoxDecoration(
                          //   border: Border.all(
                          //     color: Colors.black,
                          //   ),
                          // ),
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Scrollbar(
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      switch (widget.type) {
                                        case "listed":
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SecurityPageFirst(
                                                logo: "logo.png",
                                                callingFrom:
                                                    "Accredited Investor",
                                                companyTicker: snapshot
                                                    .data[index]["value"],
                                              ),
                                            ),
                                          );
                                          break;
                                        case "crypto":
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SingleCryptoCurrencyDetailsById(
                                                coinId: snapshot.data[index]
                                                    ["value"],
                                              ),
                                            ),
                                          );
                                          break;
                                        case "private":
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SingleCryptoCurrencyDetailsById(
                                                coinId: snapshot.data[index]
                                                    ["value"],
                                              ),
                                            ),
                                          );
                                          break;
                                        case "user":
                                          print("user tapped");
                                          print(
                                              "${snapshot.data[index]["value"]}");
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  UserProfilePage(
                                                email: snapshot.data[index]
                                                    ["value"],
                                              ),
                                            ),
                                          );
                                          break;
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 40,
                                      child: CircleAvatar(
                                        radius: 38,
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                          snapshot.data[index]["img_url"],
                                        ),
                                        onBackgroundImageError:
                                            (err, stackTrace) {
                                          print("Image error");
                                        },
                                        // child: Image.network(
                                        //   snapshot.data[index]["img_url"],
                                        //   errorBuilder: (BuildContext context,
                                        //       Object exception,
                                        //       StackTrace stackTrace) {
                                        //     return Image.asset(
                                        //       "assets/full_globe.png",
                                        //     );
                                        //   },
                                        //   fit: BoxFit.fill,
                                        //
                                        // ),
                                      ),
                                    ),

                                    // Container(
                                    //   width: 80.0,
                                    //   height: 80.0,
                                    //   decoration: BoxDecoration(
                                    //     image: DecorationImage(
                                    //       image: snapshot.data[index]
                                    //                   ["img_url"] ==
                                    //               null
                                    //           ? AssetImage(
                                    //               'assets/download.jpeg')
                                    //           : NetworkImage(snapshot
                                    //               .data[index]["img_url"]),
                                    //       fit: BoxFit.contain,
                                    //     ),
                                    //     shape: BoxShape.circle,
                                    //     // borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                                    //     border: new Border.all(
                                    //       color: Color(0xff5A56B9),
                                    //       width: 2.0,
                                    //     ),
                                    //   ),
                                    //   // child: Center(
                                    //   //   child: Text(
                                    //   //       "${snapshot.data[index]["value"]}"),
                                    //   // ),
                                    // ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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

  getFollowingDataForOtherUser() async {
    List allFollowingList = [];
    print("follow button pressed");
    var userEmail = widget.otherUserEmail;
    // if (Provider.of<UserDetails>(context, listen: false).userDetails["email"] !=
    //     null) {
    //   userEmail =
    //   Provider.of<UserDetails>(context, listen: false).userDetails["email"];
    // } else {
    //   await getUserDetails();
    //   Provider.of<UserDetails>(context, listen: false)
    //       .setUserDetails(userAllDetail);
    //   userEmail =
    //   Provider.of<UserDetails>(context, listen: false).userDetails["email"];
    // }
    allFollowingList = await Provider.of<FollowProvider>(context)
        .getFollowing(userEmail, widget.type);
    return allFollowingList;
  }

  getFollowingData() async {
    List allFollowingList = [];
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
    allFollowingList = await Provider.of<FollowProvider>(context)
        .getFollowing(userEmail, widget.type);
    return allFollowingList;
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
