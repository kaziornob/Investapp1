import 'dart:convert';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/modules/home/homeScreen.dart';
import 'package:auroim/reusable_widgets/customButton.dart';
import 'package:auroim/reusable_widgets/screen_title_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:toast/toast.dart';
import 'package:auroim/constance/global.dart' as globals;

class QusView extends StatefulWidget {
  final allParams;

  const QusView({Key key, @required this.allParams}) : super(key: key);

  @override
  _QusViewState createState() => _QusViewState();
}

class _QusViewState extends State<QusView> {
  bool _isInProgress = false;
  bool _isClickOnSubmit = false;
  ApiProvider request = new ApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              ScreenTitleAppbar(
                title: "PREVIEW",
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  left: 12,
                ),
                child: Row(
                  children: [
                    Text(
                      "Bounty : ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${widget.allParams["bounty"]}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, top: 30.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 24,
                  // decoration: BoxDecoration(border: Border.all()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title:",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        child: Text(
                          "${widget.allParams['title']}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, top: 30.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 24,
                  // decoration: BoxDecoration(border: Border.all()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description:",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        child: Text(
                          "${widget.allParams['body']}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  child: StaggeredGridView.countBuilder(
                    itemCount: widget.allParams['tags'] != null
                        ? widget.allParams['tags'].length
                        : 0,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    shrinkWrap: true,
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: globals.isGoldBlack
                              ? Color(0xFF1A3263)
                              : Color(0xFF7499C6),
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                            color: globals.isGoldBlack
                                ? Color(0xFF1A3263)
                                : Color(0xFF7499C6),
                            width: 1.0,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '${widget.allParams['tags'][index].tag}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ConstanceData.SIZE_TITLE16,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              CustomButton(
                textColor: Colors.white,
                borderColor:
                    globals.isGoldBlack ? Color(0xFFD8AF4F) : Color(0xFF1D6177),
                color:
                    globals.isGoldBlack ? Color(0xFFD8AF4F) : Color(0xFF1D6177),
                text: "Submit",
                callback: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _submit() async {
    var qusTitle = widget.allParams['title'];
    var qusBody = widget.allParams['body'];
    // var tagData= [];

    Map<String, String> tagData = {};

    for (var i = 0; i < widget.allParams['tags'].length; i++) {
      tagData.addAll({
        "${widget.allParams['tags'][i].id}":
            '${widget.allParams['tags'][i].tag}'
      });
    }

    print("tags: $tagData");

    var tempJsonReq = {
      "question_title": "$qusTitle",
      "body": "$qusBody",
      "tags": tagData,
      "bounty": widget.allParams["bounty"],
    };
    String jsonReq = json.encode(tempJsonReq);

    print("jsonReq: $jsonReq");

    var jsonReqResp =
        await request.postSubmitResponse('forum/create_question', jsonReq);
    var result = json.decode(jsonReqResp.body);

    print("qus add/edit response: $result");

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      if (result != null &&
          result.containsKey('auth') &&
          result['auth'] == true &&
          result["message"]["message"] == "Question created successfully") {
        // ${result['message']}
        Toast.show(result["message"]["message"], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

        setState(() {
          _isClickOnSubmit = false;
        });

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            ModalRoute.withName("/Home"));
        // Navigator.of(context).pop();
        // Navigator.of(context).pop();
        // setState(() {
        //   print("hhhhhhhhhhhh");
        // });
      } else {
        Toast.show(result["message"]["message"], context,
            duration: 3, gravity: Toast.BOTTOM);

        setState(() {
          _isClickOnSubmit = false;
        });
      }
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
      Toast.show("oops! question not added", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      setState(() {
        _isClickOnSubmit = false;
      });
    } else {
      setState(() {
        _isClickOnSubmit = false;
      });
      Toast.show("Something went wrong!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
