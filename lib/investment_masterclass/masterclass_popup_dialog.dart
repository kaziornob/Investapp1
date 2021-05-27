import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MasterClassPopupDialogScreen extends StatefulWidget {
  const MasterClassPopupDialogScreen({Key key}) : super(key: key);

  @override
  _MasterClassPopupDialogScreenState createState() => _MasterClassPopupDialogScreenState();
}

class _MasterClassPopupDialogScreenState extends State<MasterClassPopupDialogScreen> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=J_87M2qmie4'),
      flags: YoutubePlayerFlags(
        autoPlay: false,
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
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
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8),
            child: Text(
              'What is value investing?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Amet elit aliquam facilisi vel sagittis id turpis metus leo. Dui cursus elit condimentum tellus mauris eu lorem et in. Ultrices cursus quis hac ac. Neque interdum nisl tortor suspendisse cursus. condimentum tellus mauris eu lorem et in. Ultrices cursus quis hac ac. Neque interdum nisl tortor suspendisse cursus.',
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("100+ Learners"),
                Text("38m"),
                Image.asset(
                  "assets/like.png",
                  width: 25,
                  height: 25,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
