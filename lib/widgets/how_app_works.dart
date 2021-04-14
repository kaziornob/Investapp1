import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HowAppWorks extends StatefulWidget {
  final videoLink;

  HowAppWorks({this.videoLink});

  @override
  _HowAppWorksState createState() => _HowAppWorksState();
}

class _HowAppWorksState extends State<HowAppWorks> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoLink),
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
      child: AlertDialog(
        content: Container(
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {},
            onEnded: (YoutubeMetaData metaData) {
              _controller.pause();
            },
          ),
        ),
      ),
    );
  }
}
