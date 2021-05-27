import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'content.dart';
import 'overview.dart';
import 'questionanswer.dart';

class StyleScreen extends StatefulWidget {
  const StyleScreen({Key key}) : super(key: key);

  @override
  _StyleScreenState createState() => _StyleScreenState();
}

class _StyleScreenState extends State<StyleScreen>
    with TickerProviderStateMixin {
  TabController tabController;
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          'https://www.youtube.com/watch?v=J_87M2qmie4'),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  onReady: () {},
                  onEnded: (YoutubeMetaData metaData) {
                    _controller.pause();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Stylistic Investing",
                      style: TextStyle(fontSize: 25),
                    ),
                    Column(
                      children: [
                        Container(
                          child: RatingBar.builder(
                            itemSize: 20,
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              size: 5,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 40),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    "assets/person_avatar.png",
                                    height: 35,
                                    width: 35,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    "assets/person_avatar.png",
                                    height: 35,
                                    width: 35,
                                  )),
                            ),
                            Container(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    "assets/person_avatar.png",
                                    height: 35,
                                    width: 35,
                                  )),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/like.png",
                      height: 25,
                      width: 25,
                    ),
                    Text("105 Learners Like This")
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: TabBar(
                  physics: NeverScrollableScrollPhysics(),
                  indicatorColor: Colors.black,
                  controller: tabController,
                  labelPadding: EdgeInsets.only(bottom: 7),
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Text(
                      "Overview",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                    Text(
                      "Content",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                    Text(
                      "Q&A",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    OverViewScreen(),
                    ContentScreen(),
                    QuestionAnswerScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
