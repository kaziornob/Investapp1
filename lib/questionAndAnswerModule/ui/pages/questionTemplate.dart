import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auro/main.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:auro/serverConfigRequest/AllRequest.dart';
import 'package:auro/questionAndAnswerModule/models/question.dart';
import 'package:auro/style/theme.dart' as AppThemeData;
import 'package:toast/toast.dart';
import 'package:video_player/video_player.dart';

class QuestionTemplate extends StatefulWidget {
  final List<Question> questions;

  const QuestionTemplate({Key key, @required this.questions}) : super(key: key);

  @override
  _QuestionTemplateState createState() => _QuestionTemplateState();
}

class _QuestionTemplateState extends State<QuestionTemplate>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int _previousIndex = 0;

  String videoUrl = '';

  Map<int, dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  AllHttpRequest request = new AllHttpRequest();

  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;
  ChewieController _chewieController;

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
  }

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
    var response = await request.postSubmit('submit-assessment', jsonReq);

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
    }
  }

  Widget getOptionList(qusType, options) {
    if (qusType == 'singleanswermcq' || qusType == 'bool') {
      return Card(
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
                      child: Text('${option["option_value"]}'),
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
        ),
      );
    } else if (qusType == 'multianswermcq') {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ...options.map(
              (items) => CheckboxListTile(
                title: Text('${items["option_value"]}'),
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
        ),
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
                        style: new TextStyle(
                          fontFamily: "Poppins",
                          color: Color(0xFF000000),
                          fontSize: 17.5,
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
    Question question = widget.questions[_currentIndex];
    final List<dynamic> options = question.qusOptions;

    return Scaffold(
        key: _key,
        appBar: new AppBar(
          title: new Text("Question"),
          iconTheme:
              new IconThemeData(color: AppThemeData.Colors.AppBarMenuIconColor),
        ),
        body: WillPopScope(
          onWillPop: _onWillPop,
          child: SingleChildScrollView(
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: 15.0, left: 10.0, right: 10.0, bottom: 20.0),
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
                        child: DefaultTextStyle.merge(
                            style: const TextStyle(
                              fontSize: 18.0,
                              letterSpacing: .4,
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
                      visible: true,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.33,
                        width: MediaQuery.of(context).size.width,
                        child: getAnswerList(
                            widget.questions[_currentIndex].defaultAnswer),
                      )),
                  Container(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 50.0, bottom: 16.0),
                        child: RaisedButton(
                          child: Text("Next"),
                          onPressed: _nextSubmit,
                        ),
                      )),
                ]),
          ),
        ));
  }

/*  void _previousSubmit() {
    if (_previousIndex < _currentIndex && _previousIndex != -1) {
      if (this.mounted) {
        setState(() {
          _currentIndex = _previousIndex;
          _previousIndex--;
        });
      }
    }
  }*/

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
          videoPlayerController.dispose();
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
          widget.questions[i].questionType == "multianswermcq" ||
          widget.questions[i].questionType == "bool") {
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

  void showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          margin: EdgeInsets.only(top: 50, bottom: 30),
          child: Dialog(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 8.0),
                  child: new CircularProgressIndicator(),
                )),
                Padding(
                  padding: EdgeInsets.only(left: 110.0, bottom: 10.0, top: 5.0),
                  child: new Text(
                    "Please wait...",
                    style: TextStyle(color: const Color(0xff161946)),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 2), () {
      getSubmittedData();
    });
  }

  Future<bool> _onWillPop() async {
    Navigator.of(context).pop();
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new MyHomePage(index: 0)));
  }
}

enum TrimMode {
  Length,
  Line,
}

class ReadMoreText extends StatefulWidget {
  const ReadMoreText(
    this.data, {
    Key key,
    this.trimExpandedText = ' read less',
    this.trimCollapsedText = ' ...read more',
    this.colorClickableText,
    this.trimLength = 240,
    this.trimLines = 2,
    this.trimMode = TrimMode.Length,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.semanticsLabel,
  })  : assert(data != null),
        super(key: key);

  final String data;
  final String trimExpandedText;
  final String trimCollapsedText;
  final Color colorClickableText;
  final int trimLength;
  final int trimLines;
  final TrimMode trimMode;
  final TextStyle style;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final double textScaleFactor;
  final String semanticsLabel;

  @override
  ReadMoreTextState createState() => ReadMoreTextState();
}

const String _kEllipsis = '\u2026';

const String _kLineSeparator = '\u2028';

class ReadMoreTextState extends State<ReadMoreText> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle effectiveTextStyle = widget.style;
    if (widget.style == null || widget.style.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }

    final textAlign =
        widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start;
    final textDirection = widget.textDirection ?? Directionality.of(context);
    final textScaleFactor =
        widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);
    final overflow = defaultTextStyle.overflow;
    final locale =
        widget.locale ?? Localizations.localeOf(context, nullOk: true);

    final colorClickableText =
        widget.colorClickableText ?? Theme.of(context).accentColor;

    TextSpan link = TextSpan(
      text: _readMore ? widget.trimCollapsedText : widget.trimExpandedText,
      style: effectiveTextStyle.copyWith(
        color: colorClickableText,
      ),
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        // Create a TextSpan with data
        final text = TextSpan(
          style: effectiveTextStyle,
          text: widget.data,
        );

        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaleFactor: textScaleFactor,
          maxLines: widget.trimLines,
          ellipsis: overflow == TextOverflow.ellipsis ? _kEllipsis : null,
          locale: locale,
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;

        // Get the endIndex of data
        bool linkLongerThanLine = false;
        int endIndex;

        if (linkSize.width < maxWidth) {
          final pos = textPainter.getPositionForOffset(Offset(
            textSize.width - linkSize.width,
            textSize.height,
          ));
          endIndex = textPainter.getOffsetBefore(pos.offset);
        } else {
          var pos = textPainter.getPositionForOffset(
            textSize.bottomLeft(Offset.zero),
          );
          endIndex = pos.offset;
          linkLongerThanLine = true;
        }

        var textSpan;
        switch (widget.trimMode) {
          case TrimMode.Length:
            if (widget.trimLength < widget.data.length) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: _readMore
                    ? widget.data.substring(0, widget.trimLength)
                    : widget.data,
                children: <TextSpan>[link],
              );
            } else {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: widget.data,
              );
            }
            break;
          case TrimMode.Line:
            if (textPainter.didExceedMaxLines) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: _readMore
                    ? widget.data.substring(0, endIndex) +
                        (linkLongerThanLine ? _kLineSeparator : '')
                    : widget.data,
                children: <TextSpan>[link],
              );
            } else {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: widget.data,
              );
            }
            break;
          default:
            throw Exception(
                'TrimMode type: ${widget.trimMode} is not supported');
        }

        return RichText(
          textAlign: textAlign,
          textDirection: textDirection,
          softWrap: true,
          //softWrap,
          overflow: TextOverflow.clip,
          //overflow,
          textScaleFactor: textScaleFactor,
          text: textSpan,
        );
      },
    );
    if (widget.semanticsLabel != null) {
      result = Semantics(
//        textDirection: widget.textDirection,
        label: widget.semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }
    return result;
  }
}
