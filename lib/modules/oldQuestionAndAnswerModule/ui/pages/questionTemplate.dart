import 'dart:convert';
import 'dart:io';

import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/oldQuestionAndAnswerModule/models/question.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import 'package:video_player/video_player.dart';

class QuestionTemplate extends StatefulWidget {
  final List<Question> questions;

  const QuestionTemplate({Key key, @required this.questions}) : super(key: key);

  @override
  _QuestionTemplateState createState() => _QuestionTemplateState();
}

class _QuestionTemplateState extends State<QuestionTemplate> {

  bool _isInProgress = false;

  @override
  void initState() {
    super.initState();
    _answers = {};

    videoUrl = widget.questions[_currentIndex].videoLink;
    //video player
    videoPlayerController = VideoPlayerController.network(videoUrl)
    //..initialize().then((_) async {});
        ;
    _initializeVideoPlayerFuture = videoPlayerController.initialize();
    // loadDetails();
  }


/*  loadDetails() async {
    setState(() {
      _isInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isInProgress = false;
    });
  }*/

  int _currentIndex = 0;
  int _previousIndex = 0;

  String videoUrl = '';

  Map<int, dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  // AllHttpRequest request = new AllHttpRequest();

  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;
  ChewieController _chewieController;


  @override
  void dispose() {
    videoPlayerController.pause();
    videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    videoPlayerController.pause();
    videoPlayerController.dispose();
    _chewieController.dispose();
    super.deactivate();
  }

  Future submitAssessment(requestedData) async {
    var tempJsonReq = {"status": "done", "questions": requestedData};

    String jsonReq = json.encode(tempJsonReq);
    var test = {'localDbStatus': false, 'serverStatus': false};
    return test;

    /*var response = await request.postSubmit('submit-assessment', jsonReq);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON.
      var test = json.decode(response.body);
      return test;
    } else if (response.statusCode == 403) {
      // If the call to the server was successful, parse the JSON.
      var test = json.decode(response.body);
      return test;
    } else {
      var test = {'localDbStatus': false, 'serverStatus': false};
      return test;
    }*/
  }

  Widget getOptionList(qusType, options) {
    if (qusType == 'singleanswermcq' || qusType == 'bool') {
      return Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.white,
          ),
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...options.map(
                    (option) => RadioListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text('${option["option_value"]}',
                          style: TextStyle(
                              fontSize: ConstanceData.SIZE_TITLE16,
                              fontWeight: FontWeight.w400,
                              color: AllCoustomTheme.getTextThemeColors()
                          ),
                        ),
                      ),
                    ],
                  ),
                  groupValue: _answers[_currentIndex],
                  value: option["option_value"],
                  onChanged: (value) {
                    setState(() {
                      widget.questions[_currentIndex].userAnswer = [];
                      var temp = {
                        "value": "${option["option_value"]}",
                      };
                      widget.questions[_currentIndex].userAnswer.add(temp);
                      _answers[_currentIndex] = option["option_value"];
                    });
                  },
                ),
              ),
            ],
          )
      );
    } else if (qusType == 'multianswermcq') {
      return Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.white,
          ),
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ...options.map(
                    (items) => CheckboxListTile(
                  title: Text('${items["option_value"]}',
                    style: TextStyle(
                        fontSize: ConstanceData.SIZE_TITLE16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                    ),
                  ),
                  value: items["checked"],
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Color(0xFF000080),
                  onChanged: (newValue) {
                    setState(() {
                      items["checked"] = newValue;
                    });
                    getCheckboxItems(options);
                  },
                ),
              ),
            ],
          )
      );
    } else {
      return Row();
    }
  }

  getCheckboxItems(optionsData) {
    widget.questions[_currentIndex].userAnswer = [];
    for (int i = 0; i < optionsData.length; i++) {
      if (optionsData[i]['checked'] == true) {
        var temp = {
          "value": "${optionsData[i]["option_value"]}",
        };
        widget.questions[_currentIndex].userAnswer.add(temp);
        _answers[_currentIndex] = optionsData[i]["option_value"];
      }
    }
  }

  Widget getImageView(imagePath) {
    var imageUrlCheck = imagePath
        .contains('data/user/0/tatras.educollab.dev/cache/libCachedImageData');

    if (imageUrlCheck == true) {
      return new Image.file(
        File("${imageUrlCheck.split('"')[1]}"),
        fit: BoxFit.fill,
      );
    } else {
      return new Image.network(
        "$imageUrlCheck",
        fit: BoxFit.fill,
      );
    }
  }

  Widget getS3Videos(link) {
    var appBar = AppBar();
    if (link != '') {
      _chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 3 / 2,
      );

      _chewieController.addListener(() {
        videoPlayerController.pause();
      });

      return Chewie(
        controller: _chewieController,
      );
    } else {
      return Container(
        height:
        (MediaQuery.of(context).size.height - appBar.preferredSize.height) /
            2.5,
      );
    }
  }

  checkAnswer() {
    var wrongAnsStatus = false;
    var rightAnsStatus = false;

    if (widget.questions[_currentIndex].questionType == "singleanswermcq") {
      var findValue = widget.questions[_currentIndex].userAnswer[0]["value"]
          .toLowerCase()
          .trim();
      var temp = widget.questions[_currentIndex].defaultAnswer[0]['value']
          .toLowerCase()
          .trim()
          .contains(findValue);
      if (temp == true) {
        rightAnsStatus = true;
      } else {
        wrongAnsStatus = true;
      }
    } else if (widget.questions[_currentIndex].questionType ==
        "multianswermcq") {
      var newArray = [];

      for (var i = 0;
      i < widget.questions[_currentIndex].defaultAnswer.length;
      i++) {
        var rightValue = widget
            .questions[_currentIndex].defaultAnswer[i]['value']
            .toLowerCase()
            .trim();

        for (var j = 0;
        j < widget.questions[_currentIndex].userAnswer.length;
        j++) {
          var userValue = widget.questions[_currentIndex].userAnswer[j]['value']
              .toLowerCase()
              .trim();

          if (userValue == rightValue) {
            newArray.add({"value": "$rightValue"});
          }
        }
      }

      if (widget.questions[_currentIndex].defaultAnswer.length ==
          newArray.length &&
          widget.questions[_currentIndex].userAnswer.length ==
              widget.questions[_currentIndex].defaultAnswer.length) {
        rightAnsStatus = true;
      } else {
        wrongAnsStatus = true;
      }
    }

    var returnData = {
      "wrongAnsStatus": wrongAnsStatus,
      "rightAnsStatus": rightAnsStatus
    };
    return returnData;
  }

  Widget getAnswerList(data) {
    if (widget.questions[_currentIndex].userAnswer != null &&
        widget.questions[_currentIndex].userAnswer.length != 0) {
      var respData = checkAnswer();

      var wrongAns = respData['wrongAnsStatus'];
      var rightAns = respData['rightAnsStatus'];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Visibility(
            visible: rightAns,
            child: Padding(
              padding: EdgeInsets.only(top: 5.0, left: 30.0),
              child: Text(
                "Voila, that's the right answer!",
                style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Color(0xff008000),
                  fontSize: 19.5,
                ),
              ),
            ),
          ),
          Visibility(
            visible: wrongAns,
            child: Padding(
              padding: EdgeInsets.only(top: 5.0, left: 30.0),
              child: Text(
                "Oops, that 's incorrect! The right answer was:",
                style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Color(0xFFe70b31),
                  fontSize: 19.5,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 5.0),
            child: new ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, left: 30.0),
                      child: Text(
                        "${index + 1}" + ". " + "${data[index]['value']}",
                        style: TextStyle(
                            fontSize: ConstanceData.SIZE_TITLE16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffffffff)
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          )
        ],
      );
    } else {
      return Container(
        height: 0.0,
        width: 0.0,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;

    Question question = widget.questions[_currentIndex];
    final List<dynamic> options = question.qusOptions;

    return Stack(
      children: <Widget>[
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
              ],
            ),
          ),
        ),
        Scaffold(
          backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 14, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                    height: 50,
                    child: GestureDetector(
                      onTap: () {
                        _nextSubmit();
                      },
                      child: Animator(
                        tween: Tween<double>(begin: 0.8, end: 1.1),
                        curve: Curves.easeInToLinear,
                        cycles: 0,
                        builder: (anim) => Transform.scale(
                          scale: anim.value,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              border: new Border.all(
                                  color: Colors.white, width: 1.5),
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  globals.buttoncolor1,
                                  globals.buttoncolor2,
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: AllCoustomTheme.getTextThemeColors(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          body: ModalProgressHUD(
            inAsyncCall: _isInProgress,
            opacity: 0,
            progressIndicator: CupertinoActivityIndicator(
              radius: 12,
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: !_isInProgress
                    ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: appBarheight,
                    ),
                    Row(
                      children: <Widget>[
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Animator(
                            tween: Tween<Offset>(begin: Offset(0, 0), end: Offset(0.2, 0)),
                            duration: Duration(milliseconds: 500),
                            cycles: 0,
                            builder: (anim) => FractionalTranslation(
                              translation: anim.value,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: AllCoustomTheme.getTextThemeColors(),
                              ),
                            ),
                          ),
                        ),
/*                        Expanded(
                          child: Animator(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.decelerate,
                            cycles: 1,
                            builder: (anim) => Transform.scale(
                              scale: anim.value,
                              child: Container(
                                  height: MediaQuery.of(context).size.height * 0.07,
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  child: Center(
                                    child: new Image(
                                        width: 270.0,
                                        fit: BoxFit.fill,
                                        image: new AssetImage('assets/logo.png')
                                    ),
                                  )
                              ),
                            ),
                          ),
                        )*/
                      ],
                    ),

                    // nitin sir you have to start your code from there.
                    Container(
                        margin: EdgeInsets.only(
                            top: 15.0, left: 10.0, right: 10.0, bottom: 20.0),
                        child: Padding(
                          padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
                          child: DefaultTextStyle.merge(
                              style: const TextStyle(
                                  fontSize: ConstanceData.SIZE_TITLE16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffffffff)
                              ),
                              softWrap: true,
                              child: Text(
                                '${widget.questions[_currentIndex].question}',
                              )),
                        )),
                    Divider(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: getS3Videos(
                          "${widget.questions[_currentIndex].videoLink}"),
                    ),
                    Divider(),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        child: getOptionList(
                            widget.questions[_currentIndex].questionType,
                            options),
                      ),
                    ),
                    Visibility(
                        visible: widget.questions[_currentIndex].userAnswer.length!=0,
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.33,
                          width: MediaQuery.of(context).size.width,
                          child: getAnswerList(widget.questions[_currentIndex].defaultAnswer),
                        )
                    ),
/*                    Container(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 50.0, bottom: 16.0),
                            child: RaisedButton(
                              color: AllCoustomTheme.getTextThemeColors(),
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "WorkSansBold"),
                              ),
                              onPressed: ()
                              {
                                _nextSubmit();
                              },
                            )
                        )
                    ),*/

                  ],
                )
                    : SizedBox(),
              ),
            ),
          ),
        )
      ],
    );
  }

  void _nextSubmit() {
    if (_currentIndex < (widget.questions.length - 1)) {
      if (this.mounted) {
        setState(() {
          _previousIndex = _currentIndex;

          if (_answers[_currentIndex] == null) {
            _answers[_currentIndex] = null;
          }
          _currentIndex++;
          videoUrl = widget.questions[_currentIndex].videoLink;
          // videoPlayerController.dispose();

          videoPlayerController = VideoPlayerController.network(
            videoUrl,
          );
          _initializeVideoPlayerFuture = videoPlayerController.initialize();
          print("changing video");
        });
      }
    } else {
      if ((widget.questions[_currentIndex].userAnswer != null &&
          widget.questions[_currentIndex].userAnswer.length == 0) ||
          (widget.questions[_currentIndex].userAnswer == null)) {
        _answers[_currentIndex] = null;
      }
    }
  }

  Future<void> getSubmittedData() async {
    var questionJson = [];

    for (var i = 0; i < widget.questions.length; i++) {
      if (widget.questions[i].questionType == "singleanswermcq" ||
          widget.questions[i].questionType == "multianswermcq") {
        var tempOptions = [];

        for (var j = 0; j < widget.questions[i].qusOptions.length; j++) {
          var optionData = {
            "option_value":
            "${widget.questions[i].qusOptions[j]['option_value']}"
          };
          tempOptions.add(optionData);
        }

        var tempRow = {
          "question_id": "${widget.questions[i].questionId}",
          "question_text": "${widget.questions[i].question}",
          "question_type": "${widget.questions[i].questionType}",
          "answer": widget.questions[i].userAnswer == null
              ? []
              : widget.questions[i].userAnswer,
          "option": tempOptions
        };

        questionJson.add(tempRow);
      }
    }

    var value = await submitAssessment(questionJson);
    Navigator.pop(context);

    if (value.containsKey('message') && value['message'] != "") {
      Toast.show("${value['message']}!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.pop(context);
    }
  }
}
