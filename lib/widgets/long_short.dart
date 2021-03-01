import 'package:flutter/material.dart';

class LongShort extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Container(
/*            width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.06,*/
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width/3,
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
                      margin: EdgeInsets.only(left: 27.0, top: 7.0, right: 27.0),
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
                      margin: EdgeInsets.only(left: 27.0, top: 7.0, right: 27.0),
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
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
