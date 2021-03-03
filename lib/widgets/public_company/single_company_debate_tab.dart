import 'package:flutter/material.dart';

class SinglePublicCompaniesDebateTab extends StatefulWidget {
  final data;

  SinglePublicCompaniesDebateTab({this.data});
  @override
  _SinglePublicCompaniesDebateTabState createState() =>
      _SinglePublicCompaniesDebateTabState();
}

class _SinglePublicCompaniesDebateTabState
    extends State<SinglePublicCompaniesDebateTab> {
  double _voteValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setVotingBarState) {
        return Column(
          children: [
            Container(
              // decoration: BoxDecoration(border: Border.all()),
              width: MediaQuery.of(context).size.width - 15,
              height: 40,
              child: Center(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Auro Sentiment Score",
                        style: TextStyle(fontFamily: "Rosarivo",fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Color(0xFFfec20f),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Center(
                      child: Text(
                        'Voting bar',
                        style: new TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.black,
                          fontSize: 18.0,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.05,
                  margin: EdgeInsets.all(7.0),
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xff5A56B9),
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
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      thumbColor: Colors.green,
                      overlayColor: Colors.red.withAlpha(32),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 28.0),
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
                        setVotingBarState(() {
                          _voteValue = value;
                        });
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 120,
                      height: 30,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "Vote Long",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        color: Colors.green,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 30,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "Vote Short",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        color: Colors.red,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        Container(
/*            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.06,*/
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFfec20f),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.0),
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.10,
                      margin:
                          EdgeInsets.only(left: 27.0, top: 7.0, right: 27.0),
                      decoration: new BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFfec20f),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Long',
                          style: new TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            color: Color(0xFFFFFFFF),
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFfec20f),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.0),
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.10,
                      margin:
                          EdgeInsets.only(left: 27.0, top: 7.0, right: 27.0),
                      decoration: new BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFfec20f),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Short',
                          style: new TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            color: Color(0xFFFFFFFF),
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          Container(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height*0.07,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.48,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Article 1',
                      style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Color(0xFFFFFFFF),
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.48,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Article 2',
                      style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Color(0xFFFFFFFF),
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
/*            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.07,
            margin: EdgeInsets.only(left:7.0,right:7.0),*/
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.48,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Article 3',
                      style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Color(0xFFFFFFFF),
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.48,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Article 4',
                      style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Color(0xFFFFFFFF),
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.06,
            margin: EdgeInsets.only(left: 7.0, right: 7.0),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.48,
                decoration: new BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFfec20f),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.10,
                  margin: EdgeInsets.only(
                      left: 47.0, top: 7.0, right: 47.0, bottom: 3.0),
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Explore',
                      style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Color(0xFFFFFFFF),
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                )),
          ),
          ],
        );
      },
    );
  }
}
