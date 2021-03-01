import 'package:flutter/material.dart';

class VotingBar extends StatefulWidget {
  @override
  _VotingBarState createState() => _VotingBarState();
}

class _VotingBarState extends State<VotingBar> {
  double _voteValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.0, left: 10.0),
            child: Text(
              'Voting bar',
              style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Color(0xFFFFFFFF),
                  fontSize: 14.0,
                  letterSpacing: 0.2),
            ),
          ),
          Container(
            // width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.05,
            margin: EdgeInsets.all(7.0),
            decoration: new BoxDecoration(
              border: Border.all(
                color: Color(0xFFfec20f),
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(2.0),
              ),
            ),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.green,
                inactiveTrackColor: Colors.red[100],
                trackShape: RoundedRectSliderTrackShape(),
                trackHeight: 4.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                thumbColor: Colors.green,
                overlayColor: Colors.red.withAlpha(32),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                tickMarkShape: RoundSliderTickMarkShape(),
                activeTickMarkColor: Colors.green,
                inactiveTickMarkColor: Colors.red[100],
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                valueIndicatorColor: Colors.green,
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: Slider(
                value: _voteValue,
                min: 0,
                max: 100,
                divisions: 10,
                label: '$_voteValue',
                onChanged: (value) {
                  setState(
                    () {
                      _voteValue = value;
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
