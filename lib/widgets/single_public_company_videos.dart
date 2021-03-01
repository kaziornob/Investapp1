import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SinglePublicCompanyVideos extends StatefulWidget {
  final String allVideosLinkString;

  SinglePublicCompanyVideos({this.allVideosLinkString});

  @override
  _SinglePublicCompanyVideosState createState() =>
      _SinglePublicCompanyVideosState();
}

class _SinglePublicCompanyVideosState extends State<SinglePublicCompanyVideos> {
  List videoLink;
  List<YoutubePlayerController> allControllers = [];
  bool _isInit = true;

  @override
  void initState() {
    print("single videos init");
    print(jsonDecode(widget.allVideosLinkString.replaceAll("\'", "\""))
        .runtimeType);
    videoLink = jsonDecode(widget.allVideosLinkString.replaceAll("\'", "\""));
    print(videoLink[0]);

    for (int i = 0; i < videoLink.length; i++) {
      allControllers.add(
        YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(videoLink[i]),
          flags: YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        ),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    allControllers.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 16,
      height: 150,
      margin: EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
        border: Border.all(
          color: Color(0xff5A56B9),
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(2.0),
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: MediaQuery.of(context).size.height / 2,
        // margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Scrollbar(
          child: ListView.builder(
            itemCount: videoLink.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                // height: 77.0,
                // width: 85.0,
                margin: EdgeInsets.only(top: 2.0, left: 5.0, right: 5.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // decoration: BoxDecoration(
                          //   border: Border.all(
                          //     color: Colors.white,
                          //   ),
                          // ),
                          height: 90,
                          width: 180,
                          child: YoutubePlayer(
                            controller: allControllers[index],
                            // showVideoProgressIndicator: true,
                            onReady: () {
                              print("on ready");
                              allControllers[index].addListener(() {});
                            },
                            liveUIColor: Color(0xff7499C6),
                            bottomActions: [
                              CurrentPosition(),
                              ProgressBar(isExpanded: true),
                              // FullScreenButton(),
                            ],
                            // width: 85,
                            // aspectRatio: 85/55,
                            // actionsPadding: ,
                            // aspectRatio: _controller.,
                            // progressColors: ProgressColors(
                            //   playedColor: Colors.amber,
                            //   handleColor: Colors.amberAccent,
                            // ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: GestureDetector(
                          onTap: () => launch(videoLink[index]),
                          child: Container(
                            height: 25,
                            width: 180,
                            decoration: BoxDecoration(
                              color: Color(0xff7499C6),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              border: Border.all(
                                color: Color(0xff7499C6),
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.youtube,
                                size: 22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
