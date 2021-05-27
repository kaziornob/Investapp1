import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/provider_abhinav/long_short_provider.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddLongShortVoteComment extends StatefulWidget {
  final heading;
  final ticker;
  final isLong;
  final callback;

  const AddLongShortVoteComment({
    Key key,
    this.heading,
    this.isLong,
    this.ticker,
    this.callback,
  }) : super(key: key);

  @override
  _AddLongShortVoteCommentState createState() =>
      _AddLongShortVoteCommentState();
}

class _AddLongShortVoteCommentState extends State<AddLongShortVoteComment> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            Container(
              height: 100,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.text,
                  maxLines: 4,
                  cursorColor: Colors.grey,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ConstanceData.SIZE_TITLE14,
                  ),
                  decoration: InputDecoration(
                    focusColor: AllCoustomTheme.getTextThemeColor(),
                    fillColor: AllCoustomTheme.getTextThemeColor(),
                    labelText: 'Comment',
                    hintText: 'Write Comment Here....',
                    hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: ConstanceData.SIZE_TITLE14),
                    labelStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: ConstanceData.SIZE_TITLE14,
                        fontWeight: FontWeight.bold),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[600], width: 1.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[600], width: 1.0),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: submit,
                    child: Text("ADD"),
                  ),
                  RaisedButton(
                    onPressed: submit,
                    child: Text("SKIP"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  submit() async {
    var mess = await Provider.of<LongShortProvider>(context, listen: false)
        .castLongShortVote(
      Provider.of<UserDetails>(context, listen: false).userDetails["email"],
      widget.ticker,
      widget.isLong,
      _textEditingController.text.isNotEmpty ? _textEditingController.text : "",
    );
    Navigator.of(context).pop();
    widget.callback();
    Toast.show(
      "$mess",
      context,
      duration: 4,
    );
  }
}
