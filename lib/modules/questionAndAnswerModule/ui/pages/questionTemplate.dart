import 'dart:convert';
import 'dart:io';

import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/questionAndAnswerModule/models/question.dart';
import 'package:auroim/modules/questionAndAnswerModule/resources/question_api_provider.dart';
import 'package:auroim/modules/questionAndAnswerModule/ui/pages/error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class QuestionTemplate extends StatefulWidget {
  final Question questions;

  const QuestionTemplate({Key key, @required this.questions}) : super(key: key);

  @override
  _QuestionTemplateState createState() => _QuestionTemplateState();
}

class _QuestionTemplateState extends State<QuestionTemplate> {
  bool _isInProgress = false;
  ApiProvider request = new ApiProvider();
  bool answerRequest = false;
  YoutubePlayerController _controller;
  bool fullScreenModeActive = false;

  int _currentIndex = 0;
  String videoUrl = '';
  Map<int, dynamic> _answers = {};

/*  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;
  ChewieController _chewieController;*/

  @override
  void initState() {
    super.initState();
    _answers = {};

/*    videoUrl = widget.questions.videoLink;
    videoPlayerController = VideoPlayerController.network(videoUrl)
    _initializeVideoPlayerFuture = videoPlayerController.initialize();*/
  }

  @override
  void dispose() {
/*    videoPlayerController.pause();
    videoPlayerController.dispose();
    _chewieController.dispose();*/

    if (_controller.value.isFullScreen) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
/*    videoPlayerController.pause();
    videoPlayerController.dispose();
    _chewieController.dispose();*/

    if (_controller.value.isFullScreen) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    _controller.pause();
    super.deactivate();
  }

  Widget getOptionList(qusType, options) {
    if (qusType == 'singleanswermcq' || qusType == 'bool') {
      return Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...options.map(
                (option) => RadioListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text(
                          '${option["option_value"]}',
                          style: TextStyle(
                              fontSize: ConstanceData.SIZE_TITLE16,
                              fontWeight: FontWeight.w400,
                              color: AllCoustomTheme.getTextThemeColors()),
                        ),
                      ),
                    ],
                  ),
                  groupValue: _answers[_currentIndex],
                  value: option["option_value"],
                  onChanged: (value) {
                    setState(() {
                      widget.questions.userAnswer = [];
                      var temp = {
                        "value": "${option["option_value"]}",
                      };
                      widget.questions.userAnswer.add(temp);
                      // _answers[_currentIndex] = option["option_value"];
                    });
                  },
                ),
              ),
            ],
          ));
    } else if (qusType == 'multianswermcq') {
      return Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ...options.map(
                (items) => CheckboxListTile(
                  title: Text(
                    '${items["option_value"]}',
                    style: TextStyle(
                        fontSize: ConstanceData.SIZE_TITLE16,
                        fontWeight: FontWeight.w400,
                        color: answerRequest == false
                            ? Colors.white
                            : (items["is_correct"] == true ||
                                    items["is_correct"] == "true"
                                ? Colors.green
                                : Colors.red)),
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
          ));
    } else {
      return Row();
    }
  }

  getCheckboxItems(optionsData) {
    widget.questions.userAnswer = [];
    for (int i = 0; i < optionsData.length; i++) {
      if (optionsData[i]['checked'] == true) {
        var temp = optionsData[i];
        /* var temp = {
          "value": "${optionsData[i]["option_value"]}",
        };*/
        widget.questions.userAnswer.add(temp);
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

  Widget getVideos(link) {
    var appBar = AppBar();

    if (link != '' && link != null) {
      var videoId = YoutubePlayer.convertUrlToId("$link");
      _controller = YoutubePlayerController(
        initialVideoId: '$videoId',
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          loop: false,
          forceHD: true,
        ),
      );

      return Container(
          height: fullScreenModeActive == false
              ? (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height) /
                  2.5
              : MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () {
                  _controller.addListener(() {
                    if (_controller.value.isFullScreen) {
                      fullScreenModeActive = true;
                    } else {
                      fullScreenModeActive = false;
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeRight,
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown,
                      ]);
                    }
                  });
                },
                onEnded: (YoutubeMetaData metaData) {
                  _controller.pause();
                },
              ),
            ],
          ));
    } else {
      return Container(
        height:
            (MediaQuery.of(context).size.height - appBar.preferredSize.height) /
                2.5,
      );
    }
  }

/*  Widget getS3Videos(link) {
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
  }*/

  checkAnswer() {
    var wrongAnsStatus = false;
    var rightAnsStatus = false;

    if (widget.questions.questionType == "singleanswermcq") {
      var findValue =
          widget.questions.userAnswer[0]["value"].toLowerCase().trim();
      var temp = widget.questions.qusOptions[0]["option_value"]
          .toLowerCase()
          .trim()
          .contains(findValue);
      if (temp == true) {
        rightAnsStatus = true;
      } else {
        wrongAnsStatus = true;
      }
    } else if (widget.questions.questionType == "multianswermcq") {
      var newArray = [];

      for (var i = 0; i < widget.questions.qusOptions.length; i++) {
        var rightValue =
            widget.questions.qusOptions[i]['value'].toLowerCase().trim();

        for (var j = 0; j < widget.questions.userAnswer.length; j++) {
          var userValue =
              widget.questions.userAnswer[j]['value'].toLowerCase().trim();

          if (userValue == rightValue) {
            newArray.add({"value": "$rightValue"});
          }
        }
      }

      if (widget.questions.qusOptions.length == newArray.length &&
          widget.questions.userAnswer.length ==
              widget.questions.qusOptions.length) {
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
    if (widget.questions.userAnswer != null &&
        widget.questions.userAnswer.length != 0) {
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
                            color: Color(0xffffffff)),
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

    Question question = widget.questions;
    final List<dynamic> options = question.qusOptions;

    return Stack(
      children: <Widget>[
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
                        if (widget.questions.userAnswer.length == 0) {
                          _controller.pause();
                          HelperClass.showAlert(context, "Choose option first");
                        } else {
                          _controller.pause();
                          _submit();
                        }
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
                                  tween: Tween<Offset>(
                                      begin: Offset(0, 0), end: Offset(0.2, 0)),
                                  duration: Duration(milliseconds: 500),
                                  cycles: 0,
                                  builder: (anim) => FractionalTranslation(
                                    translation: anim.value,
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color:
                                          AllCoustomTheme.getTextThemeColors(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  top: 15.0,
                                  left: 10.0,
                                  right: 10.0,
                                  bottom: 20.0),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16.0, right: 16.0, top: 5.0),
                                child: DefaultTextStyle.merge(
                                    style: const TextStyle(
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffffffff)),
                                    softWrap: true,
                                    child: Text(
                                      '${widget.questions.question}',
                                    )),
                              )),
                          Divider(),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "*you may find the following video useful before you answer the question",
                                    style: TextStyle(
                                        fontSize: ConstanceData.SIZE_TITLE12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.blueGrey),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "*This question has multiple correct options.",
                                    style: TextStyle(
                                        fontSize: ConstanceData.SIZE_TITLE12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.blueGrey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.30,
                            child: getVideos(widget.questions.videoLink),
/*                      child: getS3Videos(
                          "${widget.questions.videoLink}"),*/
                          ),
                          Divider(),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.0, right: 16.0),
                              child: getOptionList(
                                  widget.questions.questionType, options),
                            ),
                          ),
/*                    Visibility(
                        visible: widget.questions.userAnswer.length!=0,
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.33,
                          width: MediaQuery.of(context).size.width,
                          child: getAnswerList(widget.questions.qusOptions),
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

  Future _submit() async {
    HelperClass.showLoading(context, null, false);

    var questionJson;

    if (widget.questions.questionType == "multianswermcq") {
      var optionsResult = [];

      for (var i = 0; i < widget.questions.userAnswer.length; i++) {
        optionsResult.add("${widget.questions.userAnswer[i]['is_correct']}");
      }

      var answerId = [];

      for (var j = 0; j < widget.questions.userAnswer.length; j++) {
        answerId.add(widget.questions.userAnswer[j]['answer_id']);
      }

      print("answerid: $answerId");
      print("optionsResult : " + optionsResult.toString());

      questionJson = {
        "result": optionsResult,
        "master_id": "${widget.questions.questionId}",
        "diff": widget.questions.diffScore,
        "answer_id": answerId,
      };
    }

    print("questionJson: $questionJson");

    String jsonReq = json.encode(questionJson);

    var jsonReqResp = await request.postSubmitResponse('qa/user_answer', jsonReq);

    var result = json.decode(jsonReqResp.body);
    print("question and answers response: $result");

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      Navigator.pop(context);
      if (result != null &&
          result.containsKey('auth') &&
          result['auth'] == true) {
        if (result['message']['result'] == 'correct answer') {
          setState(() {
            answerRequest = true;
          });
          await Future.delayed(const Duration(seconds: 5));
          getDialog();
        } else {
          Toast.show("${result['message']['result']}", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

          setState(() {
            answerRequest = true;
          });
          await Future.delayed(const Duration(seconds: 4));
          setNextQus();
        }
      }
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
      Navigator.pop(context);
      Toast.show("${result['message']['result']}", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      Navigator.pop(context);
      Toast.show("Something went wrong!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void getDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE18,
              ),
            ),
            content: Text(
              "That is the correct answer. You have earned ${widget.questions.diffScore} coin",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE18,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setNextQus();
                },
              ),
            ],
          );
        });
  }

  setNextQus() async {
    HelperClass.showLoading(
      context,
      null,
      false,
    );
    Question questions = await getQuestions();
    if (questions == null) {
      Navigator.pop(context);
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (_) => ErrorPage(
                message: "There are not enough questions yet.",
              )));
      return;
    }
    Navigator.pop(context);

/*    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => QuestionTemplate(questions: questions)
        ),
        ModalRoute.withName("/qusAnsTemplate")
    );*/

    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (BuildContext context) =>
            QuestionTemplate(questions: questions),
      ),
    );
  }
}
