import 'dart:io';
import 'package:auroim/modules/bussPost/portfolioPitch.dart';
import 'package:auroim/modules/bussPost/stockPitch.dart';
import 'package:auroim/modules/home/create_a_poll.dart';
import 'package:auroim/modules/home/vote_long_short.dart';
import 'package:auroim/modules/qaInvForumPages/addEditQus.dart';
import 'package:auroim/reusables/local_pick_file.dart';
import 'package:auroim/widgets/aws/aws_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCommentBottomSheetWidget extends StatefulWidget {
  final Function attackFileCallback;

  const AddCommentBottomSheetWidget({
    Key key,
    this.attackFileCallback,
  }) : super(key: key);

  @override
  _AddCommentBottomSheetWidgetState createState() =>
      _AddCommentBottomSheetWidgetState();
}

class _AddCommentBottomSheetWidgetState
    extends State<AddCommentBottomSheetWidget> {
  AWSClient _awsClient = AWSClient();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(
        top: 10.0,
        bottom: 20.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.height / 10,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                circleWidget(FontAwesomeIcons.filePdf, FileType.any),
                circleWidget(Icons.video_call, FileType.video),
                circleWidget(FontAwesomeIcons.image, FileType.image),
              ],
            ),
          ),
          InkWell(
            child: singleLine(
              "assets/growth_arrow_with_thick_bars.png",
              'Upload stock pitch',
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (BuildContext context) => StockPitch(),
                ),
              );
            },
          ),
          InkWell(
            child: singleLine(
              "assets/speaker_gold.png",
              'Add Vote Long/Short',
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (BuildContext context) => VoteLongShort(),
                ),
              );
            },
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => PortfolioPitch(),
                ),
              );
            },
            child: singleLine(
              "assets/bag_gold.png",
              'Upload Portfolio Pitch',
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (BuildContext context) => AddEditQus(),
                ),
              );
            },
            child: singleLine(
              "assets/ask_question.png",
              "Ask a question",
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: singleLine(
              "assets/users_outline.png",
              "Apply for job",
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (BuildContext context) => CreateAPoll(),
                ),
              );
            },
            child: singleLine(
              "assets/solid_poll.png",
              "Create a poll",
            ),
          ),
        ],
      ),
    );
  }

  singleLine(assetPath, text) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20,
            ),
            child: Image.asset(
              assetPath,
              width: 40,
              height: 30,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "RosarioSemiBold",
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  circleWidget(icon, FileType fileType) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pop();
        widget.attackFileCallback(fileType);
      },
      child: CircleAvatar(
        backgroundColor: Color(0xFFD8AF4F),
        radius: 30,
        child: CircleAvatar(
          radius: 29,
          backgroundColor: Colors.white,
          child: Icon(
            icon,
            color: Color(0xFFD8AF4F),
            size: 30,
          ),
        ),
      ),
    );
  }
}
