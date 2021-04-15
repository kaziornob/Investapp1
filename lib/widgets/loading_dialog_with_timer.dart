import 'dart:async';

import 'package:flutter/material.dart';

class LoadingDialogWithTimer extends StatefulWidget {
  final text;
  final showTimer;

  const LoadingDialogWithTimer({Key key, this.text, this.showTimer})
      : super(key: key);

  @override
  _LoadingDialogWithTimerState createState() => _LoadingDialogWithTimerState();
}

class _LoadingDialogWithTimerState extends State<LoadingDialogWithTimer> {
  Timer _timer;
  bool _isInit = true;
  int _start = 0;

  void startTimer(loadingSetState) {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
        (Timer timer) => loadingSetState(() {
              if (_start > 120) {
                timer.cancel();
              } else {
                _start = _start + 1;
              }
            }));
  }

  @override
  void dispose() {
   if( _timer != null){
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
        height: 100,
        margin: EdgeInsets.only(top: 50, bottom: 30),
        child: Dialog(
          backgroundColor: Color(0xff161946),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.showTimer
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 8.0),
                        child: Container(
                          child: Text(
                            "${120 - _start} seconds remaining",
                            style: TextStyle(
                              color: const Color(0xFFD9E4E9),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    widget.text == null ? "Please wait..." : widget.text,
                    style: TextStyle(color: const Color(0xFFD9E4E9)),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
