import 'package:flutter/material.dart';

// import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StockPitchVideo extends StatefulWidget {
  final String videoLink;
  final bool isYoutubeVideo;

  const StockPitchVideo({
    Key key,
    this.videoLink,
    this.isYoutubeVideo,
  }) : super(key: key);

  @override
  _StockPitchVideoState createState() => _StockPitchVideoState();
}

class _StockPitchVideoState extends State<StockPitchVideo> {
  VideoPlayerController _controller;
  YoutubePlayerController _youtubePlayerController;
  ChewieController chewieController;

  @override
  void initState() {
    print(widget.videoLink);
    super.initState();
    _controller = VideoPlayerController.network(widget.videoLink)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      }).catchError((err) {
        print("video player");
        print(err.toString());
      }).whenComplete(
        () => print("Video Completed"),
      );
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoLink) ?? "",
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        forceHD: true,
      ),
    );
    // chewieController = ChewieController(
    //   videoPlayerController: _controller,
    //   aspectRatio: 3 / 2,
    //   autoPlay: true,
    //   looping: true,
    // );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("Controller value initial : ${_controller.value.initialized}");
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Text(
                  "Pitch Video",
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
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black),
              color: Colors.black,
            ),
            height: 180,
            width: MediaQuery.of(context).size.width - 30,
            child: widget.isYoutubeVideo
                ? Container(
                    width: MediaQuery.of(context).size.width - 30,
                    height: 180,
                    child: YoutubePlayer(
                      controller: _youtubePlayerController,
                      showVideoProgressIndicator: true,
                      onReady: () {},
                      onEnded: (YoutubeMetaData metaData) {
                        _controller.pause();
                      },
                    ),
                  )
                : _controller.value.initialized
                    ? GestureDetector(
                        onTap: () {
                          if (_controller.value.isPlaying) {
                            setState(() {
                              _controller.pause();
                            });
                          } else {
                            setState(() {
                              _controller.play();
                            });
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 30,
                          height: 180,
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.black,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AspectRatio(
                                      aspectRatio:
                                          _controller.value.aspectRatio,
                                      child: VideoPlayer(
                                        _controller,
                                      ),
                                    ),
                                    // Chewie(
                                    //   controller: chewieController,
                                    // ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: !_controller.value.isPlaying,
                                child: Positioned(
                                  top: 90 - 37.0,
                                  left: ((MediaQuery.of(context).size.width -
                                              30) /
                                          2) -
                                      37,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _controller.play();
                                      });
                                    },
                                    child: Image.asset(
                                      "assets/youtube-logo.png",
                                      width: 74,
                                      height: 74,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
