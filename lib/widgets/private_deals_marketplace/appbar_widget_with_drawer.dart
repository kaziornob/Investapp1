import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppbarWidgetWithDrawer extends StatefulWidget {
  final VoidCallback callback;
  final String hintText;

  AppbarWidgetWithDrawer({this.callback, this.hintText});

  @override
  _AppbarWidgetWithDrawerState createState() => _AppbarWidgetWithDrawerState();
}

class _AppbarWidgetWithDrawerState extends State<AppbarWidgetWithDrawer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // Stack(
        //   alignment: Alignment.bottomRight,
        //   children: <Widget>[
        //     Padding(
        //       padding: EdgeInsets.only(top: 4.0),
        //       child: CircleAvatar(
        //         radius: 20.0,
        //         backgroundImage: new AssetImage('assets/download.jpeg'),
        //         backgroundColor: Colors.transparent,
        //       ),
        //     ),
        //     FractionalTranslation(
        //       translation: Offset(0.4, 0.2),
        //       child: GestureDetector(
        //         onTap: widget.callback,
        //         child: CircleAvatar(
        //           backgroundColor: Colors.white,
        //           radius: 11.0,
        //           child: Icon(
        //             Icons.sort_outlined,
        //             size: 16,
        //             color: Colors.black,
        //           ),
        //         ),
        //       ),
        //     )
        //   ],
        // ),
        Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.bars,
              size: 28,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          // CircleAvatar(
          //   radius: 20.0,
          //   backgroundImage: new AssetImage('assets/download.jpeg'),
          //   backgroundColor: Colors.transparent,
          // ),
        ),
        //search box area
        Container(
          margin: EdgeInsets.only(top: 10.0, left: 13.0),
          decoration: new BoxDecoration(
            color: Color(0xFFFFFFFF),
            border: Border.all(
              color: Color(0xff696969),
              width: 1.5,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.58,
                height: MediaQuery.of(context).size.height * 0.05,
                child: TextFormField(
                  style: TextStyle(
                    color: AllCoustomTheme.getTextThemeColors(),
                    fontSize: ConstanceData.SIZE_TITLE14,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      FontAwesomeIcons.search,
                      color: AllCoustomTheme.getNewSecondTextThemeColor(),
                      size: 15,
                    ),
                    hintText: widget.hintText == null
                        ? "Search"
                        : "${widget.hintText}",
                    hintStyle: TextStyle(
                      color: AllCoustomTheme.getNewSecondTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: 5,
        ),
        //globe icon
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 3.0),
              child: Image(
                  height: 40,
                  width: 40,
                  image: new AssetImage('assets/appIcon.png')),
            ),
            FractionalTranslation(
              translation: Offset(-0.5, 0.0),
              child: GestureDetector(
                onTap: () {
                  // _homeScaffoldKey.currentState.openDrawer();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 6.0,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
