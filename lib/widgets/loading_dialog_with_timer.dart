import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LoadingDialogWithTimer extends StatefulWidget {
  final text;
  final showTimer;
  final secondaryText;

  const LoadingDialogWithTimer(
      {Key key, this.text, this.showTimer, this.secondaryText})
      : super(key: key);

  @override
  _LoadingDialogWithTimerState createState() => _LoadingDialogWithTimerState();
}

class _LoadingDialogWithTimerState extends State<LoadingDialogWithTimer> {
  Timer _timer;
  bool _isInit = true;
  int _start = 0;
  double percentage = 0.0;
  YoutubePlayerController _controller;



  void startTimer(loadingSetState) {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
        (Timer timer) => loadingSetState(() {
              if (_start >= 120) {
                timer.cancel();
              } else {
                _start = _start + 1;
                setState(() {
                  percentage = _start / 120;
                });
                print(_start / 120);
              }
            }));
  }

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          'https://www.youtube.com/watch?v=RWFXn2Dsb9E'),
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
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, loadingState) {
      if (_isInit && widget.showTimer) {
        startTimer(loadingState);
        _isInit = false;
      }
      return Container(
        margin: EdgeInsets.only(top: 50, bottom: 30),
        child: Dialog(
          backgroundColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.showTimer
                  ? Row(
                      children: [
                        Image.asset(
                          'assets/hourglass.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 15.0, bottom: 8.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "${120 - _start}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontFamily: 'Rosario'),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "Seconds remaining",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Rosario'),
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: LinearPercentIndicator(
                                        //leaner progress bar
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        //width for progress bar
                                        animation: false,
                                        //animation to show progress at first
                                        animationDuration: 1000,
                                        lineHeight: 20.0,
                                        //height of progress bar
                                        percent: percentage,
                                        // 30/100 = 0.3
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        //make round cap at start and end both
                                        progressColor: Color(0xffd8af4f),
                                        //percentage progress bar color
                                        backgroundColor: Color(
                                            0xffe7e7e7), //background progressbar color
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    widget.text == null ? "Please wait..." : widget.text,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              widget.secondaryText != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          widget.secondaryText == null
                              ? "Please wait..."
                              : widget.secondaryText,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.all(20),
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
            ],
          ),
        ),
      );
    });
  }
}

// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// class LoadingDialogWithTimer extends StatefulWidget {
//   final text;
//   final showTimer;
//
//   const LoadingDialogWithTimer({Key key, this.text, this.showTimer})
//       : super(key: key);
//
//   @override
//   _LoadingDialogWithTimerState createState() => _LoadingDialogWithTimerState();
// }
//
// class _LoadingDialogWithTimerState extends State<LoadingDialogWithTimer> {
//   Timer _timer;
//   bool _isInit = true;
//   int _start = 0;
//
//   void startTimer(loadingSetState) {
//     const oneSec = const Duration(seconds: 1);
//     _timer = new Timer.periodic(
//         oneSec,
//         (Timer timer) => loadingSetState(() {
//               if (_start > 120) {
//                 timer.cancel();
//               } else {
//                 _start = _start + 1;
//               }
//             }));
//   }
//
//   @override
//   void dispose() {
//    if( _timer != null){
//      _timer.cancel();
//    }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(builder: (context, loadingState) {
//       if (_isInit && widget.showTimer) {
//         startTimer(loadingState);
//         _isInit = false;
//       }
//       return Container(
//         height: 100,
//         margin: EdgeInsets.only(top: 50, bottom: 30),
//         child: Dialog(
//           backgroundColor: Color(0xff161946),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               widget.showTimer
//                   ? Center(
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 15.0, bottom: 8.0),
//                         child: Container(
//                           child: Text(
//                             "${120 - _start} seconds remaining",
//                             style: TextStyle(
//                               color: const Color(0xFFD9E4E9),
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     )
//                   : SizedBox(),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Center(
//                   child: Text(
//                     widget.text == null ? "Please wait..." : widget.text,
//                     style: TextStyle(color: const Color(0xFFD9E4E9)),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
