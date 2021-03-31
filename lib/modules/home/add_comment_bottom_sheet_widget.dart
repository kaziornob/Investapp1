import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/bussPost/createPoll.dart';
import 'package:auroim/modules/bussPost/portfolioPitch.dart';
import 'package:auroim/modules/bussPost/stockPitch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCommentBottomSheetWidget extends StatefulWidget {
  final heading;

  AddCommentBottomSheetWidget({this.heading});

  @override
  _AddCommentBottomSheetWidgetState createState() =>
      _AddCommentBottomSheetWidgetState();
}

class _AddCommentBottomSheetWidgetState
    extends State<AddCommentBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Wrap(
        children: <Widget>[
          widget.heading == null
              ? SizedBox()
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "${widget.heading}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  textAlign: TextAlign.center,
                  ),
              ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 40.0,
                ),
                CircleAvatar(
                  backgroundColor: AllCoustomTheme.getsecoundTextThemeColor(),
                  radius: 20,
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: AllCoustomTheme.boxColor(),
                  ),
                ),
                SizedBox(
                  width: 40.0,
                ),
                CircleAvatar(
                  backgroundColor: AllCoustomTheme.getsecoundTextThemeColor(),
                  radius: 20,
                  child: Icon(
                    Icons.video_call,
                    color: AllCoustomTheme.boxColor(),
                  ),
                ),
                SizedBox(
                  width: 40.0,
                ),
                CircleAvatar(
                  backgroundColor: AllCoustomTheme.getsecoundTextThemeColor(),
                  radius: 20,
                  child: Icon(
                    Icons.image,
                    color: AllCoustomTheme.boxColor(),
                  ),
                ),
                SizedBox(
                  width: 40.0,
                ),
              ],
            ),
          ),
          Divider(
            color: AllCoustomTheme.getsecoundTextThemeColor(),
          ),
          InkWell(
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text(
                  'Upload stock pitch',
                  style: TextStyle(
                    color: AllCoustomTheme.getTextThemeColors(),
                    fontSize: ConstanceData.SIZE_TITLE18,
                  ),
                ),
              ),
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
          Divider(
            color: AllCoustomTheme.getsecoundTextThemeColor(),
          ),
          InkWell(
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text(
                  'Upload portfolio pitch',
                  style: TextStyle(
                    color: AllCoustomTheme.getTextThemeColors(),
                    fontSize: ConstanceData.SIZE_TITLE18,
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (BuildContext context) => PortfolioPitch(),
                ),
              );
            },
          ),
          Divider(
            color: AllCoustomTheme.getsecoundTextThemeColor(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Center(
              child: Text(
                'Ask a question',
                style: TextStyle(
                  color: AllCoustomTheme.getTextThemeColors(),
                  fontSize: ConstanceData.SIZE_TITLE18,
                ),
              ),
            ),
          ),
          Divider(
            color: AllCoustomTheme.getsecoundTextThemeColor(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Center(
              child: Text(
                'Add a document',
                style: TextStyle(
                  color: AllCoustomTheme.getTextThemeColors(),
                  fontSize: ConstanceData.SIZE_TITLE18,
                ),
              ),
            ),
          ),
          Divider(
            color: AllCoustomTheme.getsecoundTextThemeColor(),
          ),
          InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (BuildContext context) => CreatePoll(),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: Center(
                  child: Text(
                    'Create a poll',
                    style: TextStyle(
                      color: AllCoustomTheme.getTextThemeColors(),
                      fontSize: ConstanceData.SIZE_TITLE18,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
