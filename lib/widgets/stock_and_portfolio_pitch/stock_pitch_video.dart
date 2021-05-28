import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StockPitchVideo extends StatefulWidget {
  final String videoLink;

  const StockPitchVideo({Key key, this.videoLink}) : super(key: key);

  @override
  _StockPitchVideoState createState() => _StockPitchVideoState();
}

class _StockPitchVideoState extends State<StockPitchVideo> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://auro-invest.s3-us-west-2.amazonaws.com/Stock-Security+Pitch/One+Piece+Nami+Funny+Moments+English+Dub.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            child: _controller.value.initialized
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
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: !_controller.value.isPlaying,
                            child: Positioned(
                              top: 90 - 37.0,
                              left: ((MediaQuery.of(context).size.width - 30) /
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
                : Container(),
          ),
        ],
      ),
    );
  }
}
