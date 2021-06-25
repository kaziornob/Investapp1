import 'package:auroim/investment_masterclass/api/investment_masterclass_presenter.dart';
import 'package:auroim/investment_masterclass/invesment_masterclass_models/module_details_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'content.dart';
import 'overview.dart';
import 'questionanswer.dart';

class StyleScreen extends StatefulWidget {
  final title;

  const StyleScreen({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  _StyleScreenState createState() => _StyleScreenState();
}

class _StyleScreenState extends State<StyleScreen>
    with TickerProviderStateMixin {
  TabController tabController;
  YoutubePlayerController _controller;
  ValueNotifier<String> heading;
  ValueNotifier<int> currentSelectedClassId = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    heading = ValueNotifier(widget.title);
    tabController = TabController(length: 3, vsync: this);
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        'https://www.youtube.com/watch?v=J_87M2qmie4',
      ),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        forceHD: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    tabController.dispose();
    super.dispose();
  }

  void playFunction(Message msg) {
    print('MESSAGE FROM JAY');
    currentSelectedClassId.value = msg.classId;
    _controller.pause();
    _controller.load(YoutubePlayer.convertUrlToId(msg.link));
    heading.value = msg.classTopic;
    tabController.animateTo(2,
        duration: Duration(milliseconds: 500), curve: Curves.linear);
  }

  void pause() {
    print("pause");
    _controller.pause();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: InvestmentMasterclassPresenter()
              .getModuleDetails("Crypto - Beginners Guide"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
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
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ValueListenableBuilder<String>(
                                valueListenable: heading,
                                builder: (context, value, child) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.50,
                                    child: Text(
                                      value,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  );
                                },
                              ),
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
                            ],
                          ),
                          Column(
                            children: [
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
                                      ),
                                    ),
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
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("105 Like")
                            ],
                          ),
                          Image.asset(
                            "assets/like.png",
                            height: 25,
                            width: 25,
                          ),
                        ],
                      ),
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
                          ContentScreen(
                            moduleDetailsResponseModel: snapshot.data,
                            playFunction: playFunction,
                            pause: pause,
                          ),
                          ValueListenableBuilder<int>(
                            valueListenable: currentSelectedClassId,
                            builder: (context, value, child) {
                              return QuestionAnswerScreen(
                                classId: currentSelectedClassId.value,
                              );
                            },
                          ),
                          /*currentSelectedClass.classId != null ?
                          QuestionAnswerScreen(
                            classId: currentSelectedClass.classId,
                          ):QuestionAnswerScreen(

                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong. Please try again later'),
              );
            }

            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }
}
