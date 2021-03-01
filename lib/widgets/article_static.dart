import 'package:flutter/material.dart';

class ArticleStatic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(children: [
        Container(
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height*0.07,
          margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height*0.07,
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
                child: Center(
                  child: Text(
                    'Article 1',
                    style: new TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      color: Color(0xFFFFFFFF), fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.07,
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
                child: Center(
                  child: Text(
                    'Article 2',
                    style: new TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      color: Color(0xFFFFFFFF), fontSize: 15.0,
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
          margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height*0.07,
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
                child: Center(
                  child: Text(
                    'Article 3',
                    style: new TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      color: Color(0xFFFFFFFF), fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.07,
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
                child: Center(
                  child: Text(
                    'Article 4',
                    style: new TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      color: Color(0xFFFFFFFF), fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.06,
          margin: EdgeInsets.only(left:7.0,right:7.0),
          child: Container(
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
                width: MediaQuery.of(context).size.width*0.10,
                margin: EdgeInsets.only(left:47.0,top: 7.0,right: 47.0,bottom: 3.0),
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
                      color: Color(0xFFFFFFFF), fontSize: 15.0,
                    ),
                  ),
                ),
              )
          ),
        ),
      ],),
    );
  }
}
