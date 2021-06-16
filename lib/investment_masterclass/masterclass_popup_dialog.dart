import 'package:auroim/investment_masterclass/invesment_masterclass_models/module_details_response_model.dart';
import 'package:auroim/investment_masterclass/style.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MasterClassPopupDialogScreen extends StatefulWidget {
  final Message classDetails;

  const MasterClassPopupDialogScreen({Key key, this.classDetails})
      : super(key: key);

  @override
  _MasterClassPopupDialogScreenState createState() =>
      _MasterClassPopupDialogScreenState();
}

class _MasterClassPopupDialogScreenState
    extends State<MasterClassPopupDialogScreen> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.classDetails.link),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        forceHD: true,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
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
              InkWell(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.play_arrow,
                        size: 35,
                        color: Colors.grey,
                      ),
                    )),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Text(
              widget.classDetails.classTopic,
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
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Text(
              widget.classDetails.linkDescription,
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(right: 5),
              alignment: Alignment.center,
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                  )),
              child: Text(
                widget.classDetails.likes.toString(),
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("100+ Learners"),
                Text(widget.classDetails.linkDuration.split("/r")[0]),
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
